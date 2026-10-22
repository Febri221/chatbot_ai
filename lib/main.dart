import 'package:chatbot_ai_document/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

// class TestGeminiScreen extends StatefulWidget {
//   const TestGeminiScreen({super.key});

//   @override
//   State<TestGeminiScreen> createState() => _TestGeminiScreenState();
// }

// class _TestGeminiScreenState extends State<TestGeminiScreen> {

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Colors.blue;
//     return MaterialApp(
//       title: 'StudiIn AI',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
//         useMaterial3: true,
//       ),
//       // Nanti arahkan ke halaman utama/upload PDF kalian
//       home: const Scaffold(
//         body: Center(
//           child: Text('StudiIn: AI Study Assistant Ready!'),
//         ),
//       ),
//     );
//   }
// }
