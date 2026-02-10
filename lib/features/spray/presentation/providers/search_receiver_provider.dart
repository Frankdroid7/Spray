import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';

final List<SprayReceiver> _dummyReceivers = List.generate(6, (i) => SprayReceiver(id: "$i"));


class SearchReceiverState {
  final bool loading;
  final String error;
  final List<SprayReceiver> receivers;

  const SearchReceiverState({
    this.receivers = const [],
    this.loading = false,
    this.error = "",
  });

  SearchReceiverState copyWith({
    List<SprayReceiver>? receivers,
    bool? loading,
    String? error,
  }) {
    return SearchReceiverState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      receivers: receivers ?? this.receivers,
    );
  }
}

class SearchReceiverNotifier extends Notifier<SearchReceiverState> {
  SearchReceiverNotifier();

  @override
  SearchReceiverState build() => const SearchReceiverState();

  void search(String query) async {
    if(query.isEmpty) {
      state = state.copyWith(loading: false, receivers: []);
      return;
    }

    state = state.copyWith(loading: true, receivers: _dummyReceivers);
    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(
      receivers: [
        SprayReceiver(id: "1", name: "Freeborn Ehirhere", tag: "@Freeborn"),
      ],
      loading: false,
    );
  }
}

final NotifierProvider<SearchReceiverNotifier, SearchReceiverState>
searchReceiversProvider = NotifierProvider(SearchReceiverNotifier.new);

