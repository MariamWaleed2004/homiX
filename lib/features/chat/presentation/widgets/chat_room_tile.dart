import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';

class ChatRoomTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String lastMessageTime;
  // final String profileImageUrl;
  final VoidCallback onTap;
  const ChatRoomTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    // required this.profileImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.015),
          child: Row(
            children: [
              Container(
                height: width * 0.13,
                width: width * 0.13,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/profile_photo.webp"),
                      fit: BoxFit.cover,
                    ),
                    //color: const Color.fromARGB(255, 174, 42, 42),
                    borderRadius: BorderRadius.circular(width * 0.16)),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04),
                          ),
                          Text(lastMessageTime,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: width * 0.033)),
                        ],
                      ),
                      Text(
                        lastMessage,
                        style: TextStyle(
                            color: Colors.grey[600], fontSize: width * 0.033),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
