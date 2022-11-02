import 'package:riverpod/riverpod.dart';

import 'project_vm.dart';

final viewModelProvider = StateProvider.autoDispose<ProjectViewModel>(
  (ref) {
    var vm = ProjectViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
