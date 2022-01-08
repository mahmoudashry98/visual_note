import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/modules/login/cubit/state.dart';


class VisualNoteLoginCubit extends Cubit<VisualNoteLoginStates> {
  VisualNoteLoginCubit() : super(VisualNoteLoginInitialState());

  static VisualNoteLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required email,
    @required password,
  }) {
    emit(VisualNoteLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(VisualNoteLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(VisualNoteLoginErrorState(error.toString()));
    });
  }
}
