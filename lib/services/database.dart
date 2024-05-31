import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCRUD {
  Future addEmployee(Map<String, dynamic> employeeDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection('employees')
        .doc(id)
        .set(employeeDetails);
  }

  Future<Stream<QuerySnapshot>> getEmployees() async {
    return FirebaseFirestore.instance.collection('employees').snapshots();
  }

  Future updateEmployeeInfo (String id, Map<String, dynamic> updatedInfo) async{
     return await FirebaseFirestore.instance
        .collection('employees')
        .doc(id)
        .set(updatedInfo);
  }

}
