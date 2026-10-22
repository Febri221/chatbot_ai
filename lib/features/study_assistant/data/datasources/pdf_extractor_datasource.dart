import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfExtractorDatasource {
  Future<String> extractTextFromPdf(File pdfFile) async {
    final List<int> bytes = await pdfFile.readAsBytes();
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    
    // Mengekstrak seluruh teks dari PDF
    String extractedText = PdfTextExtractor(document).extractText();
    document.dispose();

    // =================================================================
    // ✂️ PEMANGKASAN OTOMATIS (MENGATASI ERROR 503 GEMINI API)
    // =================================================================
    // Jika teks lebih dari 3000 karakter, potong ambil bagian depannya saja.
    // Ukuran 3000 karakter sudah lebih dari cukup untuk dibaca AI 
    // sebagai sampel ringkasan & kuis (setara 1-2 halaman pertama materi).
    const int maxCharacters = 3000;
    
    if (extractedText.length > maxCharacters) {
      extractedText = extractedText.substring(0, maxCharacters);
    }
    
    return extractedText;
  }
}