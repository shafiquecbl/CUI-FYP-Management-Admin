import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/View%20Groups/view_groups_list.dart';
import 'package:fyp_management/size_config.dart';
import 'package:fyp_management/widgets/customAppBar.dart';
import 'package:fyp_management/widgets/navigator.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewGroups extends StatefulWidget {
  @override
  _ViewGroupsState createState() => _ViewGroupsState();
}

class _ViewGroupsState extends State<ViewGroups> {
  int radioValue = 1;
  String department = 'SE';
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      if (radioValue == 0) {
        setState(() {
          department = "CS";
        });
      } else {
        setState(() {
          department = "SE";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: customAppBar("View Groups"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Department: "),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: radioValue,
                    onChanged: handleRadioValueChanged,
                  ),
                  Text(
                    'CS',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Radio(
                    value: 1,
                    groupValue: radioValue,
                    onChanged: handleRadioValueChanged,
                  ),
                  Text(
                    'SE',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Batch: "),
              ),
              Expanded(child: batch())
            ],
          ),
        ));
  }

  Widget batch() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Batches')
          .doc(department)
          .collection('Batches')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data.docs.length == 0)
          return Center(
            child: Text(
              'No Batch Available',
              style: GoogleFonts.teko(
                  color: kTextColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return list(snapshot.data.docs[index]);
            });
      },
    );
  }

  list(DocumentSnapshot snapshot) {
    return GestureDetector(
      onTap: () {
        navigator(context,
            ViewGroupsList(department: department, batch: snapshot['Batch']));
      },
      child: Card(
        child: ListTile(
          title: Text(
            "Batch: ${snapshot['Batch']}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(department),
        ),
      ),
    );
  }
}
