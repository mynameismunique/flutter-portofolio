enum StatusType { creative, content } 

enum ProfileView { 
  detail,
  projects,
  hobbies
}

extension StatusExtension on StatusType {
  String get label {
    switch (this) {
      case StatusType.creative: return 'Creative Technologist';
      case StatusType.content: return 'Content Creator';
    }
  }
}

class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final String fotoPath;
  final List<String> hobi;
  final List<String> skill;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.fotoPath,
    required this.hobi,
    required this.skill,
  });
}