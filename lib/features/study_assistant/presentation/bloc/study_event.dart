abstract class StudyEvent {}

class GenerateStudyMaterialEvent extends StudyEvent {
  final String filePath;
  GenerateStudyMaterialEvent(this.filePath);
}