import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/profile_model.dart';
import '../widgets/info_card.dart';
import '../widgets/skill_item.dart';
import '../data/app_data.dart';
import '../widgets/highlight_title.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback toggleTheme; 
  const ProfilePage({super.key, required this.toggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileView _currentView = ProfileView.detail; 
  StatusType? _activeStatus; 
  
  String get currentStatusText {
    String base = userProfile.jurusan;
    if (_activeStatus != null) {
      base += ' | ${_activeStatus!.label}';
    } else {
      base += ' | Mahasiswa';
    }
    return base;
  }

  Color getRandomColor(int index, Brightness brightness) {
    List<Color> lightColors = [Colors.pink.shade300, Colors.purple.shade300, Colors.teal.shade300, Colors.blue.shade300, Colors.amber.shade300];
    List<Color> darkColors = [Colors.pink.shade700, Colors.purple.shade700, Colors.teal.shade700, Colors.blue.shade700, Colors.amber.shade700];
    
    if (brightness == Brightness.dark) {
      return darkColors[index % darkColors.length];
    }
    return lightColors[index % lightColors.length];
  }

  Widget _buildTagSection(String title, List<String> tags, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            spacing: 8.0, 
            runSpacing: 8.0, 
            children: tags.asMap().entries.map((entry) {
              int index = entry.key;
              String tag = entry.value;
              return Chip(
                label: Text(tag, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                backgroundColor: getRandomColor(index, brightness),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
  
  Widget _buildImageSlider() {
    return SizedBox(
      height: 150, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: galleryImagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                galleryImagePaths[index],
                width: 200.0, // Rasio 4:3 (150 * 4/3)
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 200.0,
                  color: Colors.grey.shade300,
                  child: Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectsView() {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: HighlightTitle(title: 'GALERI KARYA'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Kumpulan video, tulisan, dan karya lainnya yang pernah saya buat.', style: TextStyle(color: Colors.grey.shade600)),
        ),
        
        const SizedBox(height: 20),
        _buildImageSlider(),
        const SizedBox(height: 20),
        
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16.0, right: 16.0, bottom: 20),
          child: HighlightTitle(title: 'KARYA AUDIO VISUAL'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Subscribe channel YouTube Sarjana Wibu untuk update video terbaru.', style: TextStyle(color: Colors.grey.shade600)),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          itemCount: projectData.length, 
          itemBuilder: (context, index) {
            final project = projectData[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: Icon(Icons.code_rounded, color: textColor, size: 40),
                title: Text('${project['title']}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('${project['desc']}'),
                    const SizedBox(height: 4),
                    Text('Tahun: ${project['year']}', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildContactView() {
    final textColor = Theme.of(context).colorScheme.onBackground;

    return Column(
      children: [
        InfoCard(icon: Icons.email, text: userProfile.email, label: 'Email'),
        InfoCard(icon: Icons.phone, text: userProfile.telepon, label: 'WhatsApp'),
        const SizedBox(height: 20),
        
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: contactData.length,
          itemBuilder: (context, index) {
            final contact = contactData[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(contact['icon'], color: textColor),
                title: Text(contact['label'].toString()),
                subtitle: Text(contact['url'].toString()),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Simulasi membuka: ${contact['label']}')),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
  
  Widget _buildNavButton({required String label, required IconData icon, required ProfileView mode, required bool isActive}) {
    return TextButton.icon(
      icon: Icon(icon, color: isActive ? Theme.of(context).primaryColor : Colors.grey),
      label: Text(
        label,
        style: TextStyle(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          _currentView = mode;
        });
      },
    );
  }

  Widget _buildStatusToggle(StatusType type) {
    final isActive = _activeStatus == type;
    final primaryColor = Theme.of(context).primaryColor;

    return ActionChip(
      label: Text(type.label),
      backgroundColor: isActive ? primaryColor.withOpacity(0.2) : null,
      side: BorderSide(color: isActive ? primaryColor : Colors.grey.shade400),
      onPressed: () {
        setState(() {
          _activeStatus = isActive ? null : type;
        });
      },
    );
  }

  Widget _buildContactButton() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor.withOpacity(0.8), Theme.of(context).primaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: TextButton.icon(
        icon: Icon(Icons.send, color: Colors.white, size: 16),
        label: Text("Contact Me!", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () {
          setState(() {
            _currentView = ProfileView.hobbies; 
          });
        },
      ),
    );
  }


  Widget _buildDetailSection(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTagSection("Skills", userProfile.skill, brightness),
        _buildTagSection("Hobbies", userProfile.hobi, brightness),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text(
            bioText,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(fontSize: 15),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildStatusToggle(StatusType.creative),
              const SizedBox(width: 8),
              _buildStatusToggle(StatusType.content),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildDynamicContent() {
    switch (_currentView) {
      case ProfileView.projects:
        return _buildProjectsView();
      case ProfileView.hobbies:
        return _buildContactView();
      case ProfileView.detail:
      default:
        return _buildDetailSection(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 220, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor.withOpacity(0.8), primaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned( top: 40, left: 20, child: Icon(Icons.menu, color: Colors.white)),
                Positioned( top: 40, right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.brightness_6, color: Colors.white), 
                    onPressed: widget.toggleTheme, 
                    tooltip: 'Ganti Tema'
                  ),
                ),
                Positioned(
                  top: 100, 
                  left: 20,
                  right: 20,
                  child: Card(
                    color: cardColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 20),
                      child: Column(
                        children: [
                          Text(userProfile.nama, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(currentStatusText, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                          const SizedBox(height: 15),
                          _buildContactButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50, 
                  child: CircleAvatar(
                    radius: 50, backgroundColor: surfaceColor,
                    child: CircleAvatar(radius: 45, backgroundImage: AssetImage(userProfile.fotoPath)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 180),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavButton(label: "Profile", icon: Icons.person, mode: ProfileView.detail, isActive: _currentView == ProfileView.detail),
                  _buildNavButton(label: "Projects", icon: Icons.code, mode: ProfileView.projects, isActive: _currentView == ProfileView.projects),
                  _buildNavButton(label: "Contact", icon: Icons.email, mode: ProfileView.hobbies, isActive: _currentView == ProfileView.hobbies),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildDynamicContent(),
          ],
        ),
      ),
    );
  }
}