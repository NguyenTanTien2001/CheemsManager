import 'package:riverpod/riverpod.dart';

import 'detail_task_vm.dart';

final viewModelProvider = StateProvider.autoDispose<DetailTaskViewModel>(
  (ref) {
    var vm = DetailTaskViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
