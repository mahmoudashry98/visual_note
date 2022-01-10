abstract class AppStates {}

class AppInitialState extends AppStates {}

// getUserData
class AppGetUserLoadingState extends AppStates {}
class AppGetUserSuccessState extends AppStates {}
class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}

// getNoteData
class AppGetNotesLoadingState extends AppStates {}
class AppGetNotesSuccessState extends AppStates {}
class AppGetNotesErrorState extends AppStates {
  final String error;

  AppGetNotesErrorState(this.error);
}

//createNote
class AppCreateNoteLoadingState extends AppStates {}
class AppCreateNoteSuccessState extends AppStates {}
class AppCreateNoteErrorState extends AppStates {
  final String error;

  AppCreateNoteErrorState(this.error);
}

//changeBottom
class AppChangeBottomNavState extends AppStates {}

//checkBox
class AppCheckBoxState extends AppStates {}

//getNoteImage
class AppGetNoteImagePickedSuccessState extends AppStates {}
class AppGetNoteImagePickedErrorState extends AppStates {}

//uploadImage
class AppUploadImageLoadingState extends AppStates {}
class AppUploadImageSuccessState extends AppStates {}
class AppUploadImageErrorState extends AppStates {
  final String error;

  AppUploadImageErrorState(this.error);
}

//addNote
class AppAddNoteLoadingState extends AppStates {}
class AppDeleteState extends AppStates {}
class AppAddNoteSuccessState extends AppStates {}
class AppAddNoteErrorState extends AppStates {
  final String error;

  AppAddNoteErrorState(this.error);
}

//updateNote
class AppUpdateNoteLoadingState extends AppStates {}
class AppUpdateNoteErrorState extends AppStates {
  final String error;

  AppUpdateNoteErrorState(this.error);
}

//saveNoteId
class VisualNoteIdSuccessState extends AppStates {

  final String id;

  VisualNoteIdSuccessState(this.id);
}





