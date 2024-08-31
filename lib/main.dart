import 'package:flutter/material.dart';
//Importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:manage_clients/provider/searchProvider.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/AddClients': (context) => const AddClientPage(),
        '/viewClients': (context) => const ViewClientsPage(),
        '/registerPayment': (context) => const RegisterPaymentPage(),
      },
    );
  }
}
