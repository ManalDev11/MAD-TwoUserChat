import 'package:flutter/material.dart';
import 'package:whats_app_clone/chat_summary_widget.dart';
import 'package:whats_app_clone/custom_search_widget.dart';
import 'package:whats_app_clone/models/chat_data_model.dart';
import 'package:whats_app_clone/screens/calls_screen.dart';
import 'package:whats_app_clone/screens/chat_details_screen.dart';
import 'package:whats_app_clone/screens/chats_screen.dart';
import 'package:whats_app_clone/screens/groups_screen.dart';
import 'package:whats_app_clone/screens/recents_screen.dart';
import 'package:whats_app_clone/test_widget.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({super.key});

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome> {
  List<ChatDataModel> chatList = [
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 4),
    ChatDataModel(
        name: "Said",
        imagePath: "assets/images/image_2.jpg",
        time: "5:30",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 2),
    ChatDataModel(
        name: "Said",
        imagePath: "assets/images/image_2.jpg",
        time: "5:30",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Said",
        imagePath: "assets/images/image_2.jpg",
        time: "5:30",
        lastMessage: "How are you?",
        mssgCount: 1),
    ChatDataModel(
        name: "Ali",
        imagePath: "assets/images/image_1.jpg",
        time: "5:10",
        lastMessage: "How are you?",
        mssgCount: 1),
  ];
  // const MyApp({super.key});
  // List chatList = [
  //   {
  //     "name": "Ali",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_1.jpg",
  //   },
  //   {
  //     "name": "Ahmed",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_2.jpg",
  //   },
  //   {
  //     "name": "Ali",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_1.jpg",
  //   },
  //   {
  //     "name": "Ahmed",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_2.jpg",
  //   },
  //   {
  //     "name": "Ali",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_1.jpg",
  //   },
  //   {
  //     "name": "Ahmed",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_2.jpg",
  //   },
  //   {
  //     "name": "Ali",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_1.jpg",
  //   },
  //   {
  //     "name": "Ahmed",
  //     "lastMssg": "Alsalam alikom!",
  //     "time": "5:01",
  //     "imagePath": "assets/images/image_2.jpg",
  //   },
  // ];
  int _currentIndex = 3;
  List<Widget> _pages = [
    CallsScreen(),
    GroupsScreen(),
    RecentsScreen(),
    ChatsScreen()
  ];
  int _mssgCount = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/test': (context) => TestWidget(),
      },
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: CustomSearchWidget()),
          leadingWidth: 100,
          leading: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(right: 16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              "واتساب",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body:
            // _pages[_currentIndex]

            ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatDetailsScreen(
                              name: chatList[index].name,
                              imagePath: chatList[index].imagePath,
                            )));

                // Navigator.pushNamed(context, '/test');
              },
              child: ChatSummaryWidget(
                name: chatList[index].name,
                lastMessage: chatList[index].lastMessage,
                time: chatList[index].time,
                imagePath: chatList[index].imagePath,
                mssgCount: chatList[index].mssgCount,
              ),
            );
          },
        )
        // // ignore: prefer_const_constructors

        //
        //
        // Container(
        //   height: double.infinity,
        //   color: Colors.white,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.red,
        //           ),
        //           // const SizedBox(width: 20,),
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.green,
        //           ),
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.red,
        //           ),
        //           // const SizedBox(width: 20,),
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.green,
        //           ),
        //           Container(
        //             height: 100,
        //             width: 100,
        //             color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Container(
        //         padding:const EdgeInsets.all(20),
        //         // alignment: Alignment.center,
        //         height: 300,
        //         width: 300,
        //         decoration: const BoxDecoration(
        //           color: Colors.lightBlue,
        //         ),
        //         child: const Image(
        //           fit: BoxFit.fill,
        //           image: AssetImage("assets/images/image_2.jpg"),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        ,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              _mssgCount++;
            });
          },
          child: const Icon(
            Icons.add_comment,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.green,
            backgroundColor: Colors.black,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.call), label: "المكالمات"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.groups_3_outlined), label: "المجتمعات"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.refresh), label: "التحديثات"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.comment), label: "الدردشات"),
            ]),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
