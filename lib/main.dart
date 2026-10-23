import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';

void main() async {
  // Aseguramos que los widgets de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializamos Firebase con tus credenciales copiadas
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD7_MN3_urvrh1A9NnGIbQKJTVn8PWAMlM",
      authDomain: "tokustore-app.firebaseapp.com",
      projectId: "tokustore-app",
      storageBucket: "tokustore-app.firebasestorage.app",
      messagingSenderId: "534024789535",
      appId: "1:534024789535:web:a7536757c830fa72973f2a",
    ),
  );

  runApp(const MiTiendaApp());
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TokuStore - Kamen Rider Zeztz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00FF66)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}