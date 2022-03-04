class ResultFields{
  static const String studentId = 'Student ID';
  static const String studentName = 'Student Name';
  static const String studentMarks = 'Marks';
  static const String studentStatus = 'Status';

  static List<String> getAllFields() => [studentId, studentName, studentMarks, studentStatus];
}


class ResultModel{
  final int? id;
  final String? name;
  final int? marks;
  final String? status;

  const ResultModel({
    required this.id,
    required this.name,
    required this.marks,
    required this.status
  });

  static ResultModel fromJson(Map<String, dynamic> json) => ResultModel(
      id: int.parse(json[ResultFields.studentId]),
      name: json[ResultFields.studentName],
      marks: int.parse(json[ResultFields.studentMarks]),
      status: json[ResultFields.studentStatus]
  );

  Map<String, dynamic> toJson() => {
    ResultFields.studentId : id,
    ResultFields.studentName : name,
    ResultFields.studentMarks : marks,
    ResultFields.studentStatus : status
  };

}