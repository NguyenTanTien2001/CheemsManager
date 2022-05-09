import 'package:riverpod/riverpod.dart';

import 'sign_in_vm.dart';

final viewModelProvider = StateProvider.autoDispose<SignInViewModel>(
  (ref) {
    var vm = SignInViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
