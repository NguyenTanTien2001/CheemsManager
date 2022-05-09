import '/models/quick_note_model.dart';

import '/base/base_view_model.dart';

class NewNoteViewModel extends BaseViewModel {
  NewNoteViewModel(ref) : super(ref);

  Future<void> newNote(QuickNoteModel quickNote) async {
    startRunning();
    // update new quick note to network
    await firestoreService.addQuickNote(user!.uid, quickNote);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
