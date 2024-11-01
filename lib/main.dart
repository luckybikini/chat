import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart' as fbOptions; // firebase_options.dart에 별칭 추가
import 'screens/login_screen.dart'; // 로그인 화면 import

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Flutter 바인딩 초기화
  await Firebase.initializeApp(
    options: fbOptions.DefaultFirebaseOptions.currentPlatform, // Firebase 구성 옵션 추가
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Party App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(), // 로그인 화면으로 시작
    );
  }
}
