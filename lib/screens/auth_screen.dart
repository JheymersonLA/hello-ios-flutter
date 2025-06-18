import 'package:flutter/cupertino.dart';
import '../services/firebase_service.dart';

class AuthScreen extends StatefulWidget {
  final void Function(String uid) onAuthSuccess;
  const AuthScreen({super.key, required this.onAuthSuccess});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  String? _error;
  bool _loading = false;

  Future<void> _submit() async {
    setState(() { _loading = true; _error = null; });
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final userCredential = _isLogin
        ? await FirebaseService.signInWithEmail(email, password)
        : await FirebaseService.registerWithEmail(email, password);
      widget.onAuthSuccess(userCredential.user!.uid);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Autenticação'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefix: const Icon(CupertinoIcons.mail),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Senha',
                obscureText: true,
                prefix: const Icon(CupertinoIcons.lock),
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: CupertinoColors.systemRed)),
              if (_loading)
                const CupertinoActivityIndicator(),
              if (!_loading)
                CupertinoButton.filled(
                  child: Text(_isLogin ? 'Entrar' : 'Registrar'),
                  onPressed: _submit,
                ),
              CupertinoButton(
                child: Text(_isLogin ? 'Criar conta' : 'Já tenho conta'),
                onPressed: () => setState(() => _isLogin = !_isLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}