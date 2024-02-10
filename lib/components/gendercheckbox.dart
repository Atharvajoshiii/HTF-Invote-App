import 'package:flutter/material.dart';


class GenderCheckbox extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const GenderCheckbox({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: groupValue == value,
          onChanged: (newValue) {
            if (newValue != null && newValue) {
              onChanged(value);
            }
          },
        ),
        Text(label),
      ],
    );
  }
}