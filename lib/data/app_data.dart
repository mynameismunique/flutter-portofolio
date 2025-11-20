import 'package:flutter/material.dart';
import '../models/profile_model.dart'; 

final Profile userProfile = Profile(
  nama: 'Mugni Ramdani',
  nim: '23552011224',
  jurusan: 'Teknik Informatika',
  email: 'Mugniramdani@outlook.com',
  telepon: '+62 815-7993-3021',
  fotoPath: 'assets/img/profile_photo.jpg',
  hobi: ['Writing Fiction', 'Cosplay', 'Anime Analysis', 'Podcasting'],
  skill: ['Flutter', 'PHP', 'Java', 'Writing', 'Unity AR/VR'],
);

const String bioText = 
  "Bagi saya, semuanya berawal dari sebuah cerita. Halo, saya Munique, seorang kreator digital dari Bandung yang menemukan cara untuk bercerita melalui desain dan kode. "
  "Kecintaan pada tulisan membawa saya ke dunia teknologi, tempat saya bisa membangun \"panggung\" digital untuk berbagai ide.";

const String headerAssetPath = 'assets/img/header_bg.jpg';

final List<String> galleryImagePaths = const [
  'assets/img/slide_img1.jpeg',
  'assets/img/slide_img2.jpg',
  'assets/img/slide_img3.jpg',
  'assets/img/slide_img4.jpg',
];

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
  {'label': 'GitHub', 'icon': Icons.code, 'url': 'https://github.com/yourusername'},
  {'label': 'LinkedIn', 'icon': Icons.business_center, 'url': 'https://linkedin.com/in/yourprofile'},
  {'label': 'Instagram', 'icon': Icons.camera_alt, 'url': 'https://instagram.com/munique_arts'},
  {'label': 'Email', 'icon': Icons.email, 'url': 'mailto:contact@munique.my.id'},
];