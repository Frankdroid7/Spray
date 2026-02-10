import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';

final List<SprayReceiver> _dummyReceivers = List.generate(
  6,
  (i) => SprayReceiver(id: "$i"),
);

class SearchReceiverState {
  final bool loading;
  final String error;
  final List<SprayReceiver> receivers;
  final int selectedReceiverIndex;

  const SearchReceiverState({
    this.receivers = const [],
    this.loading = false,
    this.error = "",
    this.selectedReceiverIndex = -1,
  });

  SearchReceiverState copyWith({
    List<SprayReceiver>? receivers,
    bool? loading,
    String? error,
    int? selectedReceiverIndex,
  }) {
    return SearchReceiverState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      receivers: receivers ?? this.receivers,
      selectedReceiverIndex:
          selectedReceiverIndex ?? this.selectedReceiverIndex,
    );
  }
}

class SearchReceiverNotifier extends Notifier<SearchReceiverState> {
  SearchReceiverNotifier();

  @override
  SearchReceiverState build() => const SearchReceiverState();

  void search(String query) async {
    if (query.isEmpty) {
      state = state.copyWith(
        loading: false,
        receivers: [],
        selectedReceiverIndex: -1,
      );
      return;
    }

    state = state.copyWith(
      loading: true,
      receivers: _dummyReceivers,
      selectedReceiverIndex: -1,
    );
    await Future.delayed(Duration(seconds: 1));
    state = state.copyWith(
      receivers: [
        SprayReceiver(id: "1", name: "Freeborn Ehirhere", tag: "@Freeborn"),
      ],
      loading: false,
    );
  }

  void selectReceiver(int index) {
    state = state.copyWith(selectedReceiverIndex: index);
  }
}

final NotifierProvider<SearchReceiverNotifier, SearchReceiverState>
searchReceiversProvider = NotifierProvider(SearchReceiverNotifier.new);
