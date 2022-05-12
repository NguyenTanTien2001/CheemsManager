import 'package:riverpod/riverpod.dart';

import 'new_check_list_vm.dart';

final viewModelProvider = StateProvider.autoDispose<NewCheckListViewModel>(
  (ref) {
    var vm = NewCheckListViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
