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

class AddTeachersForm extends StatefulWidget {
  @override
  _AddTeachersFormState createState() => _AddTeachersFormState();
}

class _AddTeachersFormState extends State<AddTeachersForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  FirebaseApp fbApp = Firebase.app('Secondary');

  String email;
  String password;
  String name;
  String department;

  static const menuItems = <String>[
    'CS',
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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Add Teacher",
            press: () async {
              if (department == null) {
                addError(error: "Please select department");
              } else if (department != null) {
                removeError(error: "Please select department");
              }
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                removeError(error: kInvalidEmailError);
                showLoadingDialog(context);
                createUser(email, password, context);
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
          removeError(error: "Please Select your department");
          department = value;
        } else {}
      },
      decoration: InputDecoration(
        labelText: "Department",
        hintText: "Select your Department",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.local_fire_department_outlined),
        border: outlineBorder,
      ),
      items: popUpMenuItem,
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
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        name = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future createUser(email, password, context) async {
    await FirebaseAuth.instanceFor(app: fbApp)
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      SetData().addTeacher(
        context,
        email: email,
        name: name,
        department: department,
      );
      FirebaseAuth.instanceFor(app: fbApp)
          .currentUser
          .updateProfile(displayName: name);
      FirebaseAuth.instanceFor(app: fbApp).signOut();
    }).catchError((e) {
      FirebaseAuth.instanceFor(app: fbApp).signOut();
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }
}
