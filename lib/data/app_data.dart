// lib/data/app_data.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uts_mobile_munique/models/profile_model.dart'; // Import model Profile

final Profile userProfile = Profile(
  nama: 'Mugni Ramdani',
  nim: '23552011224',
  jurusan: 'Teknik Informatika',
  email: 'Mugniramdani@outlook.com',
  telepon: '+62 815-7993-3021',
  fotoUrl: 'https://munique.my.id/assets/img/profile.jpg',
  hobi: ['Writing Fiction', 'Cosplay', 'Anime Analysis', 'Podcasting'],
  skill: ['Flutter', 'PHP', 'Java', 'Writing', 'Unity AR/VR'],
  status: Status.creativeTechnologist,
);


final List<Map<String, String>> projectData = const [
  {
    'title': 'Sarjana Wibu (Podcast)',
    'desc': 'Konten analisis anime mendalam berdasarkan Opini pribadi.',
    'year': '2025',
  },
  {
    'title': 'Augmented Reality (AR) Prototype',
    'desc': 'Mengembangkan interaksi digital menggunakan Unity dan Vuforia.',
    'year': '2024',
  },
  {
    'title': 'Sistem Inventory Excel',
    'desc': 'Otomatisasi data inventaris menggunakan VBA/PHP untuk UMKM.',
    'year': '2022',
  },
];


final List<Map<String, dynamic>> contactData = const [
  {'label': 'GitHub', 'icon': FontAwesomeIcons.github, 'url': 'https://github.com/yourusername'},
  {'label': 'LinkedIn', 'icon': FontAwesomeIcons.linkedin, 'url': 'https://linkedin.com/in/yourprofile'},
  {'label': 'Instagram', 'icon': FontAwesomeIcons.instagram, 'url': 'https://instagram.com/munique_arts'},
  {'label': 'Email', 'icon': Icons.email, 'url': 'mailto:contact@munique.my.id'},
];