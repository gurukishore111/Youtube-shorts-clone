import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          width: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 256, 45, 108),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 30,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 199, 78, 78),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        Center(
          child: Container(
            height: double.infinity,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
          ),
        )
      ]),
    );
  }
}
