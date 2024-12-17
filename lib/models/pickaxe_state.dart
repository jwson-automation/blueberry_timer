import 'package:blueberry_timer/models/pickaxe_model.dart';

class PickaxeState {
  final PickaxeModel pickaxe;

  const PickaxeState({
    required this.pickaxe,
  });

  PickaxeState copyWith({
    PickaxeModel? pickaxe,
  }) {
    return PickaxeState(
      pickaxe: pickaxe ?? this.pickaxe,
    );
  }
}
