import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/add_note_model.dart';
import 'package:visual_note/shared/components/components.dart';

class EditNote extends StatelessWidget {

  final AddNoteModel model;
  const EditNote({required this.model});

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        titleController.text = model.title;
        descriptionController.text = model.description;
        var noteImage = AppCubit.get(context).noteImage;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Note',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateNote(
                      title: titleController.text,
                      description: descriptionController.text,
                    status: model.status,
                    dateTime: model.dateTime,

                  );
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: noteImage == null
                              ? NetworkImage(model.image)
                              : FileImage(noteImage) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                            Icons.camera_alt,
                          color: Colors.amber,
                          size: 15,
                        ),
                      ),
                      onPressed: () {
                        AppCubit.get(context).getNoteImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                    label: 'Title',
                    prefix: Icons.title,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Title';
                      }
                    },
                    controller: titleController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defaultFormField(
                    label: 'Description',
                    prefix: Icons.description,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Description';
                      }
                    },
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),

        );
      },
    );
  }
}
