import 'package:flutter/material.dart';

class ThemeButtonStyle extends StatelessWidget {
  const ThemeButtonStyle({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon
    
  });

  final String text;
  final void Function() onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
                    onPressed: () {},
                    icon: icon,
                    label: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(text, style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.blueAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      )
                    ),
                    
                    );
  }
}