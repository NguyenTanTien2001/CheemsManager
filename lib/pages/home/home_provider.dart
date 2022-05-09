import 'package:riverpod/riverpod.dart';

import 'home_vm.dart';

final viewModelProvider = StateProvider.autoDispose<HomeViewModel>(
      (ref) {
    var vm = HomeViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
