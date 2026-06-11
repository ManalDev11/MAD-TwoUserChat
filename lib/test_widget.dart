import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(20, (index) {
        return Container(
          color: Colors.blue,
          margin: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              'Item $index',
              style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }));
  }
}
