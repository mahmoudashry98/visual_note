import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/cubit/states.dart';
import 'package:visual_note/models/user_model.dart';
import 'package:visual_note/shared/components/components.dart';
import 'package:visual_note/shared/components/constants.dart';

class CreateNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel? userModel;
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        },
      builder: (context, state) {
         var productModel = AppCubit.get(context).noteModel;
         var productImage = AppCubit.get(context).noteImage;
         return SingleChildScrollView(
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
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: productImage == null
                            ? AssetImage('assets/images/Image.png')
                            : FileImage(productImage) as ImageProvider,
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
                    // validate: (String? value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please Enter Your Title';
                    //   }
                    // },
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
                    // validate: (String? value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please Enter Your Description';
                    //   }
                    // },
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Checkbox(
                checkColor: Colors.white,
                value:  AppCubit.get(context).value,
                onChanged: (bool? value) {
                  AppCubit.get(context).checkbox(value);

                  print(value);

                },
              ),

              //ignore: deprecated_member_use
              ConditionalBuilder(
                condition: state is! AppCreateNoteLoadingState,
                builder: (context) =>
                    Container(
                  child: RaisedButton(
                    elevation: 10,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Thanks for Note'),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.amber,
                      ));
                      var now = DateTime.now();
                     // if (formKey.currentState!.validate()){
                       AppCubit.get(context).uploadNote(
                           //uId: userModel!.uId,
                           dateTime: now.toString(),
                           title: titleController.text,
                           description: descriptionController.text,
                           status: AppCubit.get(context).value,
                       );
                      //}
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.amber,
                    child: Text(
                      'Add Note',
                      style: TextStyle(
                        color: Colors.white,
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
        );
      },
    );
  }
}