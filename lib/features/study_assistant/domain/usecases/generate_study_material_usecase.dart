import 'package:chatbot_ai_document/features/study_assistant/domain/entities/study_entity.dart';
import '../repositories/study_repository.dart';

class GenerateStudyMaterialUsecase {
  final StudyRepository repository;

  GenerateStudyMaterialUsecase(this.repository);

  Future<StudyEntity> execute(String pdfText) async {
    return await repository.getSummaryAndQuiz(pdfText);
  }
}