// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'dart:async';
// import 'griddashboard.dart';

// GoogleSignIn _googleSignIn =
//     GoogleSignIn(scopes: ['profile', 'email'], hostedDomain: "sakec.ac.in");
// int firstLogin;

// //T0 Check is User is Logged in for first time
// //void checkFirstLogin()  async{
// //  final conn1 = await MySqlConnection.connect(ConnectionSettings(host: 'sql202.epizy.com', password: 'yxjSBaYQYbCq', port: 3306, user: 'epiz_26200649', db: 'epiz_26200649_sakecmeeting'));
// //  var check = await conn1.query('SELECT `email` FROM `sakec_meeting_app` WHERE Student_Email = ?', [_currentUser.email]);
// //  if(check == null) {
// //    firstLogin = 1;
// //  }else {
// //    firstLogin = 0;
// //  }
// //  print("Was Checking First Login");
// //}
// //
// //Future transferData(context) async {
// //  print("Was Doing Data Transfer");
// //  //Checking if user exists in the database
// //  final conn1 = await MySqlConnection.connect(ConnectionSettings(host: 'sql202.epizy.com', password: 'yxjSBaYQYbCq', port: 3306, user: 'epiz_26200649', db: 'epiz_26200649_sakecmeeting'));
// //  var check = await conn1.query('SELECT `email` FROM `sakec_meeting_app` WHERE Student_Email = ?', [_currentUser.email]);
// //  if(check == null) {
// //    firstLogin = 1;
// //  }else {
// //    firstLogin = 0;
// //  }
// //  print("Was Checking First Login");
// //
// //  //Comparing the result based on data existance
// //  if(firstLogin == 1)
// //  {
// //    //Variables to stored fetched data from college server
// //    var name, email, phone, mentor, sclass, branch;
// //
// //    //Database connection object
// //    final conn = await MySqlConnection.connect(ConnectionSettings(host: 'sql202.epizy.com', password: 'yxjSBaYQYbCq', port: 3306, user: 'epiz_26200649', db: 'epiz_26200649_sakecmeeting'));
// //
// ////Fetching data from college server
// //    var collegeDbData = await conn.query('SELECT `stud_name`, `email`, `phoneno`, `mentor`, `class`, `branch` FROM `ce_students_data` WHERE email = ?', [_currentUser.email]);
// //
// ////Checking if data exists for the corresponding email
// //    if (collegeDbData.length > 0)
// //    {
// //      //getting fetched data from college db feeded into variables
// //      for (var row in collegeDbData) {
// //        name=row[0];
// //        email=row[1];
// //        phone=row[2];
// //        mentor=row[3];
// //        sclass=row[4];
// //        branch=row[5];
// //      }
// //
// //      try{
// //        //Inserting the fetched data into Meeting App's Database
// //        var SakecMeetingDb = await conn.query('INSERT INTO `sakec_meeting_app`(`Student_Name`, '
// //            '`Student_Email`, `Student_Phone`, `Student_Mentor`, `Student_Class`, `Student_Branch`, `User_Role`, `isDataConnected`, `lastLogin`) VALUES (?,?,?,?,?,?,?,?,?)',
// //            [name, email, phone, mentor, sclass, branch,1,1,DateTime.now()]);
// //
// //        //Checking if there was any error transfering data
// //        if(SakecMeetingDb.insertId == null)
// //        {
// //          print("Error Transfering Data after login");
// //        }
// //      }catch(e){
// //        print(e);
// //      }
// //    }
// //    else
// //    {
// //      //Error Reporting
// //    }
// //    await conn.close();
// //  }
// //}

// void main() => runApp(MaterialApp(
//       title: 'SAKEC MEETING APP',
//       home: SignIn(),
//     ));

// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   GoogleSignInAccount currentUser;

//   _SignInState({this.currentUser});

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         currentUser = account;
//       });
//     });
//     _googleSignIn.signInSilently();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\t Sakec Meeting'),
//         backgroundColor: Colors.black,
//       ),
//       body: Center(child: _buildBody()),
//     );
//   }

//   Widget _buildBody() {
//     void alertDialog(BuildContext context) {
//       var alert = AlertDialog(
//         title: Text("Student Profile"),
//         content: Text("Name: " +
//             currentUser.displayName +
//             "\nClass: FutureScope\nNote to Developer: fetch from college db"),
//       );
//       showDialog(context: context, builder: (BuildContext context) => alert);
//     }

//     if (currentUser != null) {
//       SchedulerBinding.instance.addPostFrameCallback((_) {

//   // add your code here.

//   Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));});

//       // return Column(
//       //   mainAxisAlignment: MainAxisAlignment.start,
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   mainAxisSize: MainAxisSize.max,
//       //   children: <Widget>[

//       //     ListTile(
//       //       onTap:  () => alertDialog(context),
//       //       leading: GoogleUserCircleAvatar(
//       //         identity: _currentUser,
//       //       ),
//       //       title: Text(_currentUser.displayName ?? ''),
//       //       subtitle: Text(_currentUser.email ?? ''),
//       //       trailing: SizedBox.fromSize(
//       //         size: Size(50, 50), // button width and height
//       //           child: Material(
//       //             child: InkWell(
//       //               splashColor: Colors.blueGrey, // splash color
//       //               onTap: _handleSignOut, // button pressed
//       //               child: Column(
//       //                 mainAxisAlignment: MainAxisAlignment.center,
//       //                 children: <Widget>[
//       //                   Icon(Icons.exit_to_app), // icon
//       //                   Text("Sign Out", style: TextStyle(fontSize: 10)), // text
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //       )
//       //     ),
//       //     Divider(
//       //         color: Colors.black
//       //     )
//       //   ],

//       // );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Image.asset(
//             'assets/images/logo.png',
//             width: 250,
//             height: 250,
//           ),
//           Text(
//             '\nSAKEC MEETING APP\n',
//             style: TextStyle(fontSize: 25),
//           ),
//           SignInButton(
//             Buttons.Google,
//             text: "Sign In with SAKEC E-Mail",
//             onPressed: _handleSignIn,
//           )
//         ],
//       );
//     }
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn(); // .then(transferData);
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() async {
//     _googleSignIn.disconnect();
//   }
// }

import 'package:SakecMeeting/screens/homescreen.dart';
import 'package:SakecMeeting/screens/splashscreen.dart';
import 'package:SakecMeeting/screens/authscreen.dart';
import 'package:SakecMeeting/screens/profilescreen.dart';
import 'package:SakecMeeting/screens/schedulemeetingscreen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:flutter/material.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
  "/home": (BuildContext context) => HomeScreen(),
  "/profile": (BuildContext context) => ProfilePage(),
  "/schedulemeeting": (BuildContext context) => ScheduleMeeting(),
};

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31hfWN9Z2VoYmF8YGJ8ampqanNiYmlmamlmanMDHmggJioyIDs2ODsyPTc2EzQ+Mjo/fTA8Pg==');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sakec Meeting App',
    routes: routes,
    home: SplashScreen(),
  ));
}
