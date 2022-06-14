

import 'package:flutter/cupertino.dart';


class ElevButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  final Color?  color;

  const ElevButton({Key? key, required this.text, required this.icon, required this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevButton(


        text: text,
        icon: icon,
        onPressed: onPressed);
  }
}
