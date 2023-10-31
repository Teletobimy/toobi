import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:test01/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test01/screens/main_screen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); // 비동기 방식으로 작동하는 방식 => 플러터 코어 엔진을 초기화 시켜야함 "async" 비동기방식으로
  //  WidgetsFlutterBinding.ensureInitialized(); 사용 한 후에 initialize 해야 함
  await initializeDateFormatting();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CellMoim",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen2();
          }
          return const LoginSingUpScreen();
        },
      ),
    );
  }
}
