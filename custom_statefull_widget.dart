import 'package:flutter/material.dart';

class CustomStatefulWidget extends StatefulWidget {
  const CustomStatefulWidget({super.key});

  @override
  _CustomStatefulWidgetState createState() => _CustomStatefulWidgetState();
}

class _CustomStatefulWidgetState extends State<CustomStatefulWidget> {
  bool _isRed = false;
  bool _muted = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _isRed ? Colors.red : Colors.white,
        body: Column(
          children: [
            Switch(
              value: _isRed,
              onChanged: (value) {
                setState(() {
                  _isRed = value;
                });
              },
            ),
            Text(_isRed ? 'RED' : 'WHITE'),
            IconButton(onPressed: () {
              setState(() {
                _muted = !_muted;
              });
            }, icon: Icon(_muted ? Icons.volume_off : Icons.volume_up))
          ],
        ),
      ),
    );
  }
}
