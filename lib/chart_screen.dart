import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<types.Message> _aiMessages = [];
  final List<types.Message> _forumMessages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'AI Assistant'),
            Tab(text: 'Community Forum'),
          ],
          indicatorColor: Colors.white,
          labelColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAIChat(),
          _buildForumChat(),
        ],
      ),
    );
  }

  Widget _buildAIChat() {
    return Column(
      children: [
        Expanded(
          child: Chat(
            messages: _aiMessages,
            onSendPressed: _handleAISendPressed,
            user: _user,
            theme: DefaultChatTheme(
              primaryColor: Colors.green,
              //
              inputBackgroundColor: Colors.grey[200]!,
              inputTextColor: Colors.black,
            ),
          ),
        ),
        _buildSuggestionChips(),
      ],
    );
  }

  Widget _buildForumChat() {
    return Chat(
      messages: _forumMessages,
      onSendPressed: _handleForumSendPressed,
      user: _user,
      theme: DefaultChatTheme(
        primaryColor: Colors.blue,
        inputBackgroundColor: Colors.grey[200]!,
        inputTextColor: Colors.black,
      ),
    );
  }

  Widget _buildSuggestionChips() {
    List<String> suggestions = [
      'Healthy diet tips',
      'Workout routines',
      'Sleep improvement',
      'Stress management'
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[200],
      child: Wrap(
        spacing: 8,
        children: suggestions.map((suggestion) => ActionChip(
          label: Text(suggestion),
          onPressed: () => _handleAISendPressed(types.PartialText(text: suggestion)),
        )).toList(),
      ),
    );
  }

  void _handleAISendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage, true);

    // Simulate AI response
    Future.delayed(Duration(seconds: 1), () {
      final aiResponse = types.TextMessage(
        author: types.User(id: 'ai'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'Here\'s some information about ${message.text}: ...',
      );
      _addMessage(aiResponse, true);
    });
  }

  void _handleForumSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage, false);

    // Simulate other user's response
    Future.delayed(Duration(seconds: 2), () {
      final otherUserResponse = types.TextMessage(
        author: types.User(id: 'other_user', firstName: 'Jane'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: 'That\'s an interesting point about ${message.text}. Have you considered...',
      );
      _addMessage(otherUserResponse, false);
    });
  }

  void _addMessage(types.Message message, bool isAIChat) {
    setState(() {
      if (isAIChat) {
        _aiMessages.insert(0, message);
      } else {
        _forumMessages.insert(0, message);
      }
    });
  }
}