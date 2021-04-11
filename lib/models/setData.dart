import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp_management/screens/complete_profile/complete_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:fyp_management/widgets/snack_bar.dart';

class SetData {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(DateTime.now());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future saveNewUser(email, context) async {
    final CollectionReference users = firestore.collection('Users');
    users
        .doc(email)
        .set({'Email': email, 'Uid': uid, 'Role': "Admin"})
        .then((value) => Navigator.pushReplacementNamed(
            context, CompleteProfileScreen.routeName))
        .catchError((e) {
          print(e);
        });
  }

  Future addStudent(context,
      {@required email,
      @required batch,
      @required department,
      @required regNo}) async {
    int step = 1;
    await firestore.collection('Users').doc(email).set({
      'Email': email,
      'Department': department,
      'Batch': batch,
      'Registeration No': regNo,
      'Role': "Student",
      'GroupID': "",
      'Current Step': step,
      'token': '',
    });
    return await firestore
        .collection('Students')
        .doc(department)
        .collection(batch)
        .doc(email)
        .set({
      'Email': email,
      'Department': department,
      'Batch': batch,
      'Registeration No': regNo,
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Student added successfully!");
    }).catchError((e) {
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }

  Future addTeacher(context,
      {@required email, @required department, @required name}) async {
    await firestore.collection('Users').doc(email).set({
      'Email': email,
      'Department': department,
      'Name': name,
      'Role': "Teacher"
    });

    return await firestore
        .collection('Teachers')
        .doc(department)
        .collection('Teachers')
        .doc(email)
        .set({
      'Email': email,
      'Department': department,
      'Name': name,
      'Role': "Teacher"
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Teacher added successfully!");
    }).catchError((e) {
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }

  Future addBatch(context, {@required department, @required batch}) async {
    return await firestore
        .collection('Batches')
        .doc(department)
        .collection('Batches')
        .doc(batch)
        .set({'Batch': batch}).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, 'Batch added susscessfully!');
    });
  }
}
