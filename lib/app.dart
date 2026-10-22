import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/study_assistant/data/datasources/gemini_datasource.dart';
import 'features/study_assistant/data/datasources/pdf_extractor_datasource.dart';
import 'features/study_assistant/data/repositories/study_repository_impl.dart';
import 'features/study_assistant/domain/usecases/generate_study_material_usecase.dart';
import 'features/study_assistant/presentation/bloc/study_bloc.dart';
import 'features/study_assistant/presentation/screen/study_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // 1. Daftarkan DataSource paling bawah
        RepositoryProvider<GeminiDatasource>(
          create: (context) => GeminiDatasource(),
        ),
        RepositoryProvider<PdfExtractorDatasource >(
          create: (context) => PdfExtractorDatasource (),
        ),
        // 2. Daftarkan Repository Impl dengan menyuntikkan Datasource-nya
        RepositoryProvider<StudyRepositoryImpl>(
          create: (context) =>
              StudyRepositoryImpl(context.read<GeminiDatasource>()),
        ),
        // 3. Daftarkan UseCase dengan menyuntikkan Repository-nya
        RepositoryProvider<GenerateStudyMaterialUsecase>(
          create: (context) =>
              GenerateStudyMaterialUsecase(context.read<StudyRepositoryImpl>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // 4. Daftarkan Bloc utama aplikasi dan suntikkan UseCase & PdfExtractor-nya
          BlocProvider<StudyBloc>(
            create: (context) => StudyBloc(
              generateStudyMaterialUseCase: context
                  .read<GenerateStudyMaterialUsecase>(),
              pdfExtractorDatasource: context.read<PdfExtractorDatasource >(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'StudiIn: AI Study Assistant',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          // Halaman pertama aplikasi
          home: const StudyScreen(),
        ),
      ),
    );
  }
}
