import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:visual_note/layout/cubit/cubit.dart';
import 'package:visual_note/layout/home_layout.dart';
import 'package:visual_note/modules/login/login_screen.dart';
import 'package:visual_note/modules/register/register_screen.dart';
import 'package:visual_note/shared/bloc_observer.dart';
import 'layout/cubit/states.dart';
import 'models/add_note_model.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  Bloc.observer = MyBlocObserver();
  Widget? widget;
   uId = CacheHelper.getData(key: 'uId');
  print(uId);
  //  id = CacheHelper.getData(key: 'id');
  // print(id);

  if (uId != null) {
    widget = HomeLayoutScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({
    this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUsers()
        ..getNotes(),

      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.amber

              ),
              debugShowCheckedModeBanner: false,
              home:SplashScreenView(
                navigateRoute: startWidget,
                duration: 5000,
                imageSize: 130,
                imageSrc: "assets/images/image2.jpg",
                text: "Visual Notes",
                textType: TextType.ColorizeAnimationText,
                textStyle: TextStyle(
                  fontSize: 40.0,
                ),
                colors: [
                  Colors.orange,
                  Colors.brown,
                  Colors.yellow,
                ],
                backgroundColor: Colors.white,
              ),
            );
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
