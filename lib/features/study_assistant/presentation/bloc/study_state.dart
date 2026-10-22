import '../../domain/entities/study_entity.dart';

abstract class StudyState {}

class StudyInitial extends StudyState {}

class StudyLoading extends StudyState {}

class StudyLoaded extends StudyState {
  final StudyEntity studyEntity;
  StudyLoaded(this.studyEntity);
}

class StudyError extends StudyState {
  final String message;
  StudyError(this.message);
}