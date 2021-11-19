import 'package:appframework/src/views/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  /* FirebaseApp app = await Firebase.initializeApp();
  assert(app != null); */
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Digital FrameWork",
    home: Login(),
  ));
}
