import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, String>> emergencyContacts = [];

  void _addContactField() {
    if (emergencyContacts.length < 2) {
      setState(() {
        emergencyContacts.add({"name": "", "phone": ""});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: MyAppBar(
        title: "Profile",
        isSettings: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image and Name
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/images/user.svg',
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16,
                        child: Icon(Icons.upload,
                            size: 18, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Username",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Basic Info
            _buildInput(label: "First Name", value: "Wade"),
            _buildInput(label: "Last Name", value: "Warren"),
            _buildInput(label: "Mobile Number", value: "+91-9054XXXXXX"),
            _buildInput(
                label: "Alternate Mobile Number", value: "+91-8024XXXXXX"),
            _buildInput(label: "Age", value: "49 yrs"),
            _buildInput(label: "Weight", value: "70 kgs"),
            _buildInput(label: "Height", value: "5 feet 10 inches"),
            _buildInput(
              label: "Address",
              value:
                  "123, Park Avenue, Loren Street,\nNew York,\ndsfhifughdfgushdfiughdfiuhdfhdfhdhfhf\ndhdfhdfghfghgj",
              maxLines: 3,
            ),
            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Emergency Contacts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            ..._buildEmergencyContacts(),

            if (emergencyContacts.length < 2)
              ElevatedButton.icon(
                onPressed: _addContactField,
                icon: const Icon(Icons.add),
                label: const Text("Add Contact"),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEmergencyContacts() {
    List<Widget> widgets = [];

    for (int i = 0; i < emergencyContacts.length; i++) {
      widgets.addAll([
        _buildEditableInput(
          label: "Contact ${i + 1} Full Name",
          onChanged: (val) => emergencyContacts[i]["name"] = val,
        ),
        _buildEditableInput(
          label: "Contact ${i + 1} Mobile Number",
          keyboardType: TextInputType.phone,
          onChanged: (val) => emergencyContacts[i]["phone"] = val,
        ),
        const SizedBox(height: 10),
      ]);
    }

    return widgets;
  }

  Widget _buildInput({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        readOnly: true,
        maxLines: maxLines,
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEditableInput({
    required String label,
    required Function(String) onChanged,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
