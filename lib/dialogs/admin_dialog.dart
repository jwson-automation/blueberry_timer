import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/repositories/user_repository.dart';

class AdminDialog extends ConsumerStatefulWidget {
  const AdminDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AdminDialog(),
    );
  }

  @override
  ConsumerState<AdminDialog> createState() => _AdminDialogState();
}

class _AdminDialogState extends ConsumerState<AdminDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('관리자 페이지'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('임시 사용자 추가'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '사용자 이름',
                hintText: '임시 사용자 이름을 입력하세요',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: '임시 사용자 이메일을 입력하세요',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTemporaryUser,
              child: const Text('사용자 추가'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('닫기'),
        ),
      ],
    );
  }

  void _addTemporaryUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요')),
      );
      return;
    }

    try {
      // 임시 사용자 추가 로직
      final userRepository = UserRepository();
      final newUser = await userRepository.addTemporaryUser(
        name: name, 
        email: email,
        initialExperience: 0,
        initialMoney: 0,
      );

      // 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name 사용자가 임시로 추가되었습니다. UID: ${newUser.uid}')),
      );

      // 필드 초기화 및 다이얼로그 닫기
      _nameController.clear();
      _emailController.clear();
      Navigator.of(context).pop();
    } catch (e) {
      // 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 추가 중 오류 발생: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
