import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/add_note_model.dart';
import 'package:visual_note/modules/edit_note/edit_note_screen.dart';
import 'package:visual_note/shared/components/components.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class NoteDetailsScreen extends StatelessWidget {
  final AddNoteModel model;
  final index;

  const NoteDetailsScreen({required this.model,required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.title,
            ),
            backgroundColor: Colors.amber,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 550,
                    width: double.infinity,
                    child: Image.network((model.image)),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.description,
                ),

              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: (){
                  navigateTo(context, EditNote(model:  AppCubit.get(context).notes[index]));
                },
                child: Icon(Icons.edit,),
                backgroundColor:Colors.amber,
              ),
              SizedBox(
                width: 20,
              ),
              // FloatingActionButton(
              //   onPressed: (){
              //
              //     // FirebaseFirestore.instance.collection('notes')
              //     //     .doc(uId).delete();
              //     // print('item delete');
              //   },
              //   child: Icon(Icons.delete,),
              //   backgroundColor:Colors.black,
              // ),
            ],
          ),


        );
      },
    );
  }
}

