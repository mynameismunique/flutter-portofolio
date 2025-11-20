import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightTitle extends StatelessWidget {
  final String title;
  
  const HighlightTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0, 
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                color: Colors.yellow.shade400, 
              ),
            ),
            
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).textTheme.headlineMedium?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}