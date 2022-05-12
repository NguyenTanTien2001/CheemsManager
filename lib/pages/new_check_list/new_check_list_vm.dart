import '/models/quick_note_model.dart';
import '/base/base_view_model.dart';

class NewCheckListViewModel extends BaseViewModel {
  NewCheckListViewModel(ref) : super(ref);

  void newNote(QuickNoteModel quickNote) async {
    startRunning();
    await firestoreService.addQuickNote(user!.uid, quickNote);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
