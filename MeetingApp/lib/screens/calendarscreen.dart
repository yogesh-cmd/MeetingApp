import 'package:SakecMeeting/screens/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SakecMeeting/screens/profilescreen.dart';
import 'package:SakecMeeting/screens/schedulemeetingscreen.dart';
import 'package:SakecMeeting/screens/jitsigenric.dart';
import 'package:SakecMeeting/main.dart';
import 'package:SakecMeeting/screens/homescreen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

//NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmggJioyIDs2ODsyPTc2EzQ+Mjo/fTA8Pg==

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class CalendarScreen extends StatefulWidget {
  final String username;
  final String email;
  final String photoUrl;
  final String screenTitle = "DASHBOARD";

  CalendarScreen(
      {Key key,
      @required this.username,
      @required this.photoUrl,
      @required this.email})
      : super(key: key);
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
    List<Meeting> meetings;
 List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
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
              SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          ));
        ])
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
