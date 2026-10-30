import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const FilterBottomSheet({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', 'AI', 'Mobile', 'IoT', 'Cybersecurity'];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: categories.map((cat) {
          return RadioListTile<String>(
            title: Text(cat),
            value: cat,
            groupValue: selectedCategory,
            onChanged: (value) {
              onCategorySelected(value!);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
