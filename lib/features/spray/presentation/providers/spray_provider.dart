import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/denomination.dart';

class SprayState {
  final Denomination current;
  final Denomination? last;
  final Map<Denomination, int> monies;
  final int duration;
  final int swipes;

  const SprayState({
    this.last,
    this.current = Denomination.fiveHundredNaira,
    this.monies = const {},
    this.duration = 0,
    this.swipes = 0,
  });

  SprayState copyWith({
    Denomination? current,
    Denomination? last,
    Map<Denomination, int>? monies,
    int? duration,
    int? swipes,
  }) {
    return SprayState(
      current: current ?? this.current,
      last: last ?? this.last,
      monies: monies ?? this.monies,
      duration: duration ?? this.duration,
      swipes: swipes ?? this.swipes,
    );
  }
}

class SprayNotifier extends Notifier<SprayState> {
  SprayNotifier();

  @override
  SprayState build() =>
      const SprayState();

  void setMonies(Map<Denomination, int> monies) {
    state = state.copyWith(monies: monies);
  }

  void setCurrentDenomination(Denomination denomination) {
    state = state.copyWith(current: denomination);
  }

  void incrementDuration() {
    state = state.copyWith(duration: state.duration + 1);
  }

  void addMoney(Denomination money) {
    Map<Denomination, int> monies = Map.from(state.monies);
    int? count = monies[money];
    monies[money] = count == null ? 1 : count + 1;
    state = state.copyWith(monies: monies, swipes: state.swipes + 1, last: money);
  }

  void removeMoney(Denomination money) {
    Map<Denomination, int> monies = Map.from(state.monies);
    int? count = monies[money];
    if (count == null || count == 0) return;

    monies[money] = count - 1;
    state = state.copyWith(monies: monies, swipes: state.swipes + 1, last: money);
  }

  void reset() {
    state = state.copyWith(
      current: Denomination.fiveHundredNaira,
      last: null,
      monies: const {},
      duration: 0,
      swipes: 0,
    );
  }
}

final NotifierProvider<SprayNotifier, SprayState> sprayProvider =
    NotifierProvider(SprayNotifier.new);
