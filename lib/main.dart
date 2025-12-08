import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hqcdhreharfszhsdmqlm.supabase.co',
    anonKey: 
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxY2RocmVoYXJmc3poc2RtcWxtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ0MDA5NjYsImV4cCI6MjA3OTk3Njk2Nn0.y2yNSnwidqJus5s4XiUTI2KnG0C6W6mXkP8WAUVt9N4',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }

}
