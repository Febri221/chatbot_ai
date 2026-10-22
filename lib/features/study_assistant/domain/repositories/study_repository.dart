import '../entities/study_entity.dart';

abstract class StudyRepository {
  Future<StudyEntity> getSummaryAndQuiz(String pdfText);
}