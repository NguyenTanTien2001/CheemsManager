import 'package:riverpod/riverpod.dart';

import 'profile_vm.dart';

final viewModelProvider = StateProvider.autoDispose<ProfileViewModel>(
  (ref) {
    var vm = ProfileViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
