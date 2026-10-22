class StudyResponseModel {
  final List<String> rangkuman;
  final List<KuisModel> kuis;

  StudyResponseModel({required this.kuis, required this.rangkuman});

  factory StudyResponseModel.fromJson(Map<String, dynamic> json) {
    return StudyResponseModel(
      rangkuman: List<String>.from(json['rangkuman'] ?? []),
      kuis: (json['kuis'] as List? ?? [])
          .map((item) => KuisModel.fromJson(item))
          .toList(),
    );
  }
}

class KuisModel {
  final String soal;
  final List<String> opsi;
  final String jawabanBenar;

  KuisModel({
    required this.soal,
    required this.opsi,
    required this.jawabanBenar,
  });

  factory KuisModel.fromJson(Map<String, dynamic> json) {
    return KuisModel(
     soal: json['soal'] ?? json['pertanyaan'] ?? json['question'] ?? 'Soal Kosong',
      opsi: List<String>.from(json['opsi'] ?? json['options'] ?? []),
     jawabanBenar: json['jawaban_benar'] ?? json['answer'] ?? '',
    );
  }
}
