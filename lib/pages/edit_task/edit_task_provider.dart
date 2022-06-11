import 'package:riverpod/riverpod.dart';

import 'edit_task_vm.dart';

final viewModelProvider = StateProvider.autoDispose<EditTaskViewModel>(
  (ref) {
    var vm = EditTaskViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
