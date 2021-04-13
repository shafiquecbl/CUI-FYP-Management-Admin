import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

class Messages {
  User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(DateTime.now());

  Future addStudentMessage(receiverEmail, message) async {
    await FirebaseFirestore.instance
        .collection('Messages')
        .doc(email)
        .collection(receiverEmail)
        .add({
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    return await FirebaseFirestore.instance
        .collection('Messages')
        .doc(receiverEmail)
        .collection(email)
        .add({
      'Registeration No': user.email.split('@').first,
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future addStudentContact(receiverEmail, message) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverEmail)
        .collection('Contact US')
        .doc('shafiquecbl@gmail.com')
        .update({
      'Status': 'unread',
      'Last Message': message,
      'Time': dateTime,
    });

    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Student Contacts')
        .doc(receiverEmail)
        .update({'Last Message': message, 'Time': dateTime, 'Status': "read"});
  }

  Future addTeacherMessage({@required receiverEmail, @required message}) async {
    await FirebaseFirestore.instance
        .collection('Messages')
        .doc(email)
        .collection(receiverEmail)
        .add({
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    return await FirebaseFirestore.instance
        .collection('Messages')
        .doc(receiverEmail)
        .collection(email)
        .add({
      'Email': email,
      'Time': dateTime,
      'Message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future addTeacherContact(
      {@required receiverEmail,
      @required receiverName,
      @required message}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Teacher Contacts')
        .doc(receiverEmail)
        .update({'Last Message': message, 'Time': dateTime, 'Status': "read"});

    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverEmail)
        .collection('Contact US')
        .doc(email)
        .update({
      'Email': email,
      'Last Message': message,
      'Time': dateTime,
      'Status': "unread"
    });
  }
}
