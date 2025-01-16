import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const Roundbutton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.058,
        width: size.width * .96,
        decoration: BoxDecoration(
            color: Color(0xff442d82),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )),
      ),
    );
  }
}
