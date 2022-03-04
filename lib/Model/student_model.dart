class StudentFields{
  static const String studentId = 'Student ID';
  static const String studentName = 'Student Name';
  static const String studentMarks = 'Marks';
  //static List<String> getAllFields() => [studentId, studentName, studentMarks];
}


class StudentModel{
  final int? id;
  final String? name;
  final int? marks;

  const StudentModel({
    required this.id,
    required this.name,
    required this.marks
  });

  static StudentModel fromJson(Map<String, dynamic> json) => StudentModel(
      id: int.parse(json[StudentFields.studentId]),
      name: json[StudentFields.studentName],
      marks: int.parse(json[StudentFields.studentMarks])
  );

  Map<String, dynamic> toJson() => {
    StudentFields.studentId : id,
    StudentFields.studentName : name,
    StudentFields.studentMarks : marks
  };

}