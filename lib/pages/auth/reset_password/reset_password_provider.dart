import 'package:riverpod/riverpod.dart';

import 'reset_password_vm.dart';

final viewModelProvider = StateProvider.autoDispose<ResetPasswordViewModel>(
  (ref) {
    var vm = ResetPasswordViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
