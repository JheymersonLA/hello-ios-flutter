import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'controllers/gemini_controller.dart';
import 'services/firebase_service.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/horoscope_form_screen.dart';
import 'screens/horoscope_result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const HoroscopeApp());
}

class HoroscopeApp extends StatefulWidget {
  const HoroscopeApp({super.key});

  @override
  State<HoroscopeApp> createState() => _HoroscopeAppState();
}

class _HoroscopeAppState extends State<HoroscopeApp> {
  int _step = 0;
  String? _uid;
  Map<String, String>? _userData;
  String? _horoscopo;
  final GeminiController _geminiController = GeminiController(
    geminiApiUrl: 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent',
    geminiApiKey: 'AIzaSyCc3Rwz6RBQ9Ayo5EngCH5JO8fbefJ2tUI',
  );

  void _goToAuth() => setState(() => _step = 1);
  void _onAuthSuccess(String uid) {
    _uid = uid;
    setState(() => _step = 2);
  }
  void _onFormSubmit(Map<String, String> data) async {
    setState(() => _userData = data);
    final horoscopo = await _geminiController.gerarHoroscopo(
      signo: data['signo']!,
      dataNascimento: data['data']!,
      horarioNascimento: data['hora']!,
      localNascimento: data['local']!,
      nomeCompleto: data['nome'],
    );
    setState(() {
      _horoscopo = horoscopo;
      _step = 3;
    });
    if (_uid != null) {
      await FirebaseService.saveUserHoroscopeData(
        uid: _uid!,
        data: {
          ...data,
          'horoscopo': horoscopo,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    }
  }
  void _reset() => setState(() => _step = 0);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _step == 0
            ? WelcomeScreen(onStart: _goToAuth)
            : _step == 1
                ? AuthScreen(onAuthSuccess: _onAuthSuccess)
                : _step == 2
                    ? HoroscopeFormScreen(onSubmit: _onFormSubmit)
                    : HoroscopeResultScreen(
                        horoscopo: _horoscopo ?? '',
                        onBack: _reset,
                      ),
      ),
    );
  }
}

