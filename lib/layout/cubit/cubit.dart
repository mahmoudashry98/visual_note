import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/note_model.dart';
import 'package:visual_note/models/user_model.dart';
import 'package:visual_note/modules/creates_note/create_notes.dart';
import 'package:visual_note/modules/notes/notes.dart';
import 'package:visual_note/modules/note_details/note_details.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:visual_note/shared/components/constants.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // json model that i use to receive data from Firestore
  NoteModel? noteModel;
  UserModel? userModel;

  int currentIndex = 0;
  //toggle screens
  List<Widget> screens = [
    CreateNoteScreen(),
    NotesScreen(),
    NoteDetailsScreen()
  ];
  //toggle titles
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

  File? noteImage;
  var picker = ImagePicker();

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


  void uploadNote({
    required String title,
    required String description,
    required bool status,
    required String dateTime,
  })
  {
    emit(AppCreateNoteLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('notes/${Uri.file(noteImage!.path)
        .pathSegments.last}')
        .putFile(noteImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
          NoteModel model = NoteModel(
            title: title,
            description:description ,
            status: status,
            dateTime: dateTime,
            image: value,
          );

                FirebaseFirestore.instance
                    .collection('notes')
                    .add(model.toMap())
                    .then((value) {
                  emit(AppCreateNoteSuccessState());
                })
                    .catchError((error){
                  emit(AppCreateNoteErrorState(error.toString()));
                });
            emit(AppCreateNoteSuccessState());
          }).catchError((error) {
            emit(AppCreateNoteErrorState(error.toString()));
          });
      });

  }

}
