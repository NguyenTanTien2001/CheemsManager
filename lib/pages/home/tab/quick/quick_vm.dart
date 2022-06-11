import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';

class QuickViewModel extends BaseViewModel {
  BehaviorSubject<List<QuickNoteModel>?> bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  QuickViewModel(ref) : super(ref) {
    firestoreService.quickNoteStream(user!.uid).listen((event) {
      bsListQuickNote.add(event);
    });
  }

  void successfulQuickNote(QuickNoteModel quickNoteModel) {
    // update to local
    quickNoteModel.isSuccessful = true;
    // update to network
    firestoreService.updateQuickNote(user!.uid, quickNoteModel);
  }

  void checkedNote(QuickNoteModel quickNoteModel, int idNote) {
    // check note
    quickNoteModel.listNote[idNote].check = true;
    // update note to network
    firestoreService.updateQuickNote(user!.uid, quickNoteModel);
  }

  void deleteNote(QuickNoteModel quickNoteModel) async {
    // delete note in network
    await firestoreService.deleteQuickNote(user!.uid, quickNoteModel.id);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
