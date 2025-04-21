import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:flutter/material.dart';

Widget buildInput({
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

Widget buildEditableInput({
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
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

String buildAddress(Address address) {
  String res = '';
  if (address.apartmentNumber != null) {
    res += '${address.apartmentNumber}, ';
  }
  if (address.floor != null) {
    res += '${address.floor}, ';
  }
  res +=
      '${address.buildingNumber}, ${address.street}, ${address.city}, ${address.government}';

  return res;
}
