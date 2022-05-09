import 'package:riverpod/riverpod.dart';

import 'quick_vm.dart';

final viewModelProvider = StateProvider.autoDispose<QuickViewModel>(
  (ref) {
    var vm = QuickViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
