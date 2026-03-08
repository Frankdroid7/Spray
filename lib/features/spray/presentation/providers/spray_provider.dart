import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/spray/domain/entities/denomination.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';

class SprayState {
  final Denomination current;
  final Map<Denomination, int> monies;

  const SprayState({this.current = Denomination.nil, this.monies = const {}});

  SprayState copyWith({Denomination? current, Map<Denomination, int>? monies}) {
    return SprayState(
      current: current ?? this.current,
      monies: monies ?? this.monies,
    );
  }
}

class SprayNotifier extends Notifier<SprayState> {
  SprayNotifier();

  @override
  SprayState build() => const SprayState(
    current: Denomination.fiveHundredNaira
  );

  void setMonies(Map<Denomination, int> monies) {
    state = state.copyWith(monies: monies);
  }

  void setCurrentDenomination(Denomination denomination) {
    state = state.copyWith(current: denomination);
  }

  void addMoney(Denomination money) {
    Map<Denomination, int> monies = state.monies;
    int? count = monies[money];
    monies[money] = count == null ? 1 : count + 1;
    state = state.copyWith(monies: monies);
  }

  void removeMoney(Denomination money) {
    Map<Denomination, int> monies = state.monies;
    int? count = monies[money];
    if(count == null || count == 0) return;

    monies[money] = count - 1;
    state = state.copyWith(monies: monies);
  }
}

final NotifierProvider<SprayNotifier, SprayState> sprayProvider =
    NotifierProvider(SprayNotifier.new);
