import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  Stream? employeeStream;

  getAllEmployees() async {
    final employeeStreamData = await FirebaseCRUD().getEmployees();
    setState(() {
      employeeStream = employeeStreamData;
    });
  }

  @override
  void initState() {
    getAllEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Employee",
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "List",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            StreamBuilder(
                stream: employeeStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds = snapshot.data.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: EmployeeCard(
                                    empName: ds['Name'],
                                    empAge: ds['Age'],
                                    empPhone: ds['Telephone'],
                                    empRole: ds['Role'],
                                    empAddress: ds['Address'],
                                  ),
                                );
                              }),
                        )
                      : Container();
                })
          ],
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.empName,
    required this.empAge,
    required this.empPhone,
    required this.empRole,
    required this.empAddress,
  });
  final String? empName;
  final String? empAge;
  final String? empPhone;
  final String? empRole;
  final String? empAddress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.inversePrimary,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Name:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      empName!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Age:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      empAge!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "TelePhone:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      empPhone!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Role:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      empRole!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Address:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text(
                      empAddress!,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.teal),
              Icon(
                Icons.delete,
                color: Colors.teal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
