import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Tạo class Student gồm name, email, phone (nullable)
class Student {
  final String name;
  final String? email;
  final String? phone;

  Student({required this.name, this.email, this.phone});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài tập về nhà',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Tạo list 5 sinh viên, trong đó có người thiếu email hoặc số điện thoại (null)
    final List<Student> students = [
      Student(name: 'Nguyễn Văn An', email: 'an@sv.edu.vn', phone: '0901 234 567'),
      Student(name: 'Trần Thị Bình', email: null, phone: '0912 888 999'),
      Student(name: 'Lê Minh Chí', email: 'chi@sv.edu.vn', phone: null),
      Student(name: 'Phạm Quốc Dũng', email: null, phone: null),
      Student(name: 'Võ Thanh Em', email: 'em@sv.edu.vn', phone: '0933 111 222'),
    ];

    // 5. Dùng vòng lặp for để đếm số sinh viên thiếu email
    int missingEmailCount = 0;
    for (var student in students) {
      if (student.email == null) {
        missingEmailCount++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sinh viên'),
        backgroundColor: const Color(0xFF1E3A8A), // Màu xanh đậm giống mẫu
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                // 3. Dùng vòng lặp for trong collection để tạo các thẻ sinh viên
                for (var student in students)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 4. Nếu trường bị null thì hiện chữ "Chưa cập nhật", dùng toán tử ??
                        Text(
                          'Email: ${student.email ?? 'Chưa cập nhật'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: student.email == null ? Colors.grey : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'SĐT: ${student.phone ?? 'Chưa cập nhật'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: student.phone == null ? Colors.grey : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Thanh footer hiển thị tổng số sinh viên và số lượng thiếu email
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng: ${students.length} sinh viên',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Thiếu email: $missingEmailCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}