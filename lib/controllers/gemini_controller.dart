import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiController {
  final String geminiApiUrl;
  final String geminiApiKey;

  GeminiController({required this.geminiApiUrl, required this.geminiApiKey});

  Future<String> gerarHoroscopo({
    required String signo,
    required String dataNascimento,
    required String horarioNascimento,
    required String localNascimento,
    String? nomeCompleto,
  }) async {
    final prompt = _montarPrompt(
      signo: signo,
      dataNascimento: dataNascimento,
      horarioNascimento: horarioNascimento,
      localNascimento: localNascimento,
      nomeCompleto: nomeCompleto,
    );

    final response = await http.post(
      Uri.parse(geminiApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $geminiApiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'max_tokens': 512,
        'temperature': 0.8,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['horoscopo'] ?? 'Não foi possível gerar o horóscopo.';
    } else {
      throw Exception('Erro ao chamar Gemini: ${response.body}');
    }
  }

  String _montarPrompt({
    required String signo,
    required String dataNascimento,
    required String horarioNascimento,
    required String localNascimento,
    String? nomeCompleto,
  }) {
    return '''
Gere um horóscopo personalizado do dia para o usuário com base nos seguintes dados:
- Nome completo: ${nomeCompleto ?? "(não informado)"}
- Signo: $signo
- Data de nascimento: $dataNascimento
- Horário de nascimento: $horarioNascimento
- Local de nascimento: $localNascimento

O horóscopo deve conter tópicos: Emoções, Amor, Trabalho, Energia do dia e um conselho final. Seja criativo, positivo e objetivo. Responda em português brasileiro.
''';
  }
}