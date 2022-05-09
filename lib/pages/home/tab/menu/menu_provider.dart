import 'package:riverpod/riverpod.dart';

import 'menu_vm.dart';

final viewModelProvider = StateProvider.autoDispose<MenuViewModel>(
  (ref) {
    var vm = MenuViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
