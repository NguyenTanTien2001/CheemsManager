import '/models/quick_note_model.dart';
import '/base/base_view_model.dart';

class NewCheckListViewModel extends BaseViewModel {
  NewCheckListViewModel(ref) : super(ref);

  void newQuickNote(QuickNoteModel quickNote) async {
    startRunning();
    await firestoreService.addQuickNote(user!.uid, quickNote);
    endRunning();
  }

  void newTaskkNote(QuickNoteModel quickNote, String taskId) async {
    startRunning();
    await firestoreService.addTaskNote(taskId, quickNote);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
