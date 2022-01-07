abstract class AppStates {}

class AppInitialState extends AppStates {}

// get product
class AppGetProductLoadingState extends AppStates {}

class AppGetProductSuccessState extends AppStates {}

class AppGetProductErrorState extends AppStates {}

//create note

class AppCreateNoteLoadingState extends AppStates {}

class AppCreateNoteSuccessState extends AppStates {}

class AppCreateNoteErrorState extends AppStates {
  final String error;

  AppCreateNoteErrorState(this.error);
}

//change bottom

class AppChangeBottomNavState extends AppStates {}

class AppCheckBoxState extends AppStates {}
