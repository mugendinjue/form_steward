import 'package:flutter/material.dart';
import 'package:form_steward/form_steward.dart';

class StewardMobileField extends StatelessWidget {
  final FieldModel field;

  const StewardMobileField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: field.label),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (field.validation?.required == true && value!.isEmpty) {
          return '${field.label} is required';
        }
        if (field.validation?.pattern != null &&
            !RegExp(field.validation!.pattern!).hasMatch(value!)) {
          return 'Invalid ${field.label}';
        }
        return null;
      },
    );
  }
}
