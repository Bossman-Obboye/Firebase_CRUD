import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  Stream? employeeStream;

  getAllEmployees() async {
    employeeStream = await FirebaseCRUD().getEmployees();
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    getAllEmployees();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    roleController.dispose();
    addressController.dispose();
    super.dispose();
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
                                    onTap: () {
                                      editEmployeeData(ds.id);
                                      nameController.text = ds['Name'];
                                      ageController.text = ds['Age'];
                                      phoneController.text = ds['Telephone'];
                                      roleController.text = ds['Role'];
                                      addressController.text = ds['Address'];
                                    },
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

  editEmployeeData(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Employee",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  const Text(
                    "Age",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      isDense: true,
                      hintText: "32",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  const Text(
                    "Telephone",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      isDense: true,
                      hintText: "0244XXXXXXX",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  const Text(
                    "Role",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: roleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      isDense: true,
                      hintText: "Manager",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      isDense: true,
                      hintText: "Adisadel",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: ElevatedButton(
                      onPressed: () async {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> updateEmployee = {
                          "Name": nameController.text,
                          "Age": ageController.text,
                          "Telephone": phoneController.text,
                          "Role": roleController.text,
                          'Emp_ID': id,
                          "Address": addressController.text,
                        };
                        await FirebaseCRUD()
                            .updateEmployeeInfo(id, updateEmployee)
                            .then(
                          (value) {
                            Fluttertoast.showToast(
                                msg: "Employee data updated successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.teal,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        );

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
    required this.onTap,
  });
  final String? empName;
  final String? empAge;
  final String? empPhone;
  final String? empRole;
  final String? empAddress;
  final void Function()? onTap;

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
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: [
              InkWell(
                onTap: onTap,
                child: const Icon(
                  Icons.edit,
                  color: Colors.teal,
                ),
              ),
              const Icon(
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
