import 'package:flutter/material.dart';
import 'package:google_sheet_api/API/sheets.dart';
import 'package:google_sheet_api/Model/result_model.dart';
import 'package:google_sheet_api/Model/student_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<StudentModel> studentModel = [];
  List<ResultModel> resultModel = [];
  late List<Map<String, dynamic>> result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentData();
  }


  Future getStudentData() async{
    final students = await SheetAPI.getAll();
    setState(() {
      studentModel = students!;
    });
    createResultData(studentModel);
  }

  createResultData(List<StudentModel> studentModel){
    for(int i = 0; i < studentModel.length; i++){
      ResultModel model = ResultModel(
          id: studentModel[i].id,
          name: studentModel[i].name,
          marks: studentModel[i].marks,
          status: studentModel[i].marks! >= 40 ? "PASS" : "FAIL"
      );
      resultModel.add(model);
    }
    result = resultModel.map((e) => e.toJson()).toList();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: InkWell(
          onTap: () async{
            await SheetAPI.createWorkSheet();
            await SheetAPI.insertData(result);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Text(
              "TRIGGER",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20
              ),
            ),
          ),
        ),
      ),
    );
  }
}
