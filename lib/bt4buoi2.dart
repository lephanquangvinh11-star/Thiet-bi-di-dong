import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Tạo class Student gồm String name và double? score
class Student {
  final String name;
  final double? score;

  Student({required this.name, this.score});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bảng điểm lớp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GradeSummaryScreen(),
    );
  }
}

class GradeSummaryScreen extends StatelessWidget {
  const GradeSummaryScreen({super.key});

  // Hàm xếp loại học lực
  String _getGrade(double? score) {
    if (score == null) return 'Chưa có điểm';
    if (score < 0 || score > 10) return 'Không hợp lệ';
    if (score >= 8.0) return 'Giỏi';
    if (score >= 6.5) return 'Khá';
    if (score >= 5.0) return 'Trung bình';
    return 'Yếu';
  }

  // Sửa nhận tham số là String? để tránh lỗi null
  Color _getGradeColor(String? grade) {
    if (grade == 'Giỏi') return Colors.green.shade700;
    if (grade == 'Khá') return Colors.blue.shade700;
    if (grade == 'Trung bình') return Colors.orange.shade800;
    if (grade == 'Yếu') return Colors.red.shade700;
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final List<Student> students = [
      Student(name: 'Nguyễn Văn An', score: 9.0),
      Student(name: 'Trần Thị Bình', score: 7.2),
      Student(name: 'Lê Minh Chí', score: null),
      Student(name: 'Phạm Quốc Dũng', score: 4.5),
      Student(name: 'Võ Thanh Em', score: 5.8),
    ];

    double totalScore = 0;
    int countWithScore = 0;
    int excellentCount = 0;
    int missingScoreCount = 0;
    double? maxScore;

    for (var student in students) {
      if (student.score == null) {
        missingScoreCount++;
      } else {
        totalScore += student.score!;
        countWithScore++;

        if (student.score! >= 8.0) {
          excellentCount++;
        }

        if (maxScore == null || student.score! > maxScore!) {
          maxScore = student.score!;
        }
      }
    }

    double avgScore = countWithScore > 0 ? totalScore / countWithScore : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điểm lớp'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Điểm trung bình lớp',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    avgScore.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Giỏi', '$excellentCount'),
                      _buildStatItem('Chưa có điểm', '$missingScoreCount'),
                      _buildStatItem('Cao nhất', maxScore != null ? '$maxScore' : 'N/A'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'DANH SÁCH - ${students.length} SINH VIÊN',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            for (var student in students)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getGrade(student.score),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _getGradeColor(_getGrade(student.score)),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      student.score != null ? '${student.score}' : '—',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: student.score != null ? Colors.black87 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}