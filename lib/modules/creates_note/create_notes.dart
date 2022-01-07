import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/shared/components/components.dart';

class CreateNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateNoteSuccessState) {}
      },
      builder: (context, state) {
        var productModel = AppCubit.get(context).productModel;

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
                      print('jbvifg');
                    },
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/Image.png',
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
                  height: 100,
                ),
            Checkbox(
              checkColor: Colors.white,
              value:  AppCubit.get(context).value,
              onChanged: (bool? value) {
                AppCubit.get(context).checkbox(value);

                print(value);

              },
            ),

                // ignore: deprecated_member_use
                // ConditionalBuilder(
                //   condition: state is! AppCreateNoteLoadingState,
                //   builder: (context) => Container(
                //     child: RaisedButton(
                //       elevation: 10,
                //       onPressed: () {
                //         if (formKey.currentState!.validate()){
                //           AppCubit.get(context).createNote(
                //             image: image,
                //             title: title,
                //             description: description,
                //             dateTime: dateTime,
                //             uId: uId,
                //           );
                //         }
                //       },
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15)),
                //       color: Colors.amber,
                //       child: Text(
                //         'Add Note',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                //   fallback: (context) =>
                //       Center(child: CircularProgressIndicator()),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
