// lib/widgets/skill_item.dart
import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final String skillName;
  const SkillItem({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // PERBAIKAN: Ganti ini
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(15),
      ),
      // ... sisa kode sama ...
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.code, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(skillName, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}