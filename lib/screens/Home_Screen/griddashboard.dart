import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/Add%20Dates/add_dates.dart';
import 'package:fyp_management/screens/Home_Screen/Manage%20Batch/manage_batch.dart';
import 'package:fyp_management/screens/Home_Screen/Teachers/add_teachers.dart';
import 'package:fyp_management/screens/Home_Screen/View%20Groups/view_groups.dart';
import 'package:fyp_management/widgets/navigator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Inbox/Inboxx.dart';
import 'Students/Add Students/add_students.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      staggeredTiles: [
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
        StaggeredTile.extent(1, 130),
      ],
      children: [
        addbatch(context),
        inbox(context),
        addDates(context),
        viewGroups(context),
        teachers(context),
        students(context),
      ],
    );
  }

  addbatch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, ManageBatchs());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_box,
                color: kIconColor,
                size: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Manage Batch",
                style: GoogleFonts.teko(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  students(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, AddStudents());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/student.svg",
                color: kIconColor,
                width: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Add Students",
                style: GoogleFonts.teko(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  teachers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, AddTeachers());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/teacher.svg",
                color: kIconColor,
                width: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Add Teachers",
                style: GoogleFonts.teko(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  viewGroups(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, ViewGroups());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.group,
                color: kIconColor,
                size: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "View Groups",
                style: GoogleFonts.teko(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDates(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, AddDates());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: kIconColor,
                size: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Add Dates",
                style: GoogleFonts.teko(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  inbox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kIconColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => kIconColor),
          ),
          onPressed: () {
            navigator(context, Inboxx());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.inbox,
                color: kIconColor,
                size: 40,
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Inbox",
                    style: GoogleFonts.teko(
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser.email)
                        .collection('Student Contacts')
                        .where('Status', isEqualTo: 'unread')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.connectionState == ConnectionState.waiting)
                        return Container();
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser.email)
                            .collection('Teacher Contacts')
                            .where('Status', isEqualTo: 'unread')
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) return Container();
                          if (snapshot.data.docs.length +
                                  snap.data.docs.length !=
                              0)
                            return Container(
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 25,
                                minHeight: 12,
                              ),
                              child: new Text(
                                '${snapshot.data.docs.length + snap.data.docs.length}',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          return Container();
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
