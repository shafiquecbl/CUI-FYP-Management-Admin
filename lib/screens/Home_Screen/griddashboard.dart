import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/Add%20Batch/add_batch.dart';
import 'package:fyp_management/screens/Home_Screen/Teachers/add_teachers.dart';
import 'package:fyp_management/screens/Home_Screen/View%20Groups/view_groups.dart';
import 'package:fyp_management/widgets/navigator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Students/Add Students/add_students.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        staggeredTiles: [
          StaggeredTile.extent(2, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(2, 120),
        ],
        children: [
          addbatch(context),
          students(context),
          teachers(context),
          viewGroups(context),
        ],
      ),
    );
  }

  addbatch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onPressed: () {
            navigator(context, AddBatch());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_box,
                color: kPrimaryColor,
                size: 42,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "Add Batch",
                style: GoogleFonts.teko(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.6)),
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
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onPressed: () {
            navigator(context, AddStudents());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/student.svg",
                color: kPrimaryColor,
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
                    color: Colors.black.withOpacity(0.6)),
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
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onPressed: () {
            navigator(context, AddTeachers());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/teacher.svg",
                color: kPrimaryColor,
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
                    color: Colors.black.withOpacity(0.6)),
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
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 0),
          )
        ], color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: FlatButton(
          splashColor: kPrimaryColor.withOpacity(0.5),
          onPressed: () {
            navigator(context, ViewGroups());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.group,
                color: kPrimaryColor,
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
                    color: Colors.black.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
