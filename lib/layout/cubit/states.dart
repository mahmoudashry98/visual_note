abstract class AppStates {}

class AppInitialState extends AppStates {}

// get note
class AppGetNoteLoadingState extends AppStates {}

class AppGetNoteSuccessState extends AppStates {}

class AppGetNoteErrorState extends AppStates {
  final String error;

  AppGetNoteErrorState(this.error);
}

// get userData

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}


//create note

class AppCreateNoteLoadingState extends AppStates {}

class AppCreateNoteSuccessState extends AppStates {}

class AppCreateNoteErrorState extends AppStates {

  final String error;

  AppCreateNoteErrorState(this.error);
}

//change bottom

class AppChangeBottomNavState extends AppStates {}

//checkBox

class AppCheckBoxState extends AppStates {}

//getNoteImage

class AppGetNoteImagePickedSuccessState extends AppStates {}

class AppGetNoteImagePickedErrorState extends AppStates {}




