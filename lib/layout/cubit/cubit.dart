import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/product_model.dart';
import 'package:visual_note/modules/creates_note/create_notes.dart';
import 'package:visual_note/modules/notes/notes.dart';
import 'package:visual_note/modules/note_details/note_details.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // json model that i use to receive data from Firestore
  ProductModel? productModel;

  int currentIndex = 0;

  List<Widget> screens = [
    CreateNoteScreen(),
    NotesScreen(),
    NoteDetailsScreen()
  ];
  List<String> title = ['Create Note', 'Notes', 'Details'];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  bool value = false;

  void checkbox(bool) {
    value = bool;
    emit(AppCheckBoxState());
  }

  void createNote({
    required String image,
    required String title,
    required String description,
    required String dateTime,
    required String uId,
    required bool status,
  }) {
    emit(AppCreateNoteLoadingState());
    ProductModel model = ProductModel(
      uId: uId,
      image: image,
      dateTime: dateTime,
      description: description,
      title: title,
      status: status,
    );
    FirebaseFirestore.instance
        .collection('notes')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(AppCreateNoteSuccessState());
    }).catchError((error) {
      emit(AppCreateNoteErrorState(error.toString()));
    });
  }
}
