import 'package:flutter/material.dart';

// Modelo simples para nossos itens da lista
class ListItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  ListItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AltStore App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
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
  String _displayText = 'Digite algo e pressione o botão!';

  // Lista de itens de exemplo
  final List<ListItem> _items = [
    ListItem(id: '1', title: 'Item Alpha', description: 'Descrição detalhada do Item Alpha.', icon: Icons.looks_one_rounded),
    ListItem(id: '2', title: 'Item Beta', description: 'Informações sobre o Item Beta aqui.', icon: Icons.looks_two_rounded),
    ListItem(id: '3', title: 'Item Gamma', description: 'Tudo sobre o fantástico Item Gamma.', icon: Icons.looks_3_rounded),
    ListItem(id: '4', title: 'Item Delta', description: 'Detalhes e mais detalhes do Item Delta.', icon: Icons.looks_4_rounded),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _updateDisplayText() {
    setState(() {
      if (_textController.text.isEmpty) {
        _displayText = 'Por favor, digite uma mensagem.';
      } else {
        _displayText = 'Você digitou: ${_textController.text}';
      }
    });
  }

  void _navigateToDetail(BuildContext context, ListItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(item: item),
      ),
    );
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
        title: const Text('Flutter AltStore Demo App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Sobre o App',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sobre este App'),
                  content: const Text(
                      'Este é um aplicativo Flutter de demonstração para AltStore, com atualizações automáticas via GitHub Actions e uma fonte AltStore personalizada.\n\nFuncionalidades:\n- Contador\n- Campo de Texto\n- Lista de Itens com Navegação para Detalhes'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView( // Usando CustomScrollView para combinar diferentes tipos de rolagem
        slivers: <Widget>[
          SliverToBoxAdapter( // Para conteúdo não-lista
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Contador de Cliques:',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _displayText,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelText: 'Sua Mensagem',
                      hintText: 'Escreva algo aqui...',
                      prefixIcon: const Icon(Icons.message_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Limpar Texto',
                        onPressed: () {
                          _textController.clear();
                          setState(() {
                             _displayText = 'Digite algo e pressione o botão!';
                          });
                        },
                      )
                    ),
                    onSubmitted: (value) => _updateDisplayText(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Mostrar Mensagem Digitada'),
                    onPressed: _updateDisplayText,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(thickness: 1, color: Theme.of(context).colorScheme.outlineVariant),
                  const SizedBox(height: 10),
                  Text(
                    "Itens para Detalhes:",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPadding( // Adicionando padding ao redor da lista
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = _items[index];
                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(item.icon, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      ),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text(item.description.substring(0, (item.description.length > 30 ? 30 : item.description.length)) + "..."), // Pequena prévia
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () => _navigateToDetail(context, item),
                    ),
                  );
                },
                childCount: _items.length,
              ),
            ),
          ),
           SliverToBoxAdapter( // Espaço no final
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.flutter_dash_rounded, size: 30, color: Colors.lightBlue),
                  const SizedBox(width: 8),
                  Text("Feito com Flutter!", style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar Contador',
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: const Text("Incrementar"),
      ),
    );
  }
}

// Nova tela para exibir detalhes do item
class DetailPage extends StatelessWidget {
  final ListItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero( // Animação de transição para o ícone
                tag: 'icon_${item.id}', // Tag única para o Hero
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  child: Icon(
                    item.icon,
                    size: 60,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                label: const Text('Voltar para a Lista'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}