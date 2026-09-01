import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AdminChatScreen extends StatefulWidget {
  final AppState state;

  const AdminChatScreen({
    super.key,
    required this.state,
  });

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      sender: 'Krishna Saha',
      message: 'আসসালামু আলাইকুম, LandVest 100 এর নতুন ডিড কবে পাবো?',
      time: '10:45 AM',
      isMe: false,
    ),
    _ChatMessage(
      sender: 'Admin',
      message: 'ওয়ালাইকুম আসসালাম। আগামী ৩ কার্যদিবসের মধ্যে ডকুমেন্টস ভল্টে আপলোড করা হবে।',
      time: '10:48 AM',
      isMe: true,
    ),
    _ChatMessage(
      sender: 'Krishna Saha',
      message: 'ধন্যবাদ!',
      time: '10:50 AM',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(
        _ChatMessage(
          sender: 'Admin',
          message: _messageController.text.trim(),
          time: 'Just now',
          isMe: true,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Krishna Saha',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: palette.ink),
                ),
                Text(
                  isBangla ? 'অনলাইন' : 'Online',
                  style: GoogleFonts.hindSiliguri(fontSize: 11, color: const Color(0xFF00C853)),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                itemCount: _messages.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: msg.isMe ? const Color(0xFF0066FF) : palette.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(14),
                          topRight: const Radius.circular(14),
                          bottomLeft: Radius.circular(msg.isMe ? 14 : 2),
                          bottomRight: Radius.circular(msg.isMe ? 2 : 14),
                        ),
                        border: msg.isMe ? null : Border.all(color: palette.rule, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.message,
                            style: GoogleFonts.hindSiliguri(
                              fontSize: 13.5,
                              color: msg.isMe ? Colors.white : palette.ink,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg.time,
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              color: msg.isMe ? Colors.white.withValues(alpha: 0.7) : palette.inkTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(top: BorderSide(color: palette.rule, width: 1.0)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: palette.surfaceSunken,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: palette.ruleStrong, width: 1.0),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: GoogleFonts.poppins(fontSize: 13, color: palette.ink),
                        decoration: InputDecoration(
                          hintText: isBangla ? 'মেসেজ লিখুন...' : 'Type a message...',
                          hintStyle: GoogleFonts.hindSiliguri(fontSize: 13, color: palette.inkTertiary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF0066FF),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  _ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });
}
