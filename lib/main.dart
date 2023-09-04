import 'package:flutter/material.dart';
import 'package:fun_app/core/di/injection_container_getit.dart' as di;
import 'package:fun_app/core/util/local_db_service.dart';
import 'package:fun_app/features/presentation/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sqliteService = SqliteService();
  await sqliteService.initializeDB();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
