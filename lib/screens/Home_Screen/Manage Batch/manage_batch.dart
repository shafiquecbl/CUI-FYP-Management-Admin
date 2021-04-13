import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_management/constants.dart';
import 'package:fyp_management/screens/Home_Screen/Manage%20Batch/Add%20Batch/add_batch.dart';
import 'package:fyp_management/widgets/navigator.dart';
import 'package:fyp_management/widgets/snack_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageBatchs extends StatefulWidget {
  @override
  _ManageBatchsState createState() => _ManageBatchsState();
}

class _ManageBatchsState extends State<ManageBatchs> {
  int radioValue = 0;
  String department = 'SE';
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      if (radioValue == 0) {
        setState(() {
          department = "SE";
        });
      } else {
        setState(() {
          department = "CS";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Batchs'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => navigator(context, AddBatch()))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: hexColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: radioValue,
                  onChanged: handleRadioValueChanged,
                ),
                Text(
                  'SE',
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
                  'CS',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: batch()),
        ],
      ),
    );
  }

  Widget batch() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: StreamBuilder(
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
              child: Text('No Batch Available', style: stylee),
            );
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return list(snapshot.data.docs[index]);
              });
        },
      ),
    );
  }

  list(DocumentSnapshot snapshot) {
    return Card(
      elevation: 2,
      shadowColor: kPrimaryColor,
      child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
              ),
              constraints: BoxConstraints(
                minWidth: 50,
                minHeight: 50,
              ),
              child: Center(
                child: Text(
                  snapshot['Batch'],
                  style: GoogleFonts.teko(
                    color: kPrimaryColor,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          title: Text('Batch:  ${snapshot['Batch']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(department),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                confirmDelete(context, snapshot['Batch']);
              })),
    );
  }

  confirmDelete(BuildContext context, batch) {
    // set up the button
    Widget yes = CupertinoDialogAction(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context);
        FirebaseFirestore.instance
            .collection('Batches')
            .doc(department)
            .collection('Batches')
            .doc(batch)
            .delete();
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
      title: Text("Delete"),
      content: Text("Do you want to Delete $batch?"),
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
}
