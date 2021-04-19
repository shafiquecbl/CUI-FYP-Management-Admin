import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/griddashboard.dart';
import 'package:fyp_management/widgets/snack_bar.dart';
import 'package:fyp_management/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = FirebaseAuth.instance.currentUser;
  String token;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    getToken();
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * .3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/curve3.png'), fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 20, top: 20),
                        title: Text(
                          "Rana Zulkaif",
                          style: GoogleFonts.teko(
                              color: hexColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          "Admin",
                          style: GoogleFonts.teko(
                              color: Colors.yellowAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                          alignment: Alignment.topCenter,
                          icon: Icon(
                            Icons.logout,
                            color: hexColor,
                          ),
                          onPressed: () {
                            confirmSignout(context);
                          },
                        )),
                    Expanded(child: GridDashboard()),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  confirmSignout(BuildContext context) {
    // set up the button
    Widget yes = CupertinoDialogAction(
      child: Text("Yes"),
      onPressed: () {
        FirebaseAuth.instance.signOut().whenComplete(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }).catchError((e) {
          Snack_Bar.show(context, e.message);
        });
      },
    );

    Widget no = CupertinoDialogAction(
      child: Text("No"),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("Signout"),
      content: Text("Do you want to signout?"),
      actions: [yes, no],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getToken() async {
    token = await FirebaseMessaging().getToken();
    print("TOKENNNNNNNNNNN: $token");
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .update({'token': token});
  }
}
