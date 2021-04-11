import 'package:flutter/material.dart';
import 'package:fyp_management/components/default_button.dart';
import 'package:fyp_management/components/form_error.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/models/updateData.dart';
import 'package:fyp_management/size_config.dart';
import 'package:fyp_management/widgets/alert_dialog.dart';
import 'package:fyp_management/widgets/outline_input_border.dart';
import 'package:intl/intl.dart';

class AddDateForm extends StatefulWidget {
  @override
  _AddDateFormState createState() => _AddDateFormState();
}

class _AddDateFormState extends State<AddDateForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String dateTime = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int date;
  int radioValue = 0;
  String dateValue = 'proposal';
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      if (radioValue == 0) {
        setState(() {
          dateValue = "proposal";
        });
      } else if (radioValue == 1) {
        setState(() {
          dateValue = "srs";
        });
      } else if (radioValue == 2) {
        setState(() {
          dateValue = "sdd";
        });
      } else if (radioValue == 3) {
        setState(() {
          dateValue = "report";
        });
      }
    });
  }

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Select Option:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: 0,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
              Text(
                'Proposal',
                style: new TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Radio(
              value: 1,
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text(
              'SRS',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Radio(
              value: 2,
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text(
              'SDD',
              style: new TextStyle(fontSize: 16.0),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: 3,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
              Text(
                'Report',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(50)),
          getDateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Center(
            child: Text(
              '( ${dateValue.toUpperCase()} Date will be updated )',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Add Date",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                showLoadingDialog(context);
                UpdateData().addDate(context, option: dateValue, date: date);
              }
            },
          ),
        ]));
  }

  TextFormField getDateFormField() {
    return TextFormField(
      initialValue: dateTime,
      maxLength: 18,
      keyboardType: TextInputType.datetime,
      onSaved: (newValue) =>
          date = int.parse(newValue.replaceAll(new RegExp(r'[^\w\s]+'), '')),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter Date");
          date = int.parse(value.replaceAll(new RegExp(r'[^\w\s]+'), ''));
        } else {}
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please Enter Date");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Date",
        hintText: "DD-MM-YYYY",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
        border: outlineBorder,
      ),
    );
  }
}
