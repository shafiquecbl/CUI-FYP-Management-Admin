import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fyp_management/screens/Home_Screen/home_screen.dart';
import 'package:fyp_management/widgets/snack_bar.dart';

class UpdateData {
  User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future saveUserProfile(context, name, gender, phNo) async {
    final CollectionReference users = firestore.collection('Users');
    users
        .doc(email)
        .update(
          {
            'Name': name,
            'Phone Number': phNo,
            'Gender': gender,
            'PhotoURL': "",
          },
        )
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false))
        .catchError((e) {
          Snack_Bar.show(context, e.message);
        });
  }

  addDate(context, {@required option, @required date}) async {
    return await firestore
        .collection('Dates')
        .doc('dates')
        .update({'${option.toLowerCase()}': date}).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(
          context, '${option.toUpperCase()} Date Updated Successfully');
    });
  }

  Future updateMessageStatus(receiverEmail) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Student Contacts')
        .doc(receiverEmail)
        .update({'Status': "read"});
  }

  Future updateTeacherMessageStatus(receiverEmail) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Teacher Contacts')
        .doc(receiverEmail)
        .update({'Status': "read"});
  }
}
