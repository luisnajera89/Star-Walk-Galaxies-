import 'package:camera/camera.dart';
import 'package:first_app_9/models/cat_model.dart';
import 'package:first_app_9/screens/details_page.dart';
import 'package:first_app_9/screens/home_page.dart';
import 'package:first_app_9/screens/taken_picture_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final first = cameras.first;

  runApp(SqliteApp(
    firstCamera: first,
  ));
}

class SqliteApp extends StatelessWidget {
  final CameraDescription firstCamera;

  const SqliteApp({Key? key, required this.firstCamera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Walk (Galaxies Application)',
      initialRoute: 'home',
      routes: {'home': (context) => HomePageWidget(firstCamera: firstCamera)},
      theme: ThemeData.light().copyWith(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 17, 95, 241))),
    );
  }
}
