import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final Border border;
  final double buttonHeight, buttonWidth;
  final Widget widgetPage;
  final String buttonText;
  final IconData buttonIcon;
  final _textStyle = const TextStyle(
      fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white);

  HomePageButton(this.border, this.buttonHeight, this.buttonWidth,
      this.buttonText, this.buttonIcon, this.widgetPage);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey, border: border),
      height: buttonHeight,
      width: buttonWidth,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widgetPage));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              buttonIcon,
              color: Colors.white,
              size: 130,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  buttonText,
                  style: _textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
