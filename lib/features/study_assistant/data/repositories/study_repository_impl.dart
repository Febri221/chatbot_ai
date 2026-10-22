import '../../domain/repositories/study_repository.dart';
import '../../domain/entities/study_entity.dart';
import '../datasources/gemini_datasource.dart';
import '../models/study_response_model.dart';
import 'dart:convert';

class StudyRepositoryImpl implements StudyRepository {
  final GeminiDatasource geminiDatasource;

  StudyRepositoryImpl(this.geminiDatasource);

  @override
  Future<StudyEntity> getSummaryAndQuiz(String pdfText) async {
    String rawJsonResponse = await geminiDatasource.generateSummaryAndQuiz(
      pdfText,
    );

    Map<String, dynamic> jsonMap = jsonDecode(rawJsonResponse);
    StudyResponseModel responseModel = StudyResponseModel.fromJson(jsonMap);

    return StudyEntity(
      rangkuman: responseModel.rangkuman,
      kuis: responseModel.kuis
          .map(
            (k) => KuisEntity(
              soal: k.soal,
              opsi: k.opsi,
              jawabanBenar: k.jawabanBenar,
            ),
          )
          .toList(),
    );
  }
}
