import 'package:flutter/material.dart';

class SummaryTabWidget extends StatelessWidget {
  final List<String> rangkuman;

  const SummaryTabWidget({super.key, required this.rangkuman});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: rangkuman.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.indigo.withOpacity(0.2),
                  child: Text('${index + 1}', style: const TextStyle(fontSize: 12, color: Colors.indigo)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    rangkuman[index],
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}