import 'package:riverpod/riverpod.dart';

import 'sign_up_vm.dart';

final viewModelProvider = StateProvider.autoDispose<SignUpViewModel>(
  (ref) {
    var vm = SignUpViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
