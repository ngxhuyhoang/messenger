import 'package:flutter/material.dart';
import 'package:flutter_app/features/conversations/views/conversation_item.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({super.key});

  @override
  State<StatefulWidget> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  Future<void> _handleRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversations")),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ConversationItem();
          },
        ),
      ),
    );
  }
}
