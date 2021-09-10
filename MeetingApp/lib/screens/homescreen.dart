import 'package:SakecMeeting/screens/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SakecMeeting/screens/profilescreen.dart';
import 'package:SakecMeeting/screens/schedulemeetingscreen.dart';
import 'package:SakecMeeting/screens/jitsigenric.dart';

//T0 Check is User is Logged in for first time

Future transferData(context) async {
  var firstLogin = null;
  print("Was Doing Data Transfer");

  //Checking if user exists in the database
  print("Was Checking First Login");
}

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;
  final String photoUrl;
  final String screenTitle = "DASHBOARD";

  HomeScreen(
      {Key key,
      @required this.username,
      @required this.photoUrl,
      @required this.email})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    Center(child: Text('Schedule')),
    Center(child: Text('Chat')),
    Center(child: Text('Calendar')),
    Center(child: Text('Teams')),
    Center(child: Text('Activity')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(widget.screenTitle, textAlign: TextAlign.center)),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await googleSignIn.disconnect();
              await googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MyApp(
                      username: widget.username,
                      photoUrl: widget.photoUrl,
                      email: widget.email)),
              (Route<dynamic> route) => false);
        },
        label: Text('Join Meeting'),
        icon: Icon(Icons.call),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(widget.photoUrl ?? ''),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          widget.username,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    // Text(
                    //   widget.username,
                    //   style: TextStyle(fontSize: 18, color: Colors.white),
                    // )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            username: widget.username,
                            photoUrl: widget.photoUrl,
                            email: widget.email)),
                    (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Schedule Meeting',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            username: widget.username,
                            photoUrl: widget.photoUrl,
                            email: widget.email)),
                    (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(
                'Notification',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
      body: Center(
           child: ListView(
          children: const <Widget>[
            Card(
              child: ListTile(
                title: Center(
                    child: Text("Upcoming Activities", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
               // trailing: Icon(Icons.notifications_active),  
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('CSI ANNUAL MEETING'),
                subtitle: Text('To discuss activities throughout the year\n---------------------\nDate: 25-Jul-2020\t\t\tTime: 18:00'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('IEEE ANNUAL MEETING'),
                subtitle: Text('To discuss activities throughout the year\n---------------------\nDate: 26-Jul-2020\t\t\tTime: 18:00'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: FlutterLogo(size: 56.0),
                title: Text('E-CELL ANNUAL MEETING'),
                subtitle: Text('To discuss activities throughout the year\n---------------------\nDate: 27-Jul-2020\t\t\tTime: 18:00'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          
          ] 
        )
        
       
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Chat'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Teams'),
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Activity'),
            backgroundColor: Colors.black,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => ScheduleMeeting(
                          username: widget.username,
                          photoUrl: widget.photoUrl,
                          email: widget.email)),
                  (Route<dynamic> route) => false);
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          username: widget.username,
                          photoUrl: widget.photoUrl,
                          email: widget.email)),
                  (Route<dynamic> route) => false);
              break;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
