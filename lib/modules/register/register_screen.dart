import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_note/layout/home_layout.dart';
import 'package:visual_note/modules/login/login_screen.dart';
import 'package:visual_note/modules/register/cubit/states.dart';
import 'package:visual_note/shared/components/components.dart';

import 'cubit/cubit.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var storeNameController = TextEditingController();

    return BlocProvider(
      create: (context) => VisualNoteRegisterCubit(),
      child: BlocConsumer<VisualNoteRegisterCubit, VisualNoteRegisterStates>(
        listener: (context, state) {
          if(state is VisualNoteRegisterSuccessState)
          {
            navigateAndFinish(context, HomeLayoutScreen());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Thanks for Sign Up'),
              duration: Duration(seconds: 4),
              backgroundColor: Colors.green,
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  navigateTo(context, LoginScreen());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'name',
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'email address',
                        hintText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'password',
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.end,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.amber,
                        onPressed: () {
                          VisualNoteRegisterCubit.get(context).userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            storeName: storeNameController.text,
                            password: passwordController.text,
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150.0,
                    ),
                    Center(
                        child: Text(
                      'Or login with social account',
                      style: TextStyle(fontSize: 15.0),
                    )),
                    SizedBox(
                      height: 25.0,
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
