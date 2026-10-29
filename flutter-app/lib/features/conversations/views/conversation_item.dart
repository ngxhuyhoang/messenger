import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          spacing: 8,
          children: [
            CircleAvatar(child: Text("H")),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("Message"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
