import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../bloc/study_bloc.dart';
import '../bloc/study_event.dart';
import '../bloc/study_state.dart';
import '../widgets/initial_upload_widget.dart';
import '../widgets/loading_state_widget.dart';
import '../widgets/summary_tab_widget.dart';
import '../widgets/quiz_tab_widget.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudiIn AI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StudyBloc, StudyState>(
        builder: (context, state) {
          // 1. Kondisi Awal (Belum Upload)
          if (state is StudyInitial) {
            return InitialUploadWidget(
              onUploadTapped: () async {
                final result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null && result.isNotEmpty) {
                  String filePath = result.first.path!;
                  if (context.mounted) {
                    BlocProvider.of<StudyBloc>(
                      context,
                    ).add(GenerateStudyMaterialEvent(filePath));
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pemilihan file dibatalkan'),
                      ),
                    );
                  }
                }
              },
            );
          }

          // 2. Kondisi Loading
          if (state is StudyLoading) {
            return const LoadingStateWidget();
          }

          // 3. Kondisi Sukses (Muncul Tab Rangkuman & Kuis)
          if (state is StudyLoaded) {
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.indigo,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.indigo,
                    tabs: [
                      Tab(text: 'Rangkuman', icon: Icon(Icons.summarize)),
                      Tab(text: 'Kuis Latihan', icon: Icon(Icons.quiz)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SummaryTabWidget(
                          rangkuman: state.studyEntity.rangkuman,
                        ),
                        QuizTabWidget(kuisList: state.studyEntity.kuis),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          // 4. Kondisi Error
          if (state is StudyError) {
            return Center(
              child: Text(
                'Oops, terjadi kesalahan:\n${state.message}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
