import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp_management/screens/complete_profile/complete_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:fyp_management/widgets/snack_bar.dart';

class SetData {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  static DateTime now = DateTime.now();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(now);

  Future saveNewUser(email, context) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
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
    await FirebaseFirestore.instance
        .collection('Role')
        .doc(email)
        .set({'Role': "Student"});
    return await FirebaseFirestore.instance
        .collection('Students')
        .doc(department)
        .collection(batch)
        .doc(email)
        .set({
      'Email': email,
      'Department': department,
      'Batch': batch,
      'Registeration No': regNo,
      'PhotoURL': "",
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Student added successfully!");
    }).catchError((e) {
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }
}
