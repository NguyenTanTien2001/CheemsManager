import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_user_form_vm.dart';

final viewModelProvider = StateProvider.autoDispose<ListUserFormViewModel>(
  (ref) {
    var vm = ListUserFormViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
