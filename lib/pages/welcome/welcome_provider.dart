import 'package:riverpod/riverpod.dart';

import 'welcome_vm.dart';

final viewModelProvider = StateProvider.autoDispose<WelcomeViewModel>(
  (ref) {
    var vm = WelcomeViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
