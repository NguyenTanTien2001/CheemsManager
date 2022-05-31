import '/models/quick_note_model.dart';

import '/base/base_view_model.dart';

class NewNoteViewModel extends BaseViewModel {
  NewNoteViewModel(ref) : super(ref);

  Future<void> newQuickNote(QuickNoteModel quickNote) async {
    startRunning();
    // update new quick note to network
    await firestoreService.addQuickNote(user!.uid, quickNote);
    endRunning();
  }

  Future<void> newTaskNote(QuickNoteModel quickNote, String taskId) async {
    startRunning();
    // update new quick note to network
    await firestoreService.addTaskNote(taskId, quickNote);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
