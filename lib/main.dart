import 'package:flutter/material.dart';

// Modelo simples para nossos itens da lista (mantido)
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

// MyApp agora é StatefulWidget para gerenciar o tema
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Padrão para o tema do sistema

  // Método para alternar o tema
  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AltStore App Demo',
      theme: ThemeData( // Tema Claro
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData( // Tema Escuro
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Define que este é um tema escuro
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: _themeMode, // Controla qual tema está ativo
      home: MyHomePage(
        // Passando a função de toggle e o modo atual para MyHomePage
        onThemeModeChanged: _toggleTheme,
        currentThemeMode: _themeMode,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(ThemeMode) onThemeModeChanged;
  final ThemeMode currentThemeMode;

  const MyHomePage({
    super.key,
    required this.onThemeModeChanged,
    required this.currentThemeMode,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _textController = TextEditingController();
  String _displayText = 'Digite algo e pressione o botão!';

  final List<ListItem> _items = [
    ListItem(id: '1', title: 'Planeta Kepler', description: 'Kepler-186f é um exoplaneta que orbita a estrela anã vermelha Kepler-186, a cerca de 500 anos-luz da Terra.', icon: Icons.public_rounded),
    ListItem(id: '2', title: 'Galáxia de Andrômeda', description: 'A Galáxia de Andrômeda é uma galáxia espiral localizada a cerca de 2,5 milhões de anos-luz de distância da Terra.', icon: Icons.settings_brightness_rounded), // Ícone diferente
    ListItem(id: '3', title: 'Nebulosa de Órion', description: 'Um berçário estelar, a Nebulosa de Órion é uma das nebulosas difusas mais brilhantes e visíveis a olho nu no céu noturno.', icon: Icons.flare_rounded),
    ListItem(id: '4', title: 'Buraco Negro Supermassivo', description: 'Sagittarius A*, no centro da Via Láctea, é um exemplo de buraco negro supermassivo.', icon: Icons.radio_button_checked_rounded), // Ícone diferente
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
    // Determina o ícone do botão de tema com base no modo atual
    IconData themeIcon;
    if (widget.currentThemeMode == ThemeMode.light) {
      themeIcon = Icons.dark_mode_rounded;
    } else if (widget.currentThemeMode == ThemeMode.dark) {
      themeIcon = Icons.light_mode_rounded;
    } else { // ThemeMode.system
      // Para ThemeMode.system, podemos mostrar um ícone que sugere alternância ou o modo atual do sistema
      var brightness = MediaQuery.platformBrightnessOf(context);
      themeIcon = brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Universo Demo'), // Nome do app alterado
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(themeIcon),
            tooltip: 'Alternar Tema',
            onPressed: () {
              // Lógica para ciclar entre os temas: light -> dark -> system -> light ...
              if (widget.currentThemeMode == ThemeMode.light) {
                widget.onThemeModeChanged(ThemeMode.dark);
              } else if (widget.currentThemeMode == ThemeMode.dark) {
                widget.onThemeModeChanged(ThemeMode.system);
              } else {
                widget.onThemeModeChanged(ThemeMode.light);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Sobre o App',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sobre este App'),
                  content: const Text(
                      'App de demonstração Flutter com tema espacial, atualizações via AltStore e seletor de tema claro/escuro/sistema.'),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Contador Espacial:',
                            style: Theme.of(context).textTheme.titleLarge,
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
                      labelText: 'Mensagem Cósmica',
                      hintText: 'Ex: Olá, Universo!',
                      prefixIcon: const Icon(Icons.auto_awesome_outlined), // Ícone diferente
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
                    icon: const Icon(Icons.rocket_launch_rounded), // Ícone diferente
                    label: const Text('Enviar Mensagem'),
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
                    "Explorar o Cosmos:",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPadding(
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
                      leading: Hero( // Adicionado Hero aqui também para a transição
                        tag: 'icon_list_${item.id}',
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                          child: Icon(item.icon, color: Theme.of(context).colorScheme.onTertiaryContainer),
                        ),
                      ),
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text(item.description.substring(0, (item.description.length > 35 ? 35 : item.description.length)) + "..."),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      onTap: () => _navigateToDetail(context, item),
                    ),
                  );
                },
                childCount: _items.length,
              ),
            ),
          ),
           SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stars_rounded, size: 30, color: Theme.of(context).colorScheme.secondary),
                  const SizedBox(width: 8),
                  Text("Explorando com Flutter!", style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar Estrelas', // Tooltip alterado
        icon: const Icon(Icons.star_border_rounded), // Ícone alterado
        label: const Text("Contar Estrelas"), // Texto alterado
      ),
    );
  }
}

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
          child: SingleChildScrollView( // Permite rolagem se a descrição for muito longa
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'icon_list_${item.id}', // Tag deve ser a mesma da lista
                  child: CircleAvatar(
                    radius: 60, // Ícone maior na página de detalhes
                    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Icon(
                      item.icon,
                      size: 70,
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5), // Melhor espaçamento de linha
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  label: const Text('Voltar à Exploração'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

