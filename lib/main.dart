import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello AltStore App',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Mudei a cor primária para exemplo
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, // Habilitando Material 3 para um visual mais moderno
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false, // Remove o banner de debug
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _textController = TextEditingController();
  String _displayText = 'Digite algo abaixo!';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _updateDisplayText() {
    setState(() {
      if (_textController.text.isEmpty) {
        _displayText = 'Digite algo abaixo!';
      } else {
        _displayText = 'Você digitou: ${_textController.text}';
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter AltStore Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('App de demonstração para AltStore!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bem-vindo ao App Flutter!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                'Você pressionou o botão de "+" esta quantidade de vezes:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                _displayText,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Limita a largura
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Escreva uma mensagem',
                    hintText: 'Ex: Olá Flutter!',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                  onSubmitted: (value) => _updateDisplayText(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Atualizar Texto Acima'),
                onPressed: _updateDisplayText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}