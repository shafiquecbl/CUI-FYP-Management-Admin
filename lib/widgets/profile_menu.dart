import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black.withOpacity(0.5),
              size: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
