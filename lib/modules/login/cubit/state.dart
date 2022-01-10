abstract class VisualNoteLoginStates {}

class VisualNoteLoginInitialState extends VisualNoteLoginStates {}

class VisualNoteLoginLoadingState extends VisualNoteLoginStates {}

class VisualNoteLoginSuccessState extends VisualNoteLoginStates {

  final String uId;

  VisualNoteLoginSuccessState(this.uId);
}


class VisualNoteLoginErrorState extends VisualNoteLoginStates {
  final String error;

  VisualNoteLoginErrorState(this.error);
}
