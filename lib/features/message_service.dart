import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Message Service State
class MessageState {
  final GlobalKey<NavigatorState> navigatorKey;

  const MessageState({
    required this.navigatorKey,
  });
}

// Message Service Provider
final messageServiceProvider = StateNotifierProvider<MessageService, MessageState>((ref) {
  return MessageService(MessageState(navigatorKey: GlobalKey<NavigatorState>()));
});

// Message Service
class MessageService extends StateNotifier<MessageState> {
  MessageService(super.state);

  void showMessage({
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (state.navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(state.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: backgroundColor.withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          duration: duration,
        ),
      );
    }
  }

  void showSuccess(String message) {
    showMessage(
      message: message,
      backgroundColor: Colors.green,
    );
  }

  void showInfo(String message) {
    showMessage(
      message: message,
      backgroundColor: Colors.cyan,
    );
  }

  void showWarning(String message) {
    showMessage(
      message: message,
      backgroundColor: Colors.orange,
    );
  }

  void showError(String message) {
    showMessage(
      message: message,
      backgroundColor: Colors.red,
    );
  }
}
