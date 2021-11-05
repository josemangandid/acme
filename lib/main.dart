import 'package:acme/app/app.dart';
import 'package:acme/app/glogal_widgets/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final p = PrefsUser();
  await p.initPrefs();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
