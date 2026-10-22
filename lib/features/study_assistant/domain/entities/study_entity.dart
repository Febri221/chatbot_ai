// Entity utama untuk menampung hasil rangkuman dan kuis
class StudyEntity {
  final List<String> rangkuman;
  final List<KuisEntity> kuis;

  StudyEntity({
    required this.rangkuman,
    required this.kuis,
  });
}

// Sub-entity khusus untuk soal kuis
class KuisEntity {
  final String soal;
  final List<String> opsi;
  final String jawabanBenar;

  KuisEntity({
    required this.soal,
    required this.opsi,
    required this.jawabanBenar,
  });
}