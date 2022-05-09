import 'package:riverpod/riverpod.dart';

import 'splash_vm.dart';

final viewModelProvider = StateProvider.autoDispose<SplashViewModel>(
  (ref) {
    var vm = SplashViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
