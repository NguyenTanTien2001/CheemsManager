import 'package:riverpod/riverpod.dart';

import 'my_task_vm.dart';

final viewModelProvider = StateProvider.autoDispose<MyTaskViewModel>(
      (ref) {
    var vm = MyTaskViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
