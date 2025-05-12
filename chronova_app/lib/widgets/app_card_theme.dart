import 'package:flutter/material.dart';


class AppCardTheme extends StatefulWidget {
  final String cardDetails;
  final String imageCardPath;
  //final String imageEpochPath;

  const AppCardTheme(
      {
        required this.cardDetails,
        required this.imageCardPath,
        // required this.imageEpochPath,
        super.key});

  @override
  State<AppCardTheme> createState() => _AppCardThemeState();
}

class _AppCardThemeState extends State<AppCardTheme> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 200,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                // Image background of the card
                image: AssetImage(widget.imageCardPath),
                fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              // to set up next time. (Icon Epoch of the Event)
            ),
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              color: Colors.deepPurple,
              child: Text(
                widget.cardDetails,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),),
            )
          ],
        ),
      ),
    );

  }
}