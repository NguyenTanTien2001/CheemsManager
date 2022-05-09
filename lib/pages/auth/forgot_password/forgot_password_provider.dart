import 'package:riverpod/riverpod.dart';

import 'forgot_password_vm.dart';

final viewModelProvider = StateProvider.autoDispose<ForgotPasswordViewModel>(
  (ref) {
    var vm = ForgotPasswordViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
