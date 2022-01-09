import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/shared/components/components.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CreateNoteScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppAddNoteErrorState) {}
      },
      builder: (context, state) {
        var noteImage = AppCubit.get(context).noteImage;
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  child: InkWell(
                    onTap: () {
                      AppCubit.get(context).getNoteImage();
                    },
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: noteImage == null
                              ? AssetImage('assets/images/Image.png')
                              : FileImage(noteImage) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 10.0,
                  child: Container(
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
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 10.0,
                  child: Container(
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
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      value: AppCubit.get(context).value,
                      onChanged: (bool? value) {
                        AppCubit.get(context).checkbox(value);
                        print(value);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),

                //ignore: deprecated_member_use
                ConditionalBuilder(
                  condition: state is! AppCreateNoteLoadingState,
                  builder: (context) => Container(
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () {
                        var now = DateTime.now();
                        String formattedDate =
                            DateFormat.MMMEd().add_jm().format(now);
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).uploadNoteImage(
                              title: titleController.text,
                              description: descriptionController.text,
                              dateTime: formattedDate.toString(),
                              status: AppCubit.get(context).value,
                          );

                        }
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.amber,
                      child: Text(
                        'Add Note',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
