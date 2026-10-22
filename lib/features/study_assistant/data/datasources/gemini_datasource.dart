import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiDatasource {
  final _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<String> generateSummaryAndQuiz(String extractedText) async {
    final model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(
        "Kamu adalah Asisten Akademik AI. "
        "Tugasmu adalah membaca teks PDF materi kuliah, lalu membuatkan rangkuman poin-poin penting dan 3 soal pilihan ganda. "
        "OUTPUT HARUS BERFORMAT JSON MURNI tanpa teks lain di luar JSON dengan struktur persis seperti ini:\n"
        "{\n"
        "  \"rangkuman\": [\"Poin 1\", \"Poin 2\", \"Poin 3\"],\n"
        "  \"kuis\": [\n"
        "    {\n"
        "      \"soal\": \"Tulis pertanyaan kuis di sini?\",\n"
        "      \"opsi\": [\"A. Pilihan 1\", \"B. Pilihan 2\", \"C. Pilihan 3\", \"D. Pilihan 4\"],\n"
        "      \"jawaban_benar\": \"A. Pilihan 1\"\n"
        "    }\n"
        "  ]\n"
        "}",
      ),
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    final prompt =
        "Tolong rangkum materi berikut dan buatkan 3 soal kuis:\n\n $extractedText";

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    return response.text ?? "Gagal mendapatkan respons dari AI.";
  }
}
