import 'package:flutter/material.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/Students/Add%20Students/add_students_form.dart';
import 'package:fyp_management/size_config.dart';
import 'package:fyp_management/widgets/customAppBar.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStudents extends StatefulWidget {
  @override
  _AddStudentsState createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar("Add Students"),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text("Enter Details",
                      style: GoogleFonts.teko(
                          color: kTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  AddStudentsForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
