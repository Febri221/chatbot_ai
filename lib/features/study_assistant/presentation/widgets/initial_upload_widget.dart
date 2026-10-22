import 'package:flutter/material.dart';

class InitialUploadWidget extends StatelessWidget {
  final VoidCallback onUploadTapped;

  const InitialUploadWidget({super.key, required this.onUploadTapped});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 80, color: Colors.indigo),
          const SizedBox(height: 16),
          const Text(
            'Upload catatan kuliahmu, biarkan AI merangkumnya!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: onUploadTapped,
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Materi Kuliah (PDF)'),
          ),
        ],
      ),
    );
  }
}