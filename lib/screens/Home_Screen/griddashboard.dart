import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/Teachers/add_teachers.dart';
import 'Students/Add Students/add_students.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 40,
        mainAxisSpacing: 40,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
      children: [
        students(context),
        teachers(context),
      ],
    ));
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddStudents(),
              ),
            );
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
                style: TextStyle(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddTeachers(),
              ),
            );
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
                style: TextStyle(
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
}
