import 'dart:io';
import 'package:chatbot_ai_document/features/study_assistant/data/datasources/pdf_extractor_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/generate_study_material_usecase.dart';
import 'study_event.dart';
import 'study_state.dart';

class StudyBloc extends Bloc<StudyEvent, StudyState> {
  final GenerateStudyMaterialUsecase generateStudyMaterialUseCase;
  final PdfExtractorDatasource pdfExtractorDatasource;

  StudyBloc({
    required this.generateStudyMaterialUseCase,
    required this.pdfExtractorDatasource,
  }) : super(StudyInitial()) {
    on<GenerateStudyMaterialEvent>((event, emit) async {
      emit(StudyLoading());

      try {
        File pdfFile = File(event.filePath);
        String extractedText = await pdfExtractorDatasource.extractTextFromPdf(
          pdfFile,
        );

        var result = await generateStudyMaterialUseCase.execute(extractedText);

        emit(StudyLoaded(result));
      } catch (e) {
        emit(StudyError(e.toString()));
      }
    });
  }
}
