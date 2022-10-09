import 'package:riverpod/riverpod.dart';

import 'my_note_vm.dart';

final viewModelProvider = StateProvider.autoDispose<MyNoteViewModel>(
  (ref) {
    var vm = MyNoteViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
