import 'package:flutter/material.dart';
import 'package:fyp_management/components/default_button.dart';
import 'package:fyp_management/components/form_error.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/models/setData.dart';
import 'package:fyp_management/size_config.dart';
import 'package:fyp_management/widgets/alert_dialog.dart';
import 'package:fyp_management/widgets/outline_input_border.dart';

class AddBatchForm extends StatefulWidget {
  @override
  _AddBatchFormState createState() => _AddBatchFormState();
}

class _AddBatchFormState extends State<AddBatchForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String department;
  String batch;

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
          getBatchFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Add Batch",
            press: () async {
              if (department == null) {
                addError(error: "Please select department");
              } else if (department != null) {
                removeError(error: "Please select department");
              }
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (batch == "B") {
                  addError(error: "Please select batch");
                }
                if (batch != "B") {
                  removeError(error: "Please select batch");
                  removeError(error: kInvalidEmailError);
                  showLoadingDialog(context);
                  SetData()
                      .addBatch(context, department: department, batch: batch)
                      .then((value) {
                    _formKey.currentState.reset();
                  });
                }
              }
            },
          ),
        ]));
  }

  //////////////////////////////////////////////////////////////////////////////

  DropdownButtonFormField getDepartmentFormField() {
    return DropdownButtonFormField(
      onSaved: (newValue) => department = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Select department");
          department = value;
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

  //////////////////////////////////////////////////////////////////////////////

  TextFormField getBatchFormField() {
    return TextFormField(
      initialValue: 'B',
      maxLength: 3,
      onSaved: (newValue) => batch = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter Batch no.");
          batch = value;
        } else {}
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter Batch no.");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Batch No",
        hintText: "Enter Batch No",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.batch_prediction_outlined),
        border: outlineBorder,
      ),
    );
  }
}
