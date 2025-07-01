import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/chat/presentation/widgets/chat_room_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Chat Rooms",
                style: TextStyle(
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.08),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by agent's name...",
                    prefixIcon: Icon(
                      PhosphorIconsRegular.magnifyingGlass,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.042, vertical: height * 0.017),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            ChatRoomTile(
              name: "Andrew Cano",
              lastMessage: "Ready to check out today?",
              lastMessageTime: "08:20 AM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
            ChatRoomTile(
              name: "Jerome Bell",
              lastMessage: "I am arriving tomorrow afternoon",
              lastMessageTime: "01:13 AM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
            ChatRoomTile(
              name: "Sophia Müller",
              lastMessage: "Is the apartment still available?",
              lastMessageTime: "10:15 AM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
            ChatRoomTile(
              name: "Léa Dubois",
              lastMessage: "I'm interested in a 2-bedroom flat in Zamalek.",
              lastMessageTime: "9:50 AM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
            ChatRoomTile(
              name: "James Carter",
              lastMessage: "Please send me the payment plan details.",
              lastMessageTime: "7:12 PM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
            ChatRoomTile(
              name: "Li Wei",
              lastMessage: "Does the price include maintenance fees?",
              lastMessageTime: "5:27 PM",
              onTap: () {
                Navigator.pushNamed(
                    context, ScreenConst.personalInformationScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
