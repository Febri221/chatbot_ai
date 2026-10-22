import 'package:flutter/material.dart';
import '../../domain/entities/study_entity.dart'; // Sesuaikan path entity kamu

class QuizTabWidget extends StatefulWidget {
  final List<KuisEntity> kuisList;

  const QuizTabWidget({super.key, required this.kuisList});

  @override
  State<QuizTabWidget> createState() => _QuizTabWidgetState();
}

class _QuizTabWidgetState extends State<QuizTabWidget> {
  // Menyimpan jawaban user { index_soal : jawaban_dipilih }
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.kuisList.length,
      itemBuilder: (context, index) {
        final soalItem = widget.kuisList[index];
        final userDahJawab = selectedAnswers.containsKey(index);

        return Card(
          margin: const EdgeInsets.only(bottom: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soal ${index + 1}: ${soalItem.soal}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Looping pilihan ganda (Opsi)
                ...soalItem.opsi.map((opsi) {
                  final isDipilih = selectedAnswers[index] == opsi;
                  final isBenar = opsi == soalItem.jawabanBenar;

                  // Logika Warna: Kalau belum jawab -> Putih. Kalau udah jawab -> Hijau (Benar) / Merah (Salah)
                  Color bgColor = Colors.white;
                  if (userDahJawab) {
                    if (isBenar)
                      bgColor = Colors.green.shade100;
                    else if (isDipilih && !isBenar)
                      bgColor = Colors.red.shade100;
                  }

                  return InkWell(
                    onTap: userDahJawab
                        ? null
                        : () {
                            setState(() {
                              selectedAnswers[index] = opsi;
                            });
                          },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: bgColor,
                        border: Border.all(
                          color: isDipilih
                              ? Colors.indigo
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(opsi),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
