import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:cloud_medix/features/settings/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildInput({
  required String label,
  required String value,
  int maxLines = 1,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
    child: Row(
      children: [Text(label), Spacer(), Text(value)],
    ),
  );
}

String calculateAge(DateTime birthDate) {
  final today = DateTime.now();
  int age = today.year - birthDate.year;

  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age.toString();
}

List<Widget> buildAddress(Address address) {
  List<Widget> widgets = [];

  if (address.apartmentNumber != null) {
    widgets.add(buildInput(
        label: "Apartment Number", value: address.apartmentNumber.toString()));
  }
  if (address.floor != null) {
    widgets.add(
        buildInput(label: "Floor Number", value: address.floor.toString()));
  }
  widgets.addAll([
    buildInput(
        label: "Building Number", value: address.buildingNumber.toString()),
    buildInput(label: "Street", value: address.street),
    buildInput(label: "City", value: address.city),
    buildInput(label: "Government", value: address.government),
  ]);

  return widgets;
}

Widget buildEmergencyContact({
  required User user,
}) {
  if (user.emergencyContactName != null && user.emergencyContactPhone != null) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Name"),
              const Spacer(),
              Text(user.emergencyContactName!),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              const Text("Phone"),
              const Spacer(),
              Text(user.emergencyContactPhone!),
            ],
          ),
        ],
      ),
    );
  } else {
    return const Text("No Emergency Contact Found");
  }
}

Widget buildAddressForm(User user) {
  final address = user.address;
  final controllers = {
    'apartment':
        TextEditingController(text: address.apartmentNumber?.toString()),
    'floor': TextEditingController(text: address.floor?.toString()),
    'building': TextEditingController(text: address.buildingNumber.toString()),
    'street': TextEditingController(text: address.street),
    'city': TextEditingController(text: address.city),
    'gov': TextEditingController(text: address.government),
  };

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        decoration: const InputDecoration(labelText: 'Apartment Number'),
        controller: controllers['apartment'],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          user.address.apartmentNumber = int.tryParse(value);
        },
      ),
      TextField(
        decoration: const InputDecoration(labelText: 'Floor Number'),
        controller: controllers['floor'],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          user.address.floor = int.tryParse(value);
        },
      ),
      TextField(
        decoration: const InputDecoration(labelText: 'Building Number'),
        controller: controllers['building'],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          user.address.buildingNumber = int.tryParse(value)!;
        },
      ),
      TextField(
          decoration: const InputDecoration(labelText: 'Street'),
          controller: controllers['street'],
          onChanged: (value) => user.address.street = value),
      TextField(
          decoration: const InputDecoration(labelText: 'City'),
          controller: controllers['city'],
          onChanged: (value) => user.address.city = value),
      TextField(
          decoration: const InputDecoration(labelText: 'Government'),
          controller: controllers['gov'],
          onChanged: (value) => user.address.government = value),
    ],
  );
}

Widget buildEmergencyContactForm(User user) {
  final nameController = TextEditingController(text: user.emergencyContactName);
  final phoneController =
      TextEditingController(text: user.emergencyContactPhone);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        decoration: const InputDecoration(labelText: 'Contact Name'),
        controller: nameController,
        onChanged: (value) => user.emergencyContactName = value,
      ),
      TextField(
        decoration: const InputDecoration(labelText: 'Contact Phone'),
        controller: phoneController,
        onChanged: (value) => user.emergencyContactPhone = value,
      ),
    ],
  );
}
