import 'dart:developer';

import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/core/widgets/my_error_widget.dart';
import 'package:cloud_medix/features/settings/data/user.dart';
import 'package:cloud_medix/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:cloud_medix/features/settings/presentation/components/building_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().getSettings();
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
            return Center(child: MyErrorWidget(message: state.message));
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
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset('assets/images/user.svg'),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(Icons.upload,
                          size: 18, color: Colors.deepPurple),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  "UserName",
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
                buildInput(label: "Height", value: "5 feet 10 inches"),
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
