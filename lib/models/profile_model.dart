enum Status { mahasiswa, creativeTechnologist, contentCreator }

enum ProfileView { 
  detail,
  projects,
  hobbies
}

class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final String fotoUrl; 
  final List<String> hobi;
  final List<String> skill;
  final Status status;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.fotoUrl,
    required this.hobi,
    required this.skill,
    required this.status,
  });
  
  String get statusLabel {
    switch (status) {
      case Status.mahasiswa: return 'Mahasiswa';
      case Status.creativeTechnologist: return 'Creative Technologist';
      case Status.contentCreator: return 'Content Creator';
    }
  }
}