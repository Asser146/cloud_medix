import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:cloud_medix/features/settings/presentation/components/building_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager.backgroundColor,
        appBar: MyAppBar(title: "Profile", isSettings: true),
        body: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          final cubit = context.read<SettingsCubit>();

          List<Map<String, String>> contacts = [];
          if (state is SettingsLoading) {
            return Center(child: LoadingWidget());
          } else if (state is SettingsUpdated) {
            contacts = state.contacts;
          } else if (cubit.emergencyContacts.isNotEmpty) {
            contacts = cubit.emergencyContacts;
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Info Fields
                buildInput(
                    label: "First Name",
                    value: cubit.user.fullName.split(' ')[0]),
                buildInput(
                    label: "Last Name",
                    value: cubit.user.fullName
                        .split(' ')[cubit.user.fullName.split(' ').length - 1]),
                buildInput(label: "Mobile Number", value: cubit.user.phone),

                buildInput(label: "Age", value: calculateAge(cubit.user.date)),
                buildInput(label: "National ID", value: cubit.user.nationalID),
                buildInput(label: "Weight", value: "70 kgs"),
                buildInput(label: "Height", value: "5 feet 10 inches"),
                buildInput(
                  label: "Address",
                  value: buildAddress(cubit.user.address!),
                  maxLines: 2,
                ),
                SizedBox(height: 30.h),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Emergency Contacts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.h),

                ...contacts.asMap().entries.map((entry) {
                  final i = entry.key;
                  return Column(
                    children: [
                      buildEditableInput(
                        label: "Contact ${i + 1} Full Name",
                        onChanged: (val) =>
                            cubit.updateEmergencyContact(i, "name", val),
                      ),
                      buildEditableInput(
                        label: "Contact ${i + 1} Mobile Number",
                        keyboardType: TextInputType.phone,
                        onChanged: (val) =>
                            cubit.updateEmergencyContact(i, "phone", val),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                }),
                if (contacts.length < 2)
                  ElevatedButton.icon(
                    onPressed: () => cubit.addEmergencyContact(),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Contact"),
                  ),
              ],
            ),
          );
        }));
  }
}
