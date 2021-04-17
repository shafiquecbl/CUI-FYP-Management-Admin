import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_management/components/custom_surfix_icon.dart';
import 'package:fyp_management/components/default_button.dart';
import 'package:fyp_management/components/form_error.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/size_config.dart';
import 'package:fyp_management/widgets/alert_dialog.dart';
import 'package:fyp_management/widgets/outline_input_border.dart';
import 'package:fyp_management/widgets/snack_bar.dart';
import 'package:fyp_management/models/setData.dart';
import 'package:firebase_core/firebase_core.dart';

class AddStudentsForm extends StatefulWidget {
  @override
  _AddStudentsFormState createState() => _AddStudentsFormState();
}

class _AddStudentsFormState extends State<AddStudentsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  FirebaseApp fbApp = Firebase.app('Secondary');

  String email;
  String password;

  String department;
  String batch;
  bool isVisible = false;

  static const menuItems = <String>[
    'CS',
    'SE',
  ];
  final List<DropdownMenuItem<String>> popUpMenuItem = menuItems
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  static List<String> batchList = [];

  List<DropdownMenuItem<String>> batchItem;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          getDepartmentFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          isVisible == true ? getBatch() : Container(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Add Student",
            press: () async {
              if (department == null) {
                addError(error: "Please select department");
              } else if (department != null) {
                removeError(error: "Please select department");
              }
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (batch == null) {
                  addError(error: "Please select batch");
                }
                if (batch != null) {
                  removeError(error: "Please select batch");
                  password = email.split('@').first;
                  removeError(error: kInvalidEmailError);
                  showLoadingDialog(context);
                  createUser(email, password, context);
                }
              }
            },
          ),
        ]));
  }

  //////////////////////////////////////////////////////////////////////////////

  DropdownButtonFormField getDepartmentFormField() {
    return DropdownButtonFormField(
      onSaved: (newValue) {
        department = newValue;
        getBatchs();
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Select department");
          batchList.clear();
          setState(() {
            isVisible = false;
          });
          department = value;
          getBatchs();
        } else {}
      },
      decoration: InputDecoration(
        labelText: "Department",
        hintText: "Select Department",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.local_fire_department_outlined),
        border: outlineBorder,
      ),
      items: popUpMenuItem,
    );
  }

  DropdownButtonFormField getBatch() {
    return DropdownButtonFormField(
      onSaved: (newValue) => batch = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Select Batch");
          batch = value;
        } else {}
      },
      decoration: InputDecoration(
        labelText: "Batch",
        hintText: "Select Batch",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.local_fire_department_outlined),
        border: outlineBorder,
      ),
      items: batchItem,
    );
  }

  //////////////////////////////////////////////////////////////////////////////

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue.toLowerCase(),
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          email = value.toLowerCase();
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Email",
        hintText: "Enter email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  Future createUser(email, password, context) async {
    setState(() {
      batchList.clear();
    });
    _formKey.currentState.reset();
    await FirebaseAuth.instanceFor(app: fbApp)
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      SetData().addStudent(context,
          email: email, batch: batch, department: department, regNo: password);
      FirebaseAuth.instanceFor(app: fbApp).signOut();
    }).catchError((e) {
      FirebaseAuth.instanceFor(app: fbApp).signOut();
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }

  getBatchs() {
    return FirebaseFirestore.instance
        .collection('Batches')
        .doc(department)
        .collection('Batches')
        .get()
        .then((value) {
      print(value.docs.map((e) {
        batchList.add(e['Batch']);
        if (batchList.isNotEmpty) {
          isVisible = true;
          setState(() {
            batchItem = batchList
                .map((String value1) => DropdownMenuItem<String>(
                      value: value1,
                      child: Text(value1),
                    ))
                .toList();
          });
        }
        if (batchList.isEmpty) {
          setState(() {
            isVisible = false;
            addError(error: 'No Batch Available in selected department');
          });
        }
      }));
    });
  }
}
