import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/models/user_model.dart';
import 'package:visual_note/modules/register/cubit/states.dart';


class VisualNoteRegisterCubit extends Cubit<VisualNoteRegisterStates> {
  VisualNoteRegisterCubit() : super(VisualNoteRegisterInitialState());

  static VisualNoteRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String storeName,
    required String password,
  }) {
    emit(VisualNoteRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value)
    {
      createUser(
          name: name,
          email: email,
          storeName: storeName,
          uId: value.user!.uid);
    })
        .catchError((error) {
      emit(VisualNoteRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String storeName,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId,
    );


    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(VisualNoteRegisterSuccessState());
    });
  }
}
