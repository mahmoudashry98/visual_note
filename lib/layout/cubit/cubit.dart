import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/add_note_model.dart';
import 'package:visual_note/models/user_model.dart';
import 'package:visual_note/modules/creates_note/create_notes.dart';
import 'package:visual_note/modules/notes/notes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:visual_note/shared/components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // json model that i use to receive data from Firestore
  AddNoteModel? noteModel;
  UserModel? userModel;

  int currentIndex = 0;

  //toggle screens
  List<Widget> screens = [
    CreateNoteScreen(),
    NotesScreen(),
  ];

  //toggle titles
  List<String> title = [
    'Create Note',
    'Notes',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getNotes();
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  bool value = false;

  void checkbox(bool) {
    value = bool;
    emit(AppCheckBoxState());
  }

  List<UserModel> users = [];

  void getUsers() {
    emit(AppGetUserLoadingState());
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(AppGetUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetUserErrorState(error.toString()));
      });
    }
  }

  List<AddNoteModel> notes = [];

  void getNotes() {
    notes = [];
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('notes').get().then((value) {
      value.docs.forEach((element) {
        notes.add(AddNoteModel.fromJson(element.data()));
      });
      emit(AppGetNotesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetNotesErrorState(error.toString()));
    });
  }

  void removeNote() {
    FirebaseFirestore.instance
        .collection('notes')
        .doc(noteModel!.id)
        .delete()
        .then((value) {
      emit(AppDeleteState());
    }).catchError((onError) {});
  }

  // String imageNote = '';

  // void uploadImage({
  //   required String title,
  //   required String description,
  // }){
  //   emit(AppUploadImageLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('notes/${Uri.file(noteImage!.path)
  //       .pathSegments.last}')
  //       .putFile(noteImage!).then((value){
  //     value.ref.getDownloadURL().then((value) {
  //       emit(AppUploadImageSuccessState());
  //     }).catchError((error){
  //       emit(AppUploadImageErrorState(error.toString()));
  //
  //     });
  //   });
  // }

  void updateNote({
    required String title,
    required String description,
    required String image,
    required bool status,
    required String dateTime,
  }) {
    emit(AppAddNoteLoadingState());
    AddNoteModel model = AddNoteModel(
      title: title,
      image: image,
      description: description,
      dateTime: dateTime,
      status: status,
      id: ID,
    );

    FirebaseFirestore.instance
        .collection('notes')
        .doc(ID)
        .update(model.toMap())
        .then((value) {
      getNotes();
    }).catchError((error) {
      emit(AppUpdateNoteErrorState(error.toString()));
    });
  }

  File? noteImage;
  var picker = ImagePicker();
  var ID = '';

  Future<void> getNoteImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      noteImage = File(pickedFile.path);
      emit(AppGetNoteImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppGetNoteImagePickedErrorState());
    }
  }

  void uploadNoteWithImage({
    required String title,
    required String description,
    required String dateTime,
    required bool status,
  }) {
    emit(AppCreateNoteLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('notes/${Uri.file(noteImage!.path).pathSegments.last}')
        .putFile(noteImage!)
        .then((valuee) {
      valuee.ref.getDownloadURL().then((value) {
        print(value);
        createNote(
          title: title,
          description: description,
          status: status,
          dateTime: dateTime,
          image: value,
          id: valuee.ref.name,
        );
        ID = valuee.ref.name;
      }).catchError((error) {
        emit(AppCreateNoteErrorState(toString()));
      });
    }).catchError((error) {
      emit(AppCreateNoteErrorState(toString()));
    });
  }

  void createNote({
    required String title,
    required String description,
    required String image,
    required bool status,
    required String dateTime,
    required String? id,
  }) {
    emit(AppCreateNoteLoadingState());

    AddNoteModel model = AddNoteModel(
      title: title,
      description: description,
      status: status,
      dateTime: dateTime,
      image: image,
      id: id,
    );

    FirebaseFirestore.instance
        .collection('notes')
        .doc(id)
        .set(model.toMap())
        .then((value) {
      emit(AppCreateNoteSuccessState());
    }).catchError((error) {
      emit(AppCreateNoteErrorState(toString()));
    });
  }
}
