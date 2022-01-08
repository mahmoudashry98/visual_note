abstract class VisualNoteRegisterStates{}

class VisualNoteRegisterInitialState extends VisualNoteRegisterStates {}

class VisualNoteRegisterLoadingState extends VisualNoteRegisterStates {}

class VisualNoteRegisterErrorState extends VisualNoteRegisterStates {

  final String error;

  VisualNoteRegisterErrorState(this.error);
}

class VisualNoteRegisterSuccessState extends VisualNoteRegisterStates {}


class VisualNoteCreateUserSuccessState extends VisualNoteRegisterStates {
  late final String uId;

  VisualNoteCreateUserSuccessState(this.uId);


}

class VisualNoteCreateUserErrorState extends VisualNoteRegisterStates
{
  late final String error;

  VisualNoteCreateUserErrorState(this.error);
}