import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String label;

  const InfoCard({
    super.key, 
    required this.icon, 
    required this.text,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile( // Memenuhi syarat ListTile [cite: 47]
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(label),
      ),
    );
  }
}