import 'package:appframework/src/views/login.dart';
import 'package:flutter/material.dart';

void main() async {
  /* FirebaseApp app = await Firebase.initializeApp();
  assert(app != null); */
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Digital FrameWork",
    home: Login(),
    theme: ThemeData(
      fontFamily: 'Montserrat',
    ),
  ));
}
