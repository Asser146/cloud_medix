import 'dart:convert';
import 'dart:io';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/server_error_widget.dart';
import 'package:cloud_medix/features/settings/data/user.dart';
import 'package:cloud_medix/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:cloud_medix/features/settings/presentation/components/building_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = const FlutterSecureStorage();
  File? _selectedImage;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().getSettings();
    _loadSavedImage();
  }

  Future<void> _pickAndSaveImage() async {
    final userImageNotifier = getIt<ValueNotifier<String?>>();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final userId = await storage.read(key: "id");
      if (userId == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}";
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');

      final prefs = await SharedPreferences.getInstance();
      const key = "user_image_map";
      final rawMap = prefs.getString(key);

      Map<String, String> imageMap = {};
      if (rawMap != null) {
        imageMap = Map<String, String>.from(jsonDecode(rawMap));
      }

      imageMap[userId] = savedImage.path;
      await prefs.setString(key, jsonEncode(imageMap));

      setState(() {
        _selectedImage = savedImage;
        _imagePath = savedImage.path;
        userImageNotifier.value = savedImage.path;
      });
    }
  }

  Future<void> _loadSavedImage() async {
    final userId = await storage.read(key: "id");
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    const key = "user_image_map";
    final rawMap = prefs.getString(key);

    if (rawMap != null) {
      final imageMap = Map<String, String>.from(jsonDecode(rawMap));
      final path = imageMap[userId];

      if (path != null && File(path).existsSync()) {
        setState(() {
          _selectedImage = File(path);
          _imagePath = path;
        });
      }
    }
  }

  void _showEditDialog(
      {required Widget form, required String title, required User user}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: form),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsCubit>().updateSettings(user);
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SettingsCubit>();

    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: MyAppBar(title: "Profile", isSettings: true),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is SettingsError) {
            return Center(child: ServerErrorWidget(message: state.message));
          } else if (state is SettingsUpdated) {
            cubit.user = state.user;
          }

          final user = cubit.user;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      child: _selectedImage == null
                          ? SvgPicture.asset('assets/images/user.svg')
                          : null,
                    ),
                    GestureDetector(
                      onTap: _pickAndSaveImage,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16,
                        child: Icon(Icons.upload,
                            size: 18, color: Colors.deepPurple),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  user.userName ?? "UserName",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                buildInput(
                    label: "First Name", value: user.fullName.split(' ')[0]),
                buildInput(
                    label: "Last Name", value: user.fullName.split(' ').last),
                buildInput(label: "Mobile Number", value: user.phone),
                buildInput(label: "Age", value: calculateAge(user.date)),
                buildInput(label: "National ID", value: user.nationalID),
                buildInput(label: "Weight", value: "70 kgs"),
                buildInput(label: "Height", value: "180 cm"),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("Address",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => _showEditDialog(
                            title: "Edit Address",
                            form: buildAddressForm(user),
                            user: user),
                        icon:
                            Icon(Icons.edit, color: ColorsManager.primaryColor),
                      ),
                    ],
                  ),
                ),
                ...buildAddress(user.address),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("Emergency Contact",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => _showEditDialog(
                            title: "Edit Emergency Contact",
                            form: buildEmergencyContactForm(user),
                            user: user),
                        icon:
                            Icon(Icons.edit, color: ColorsManager.primaryColor),
                      ),
                    ],
                  ),
                ),
                buildEmergencyContact(user: user)
              ],
            ),
          );
        },
      ),
    );
  }
}
