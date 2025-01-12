import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/message_model.dart';

/**
 * 앱 내의 알림 메시지를 처리하는 서비스입니다.
 * 
 * 게임과 같은 느낌의 팝업 메시지를 화면 상단에 표시하며,
 * 성공, 정보, 경고, 에러 등 다양한 유형의 메시지를 지원합니다.
 * 
 * 메시지는 애니메이션과 함께 표시되며 자동으로 사라집니다.
 * 기본 지속 시간은 1.5초이며, 메시지마다 다른 색상을 사용하여 구분합니다.
 */

/// MessageService의 전역 Provider
final messageServiceProvider = Provider((ref) => MessageService());

/// 앱의 알림 메시지를 관리하는 서비스
class MessageService {
  /// 현재 표시 중인 메시지 정보
  final ValueNotifier<MessageModel?> messageNotifier = ValueNotifier(null);
  Timer? _messageTimer;

  /// 기본 메시지 표시 메서드
  void showMessage(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    _messageTimer?.cancel();
    
    messageNotifier.value = MessageModel(
      message: message,
      backgroundColor: backgroundColor,
    );

    _messageTimer = Timer(duration, () {
      messageNotifier.value = null;
    });
  }

  /// 성공 메시지 표시 (초록색)
  void showSuccess(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      backgroundColor: Colors.green.shade700,
    );
  }

  /// 정보 메시지 표시 (청록색)
  void showInfo(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      backgroundColor: Colors.cyan.shade700,
    );
  }

  /// 경고 메시지 표시 (주황색)
  void showWarning(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      backgroundColor: Colors.orange.shade700,
    );
  }

  /// 에러 메시지 표시 (빨간색)
  void showError(BuildContext context, String message) {
    showMessage(
      context,
      message: message,
      backgroundColor: Colors.red.shade700,
    );
  }
}
