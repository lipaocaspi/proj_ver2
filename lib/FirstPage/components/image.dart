import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Imag extends StatelessWidget {
  const Imag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "UIS Wheels",
          style: GoogleFonts.pressStart2p(fontSize: 19),
        ),
        const SizedBox(height: 16 * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: Image.asset(
                "assets/images/llanta.png",
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16 * 2),
      ],
    );
  }
}