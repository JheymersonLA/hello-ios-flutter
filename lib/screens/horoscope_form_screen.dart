import 'package:flutter/cupertino.dart';

class HoroscopeFormScreen extends StatefulWidget {
  final void Function(Map<String, String>) onSubmit;
  const HoroscopeFormScreen({super.key, required this.onSubmit});

  @override
  State<HoroscopeFormScreen> createState() => _HoroscopeFormScreenState();
}

class _HoroscopeFormScreenState extends State<HoroscopeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _signoController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _localController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _signoController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    _localController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit({
        'nome': _nomeController.text,
        'signo': _signoController.text,
        'data': _dataController.text,
        'hora': _horaController.text,
        'local': _localController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Seus Dados'),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              CupertinoTextField(
                controller: _nomeController,
                placeholder: 'Nome completo (opcional)',
                prefix: const Icon(CupertinoIcons.person),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _signoController,
                placeholder: 'Signo zodiacal (ex: Peixes, Leão)',
                prefix: const Icon(CupertinoIcons.sun_max),
                clearButtonMode: OverlayVisibilityMode.editing,
                keyboardType: TextInputType.text,
                // CupertinoTextField doesn't have a validator property
                // Consider using CupertinoTextFormField or handling validation in the submit method
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _dataController,
                placeholder: 'Data de nascimento (dd/mm/aaaa)',
                prefix: const Icon(CupertinoIcons.calendar),
                keyboardType: TextInputType.datetime,
                // CupertinoTextField doesn't support validator property
                // Validation should be handled in _submit method instead
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _horaController,
                placeholder: 'Horário de nascimento (24h, ex: 14:35)',
                prefix: const Icon(CupertinoIcons.time),
                keyboardType: TextInputType.datetime,
                // CupertinoTextField doesn't have validator property
                // Validation should be handled in submit method
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: _localController,
                placeholder: 'Local de nascimento (Cidade - Estado - País)',
                prefix: const Icon(CupertinoIcons.location),
                // Validation should be handled in _submit method since CupertinoTextField doesn't support validator
              ),
              const SizedBox(height: 32),
              CupertinoButton.filled(
                child: const Text('Gerar Horóscopo'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}