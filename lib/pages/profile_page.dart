import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/profile_model.dart';
import '../widgets/info_card.dart';
import '../widgets/skill_item.dart';
import '../data/app_data.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback toggleTheme; 
  const ProfilePage({super.key, required this.toggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileView _currentView = ProfileView.detail; 

  Widget _buildProjectsView() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: projectData.length, 
          itemBuilder: (context, index) {
            final project = projectData[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: Icon(Icons.code_rounded, color: Theme.of(context).primaryColor, size: 40),
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
    return Column(
      children: [
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
                leading: Icon(contact['icon'], color: Theme.of(context).primaryColor),
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

  Widget _buildDetailSection(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(userProfile.nama, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('${userProfile.jurusan} | ${userProfile.statusLabel}', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 20),

        InfoCard(icon: Icons.email, text: userProfile.email, label: 'Email'),
        InfoCard(icon: Icons.phone, text: userProfile.telepon, label: 'WhatsApp'),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Skills", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.1, crossAxisSpacing: 10, mainAxisSpacing: 10,
                ),
                itemCount: userProfile.skill.length,
                itemBuilder: (context, index) {
                  return SkillItem(skillName: userProfile.skill[index]);
                },
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hobbies & Interests", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, itemCount: userProfile.hobi.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Center(
                        child: Text(userProfile.hobi[index], style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicContent() {
    // Memanggil content yang sudah dibungkus Column
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

    return Scaffold(
      body: SingleChildScrollView( 
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container( 
                  height: 200, width: double.infinity,
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.pink.shade400, Colors.purple.shade600], begin: Alignment.topLeft, end: Alignment.bottomRight,)),
                ),
                Positioned( top: 40, right: 20,
                  child: Container( decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle,),
                    child: IconButton(icon: const Icon(Icons.brightness_6, color: Colors.white), onPressed: widget.toggleTheme, tooltip: 'Ganti Tema'),
                  ),
                ),
                Positioned( bottom: -50,
                  child: CircleAvatar(
                    radius: 60, backgroundColor: surfaceColor,
                    child: CircleAvatar(radius: 55, backgroundImage: NetworkImage(userProfile.fotoUrl)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

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