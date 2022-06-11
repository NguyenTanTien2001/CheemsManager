import 'package:to_do_list/services/firestore_messing_service.dart';

import '/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(ref) : super(ref);

  void initMessingToken() {
    firestoreMessagingService.getToken();
  }

  void initMessagingChannel() {}

  void logOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
