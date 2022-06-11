import 'package:riverpod/riverpod.dart';

import 'new_note_vm.dart';

final viewModelProvider = StateProvider.autoDispose<NewNoteViewModel>(
  (ref) {
    var vm = NewNoteViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
