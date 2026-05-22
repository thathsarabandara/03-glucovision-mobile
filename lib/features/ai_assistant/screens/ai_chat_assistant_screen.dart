import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class AiChatAssistantScreen extends StatefulWidget {
  const AiChatAssistantScreen({super.key});

  @override
  State<AiChatAssistantScreen> createState() => _AiChatAssistantScreenState();
}

class _AiChatAssistantScreenState extends State<AiChatAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Hello Alex. I noticed your glucose spiked to 160 mg/dL after lunch. How are you feeling?',
      'type': 'text',
    },
    {
      'isUser': true,
      'text': 'I feel a bit sluggish. What should I do?',
      'type': 'text',
    },
    {
      'isUser': false,
      'text': 'I recommend a 15-minute light walk to help increase insulin sensitivity. Here is a suggested route.',
      'type': 'card',
      'cardTitle': 'Activity Recommendation',
      'cardSubtitle': '15 Min Light Walk',
      'cardIcon': LucideIcons.footprints,
      'cardColor': AppTheme.cyanAccent,
    }
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'isUser': true,
        'text': _messageController.text,
        'type': 'text',
      });
      _messageController.clear();
    });

    _scrollToBottom();
    
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          'isUser': false,
          'text': 'I am analyzing your recent metabolic metrics to provide the best response...',
          'type': 'text',
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.purpleAI.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.bot, color: AppTheme.purpleAI, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              'GlucoVision AI',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(LucideIcons.chevronLeft, color: isDark ? Colors.white : AppTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.history, color: isDark ? Colors.white : AppTheme.textPrimary),
            onPressed: () => context.push('/ai-history'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildMessageBubble(msg);
                },
              ),
            ),
            _buildInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final bool isUser = msg['isUser'];
    final String type = msg['type'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              margin: const EdgeInsets.only(right: 8, bottom: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppTheme.cyanAccent, AppTheme.purpleAI],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(LucideIcons.bot, size: 14, color: Colors.white),
            ),
          ],
          
          Flexible(
            child: type == 'card' 
              ? _buildContextualCard(msg)
              : _buildTextBubble(msg['text'], isUser),
          ),
          
          if (isUser) ...[
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black.withOpacity(0.04)),
              ),
              child: const Icon(LucideIcons.user, size: 14, color: AppTheme.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextBubble(String text, bool isUser) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUser 
            ? (isDark ? Colors.white.withOpacity(0.06) : Colors.white)
            : (isDark ? AppTheme.purpleAI.withOpacity(0.12) : AppTheme.purpleAI.withOpacity(0.06)),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isUser ? 20 : 4),
          bottomRight: Radius.circular(isUser ? 4 : 20),
        ),
        border: Border.all(
          color: isUser 
              ? (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04))
              : AppTheme.purpleAI.withOpacity(0.2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isUser 
              ? (isDark ? Colors.white : AppTheme.textPrimary) 
              : (isDark ? Colors.white.withOpacity(0.9) : AppTheme.textPrimary),
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.45,
        ),
      ),
    );
  }

  Widget _buildContextualCard(Map<String, dynamic> msg) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      hasGlow: true,
      glowColor: msg['cardColor'].withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg['text'],
            style: TextStyle(
              color: isDark ? Colors.white70 : AppTheme.textPrimary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: msg['cardColor'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(msg['cardIcon'], color: msg['cardColor'], size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg['cardTitle'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: isDark ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        msg['cardSubtitle'],
                        style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: msg['cardColor'],
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: const Size(0, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Start', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.backgroundDark : Colors.white,
        border: Border(
          top: BorderSide(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(LucideIcons.camera, color: AppTheme.textSecondary, size: 20),
              onPressed: () => context.push('/multimodal-assistant'),
            ),
            IconButton(
              icon: const Icon(LucideIcons.mic, color: AppTheme.emeraldHealth, size: 20),
              onPressed: () => context.push('/voice-assistant'),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.04) : const Color(0xFFF0F2F6),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  style: TextStyle(color: isDark ? Colors.white : AppTheme.textPrimary, fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'Ask GlucoVision...',
                    hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.cyanAccent, AppTheme.emeraldHealth],
                ),
              ),
              child: IconButton(
                icon: const Icon(LucideIcons.send, color: Colors.black, size: 16),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
