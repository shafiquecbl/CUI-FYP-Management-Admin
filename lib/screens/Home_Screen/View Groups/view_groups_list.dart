import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/widgets/customAppBar.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewGroupsList extends StatefulWidget {
  final String department;
  final String batch;
  ViewGroupsList({@required this.department, @required this.batch});
  @override
  _ViewGroupsListState createState() => _ViewGroupsListState();
}

class _ViewGroupsListState extends State<ViewGroupsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('${widget.department} - ${widget.batch}'),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Groups')
              .doc(widget.department)
              .collection(widget.batch)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.data.docs.length == 0)
              return Center(
                child: Text(
                  'No Groups Available',
                  style: GoogleFonts.teko(
                      color: kTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              );
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return list(snapshot.data.docs[index]);
                });
          },
        ),
      ),
    );
  }

  Widget list(DocumentSnapshot snapshot) {
    return Card(
      elevation: 2,
      shadowColor: kPrimaryColor,
      child: ExpansionTile(
        title: Text(
          "GroupID:   ${snapshot['GroupID']}",
          style: GoogleFonts.teko(
              color: kPrimaryColor, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        children: [
          Text(
              "Member 1:   ${snapshot['Member 1'].split('@').first.toUpperCase()}",
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold)),
          Text(
              "Member 2:   ${snapshot['Member 2'].split('@').first.toUpperCase()}",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
          Text(
              "Member 3:   ${snapshot['Member 3'].split('@').first.toUpperCase()}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
