import 'package:flutter/material.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override 
  State<StatefulWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  // const CustomSearchWidget({super.key});
  String searchText = "";

  final TextEditingController _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            searchText,
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 25, 25, 25),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child:  TextField(
              controller: _txtController,
              onChanged: (value) {
                setState(() {
                  searchText=_txtController.value.text;
                });
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: "ابحث في المحادثات",
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white54),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white54,
                  ),
                  hintTextDirection: TextDirection.rtl),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              // showCursor: false,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
