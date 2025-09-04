// import 'package:hive_flutter/hive_flutter.dart';
//
// class ImageUploadDataBase {
//   List imageUploadList = [];
//   // File imageFile = File("");
//   // Rx<File> projectImage = File("").obs;
//
//   // reference our box
//   final _myBox = Hive.box('mybox');
//
//   // run this method if this is the 1st time ever opening this app
//   void createInitialData() {
//     imageUploadList = [
//       // ["Make Tutorial", false],
//       // ["Do Exercise", false],
//       // [projectImage.value, false],
//     ];
//   }
//
//   // load the data from database
//   void loadData() {
//     imageUploadList = _myBox.get("TODOLIST");
//   }
//
//   // update the database
//   void updateDataBase() {
//     _myBox.put("TODOLIST", imageUploadList);
//   }
// }
