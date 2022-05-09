import 'package:riverpod/riverpod.dart';

import 'new_task_vm.dart';

final viewModelProvider = StateProvider.autoDispose<NewTaskViewModel>(
  (ref) {
    var vm = NewTaskViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
