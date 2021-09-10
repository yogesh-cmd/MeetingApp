import 'package:SakecMeeting/screens/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SakecMeeting/screens/profilescreen.dart';
import 'package:SakecMeeting/screens/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';


class Info{
  String type;
  String agenda;
  String date;
  String startTime;
  String endTime;
  String capacity;

  Info({
    this.date,
    this.agenda,
    this.capacity,
    this.endTime,
    this.startTime,
    this.type,
  });

}

class ScheduleMeeting extends StatefulWidget {
  final String username;
  final String email;
  final String photoUrl;
  final String screenTitle = "Schedule Meeting";

  ScheduleMeeting({Key key, @required this.username, @required this.photoUrl,@required this.email})
      : super(key: key);
  @override
  _ScheduleMeetingState createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
    final _formKey=GlobalKey<FormState>();
  List<DropdownMenuItem<String>> typ= [];
  String selected;
  String a;
  Info info = Info();
  DateTime _dateTime=DateTime.now();
  TextEditingController ted = TextEditingController();
  TextEditingController tim = TextEditingController();
  TextEditingController tiem = TextEditingController();
  TextEditingController cap = TextEditingController();
  void loaddata(){
    typ=[];
    typ.add(new DropdownMenuItem(child: Text("Meeting",style: TextStyle(fontFamily: "Times new roman",fontSize: 18.0)),value: "Meeting",));
    typ.add(new DropdownMenuItem(child: Text("Lecture",style: TextStyle(fontFamily: "Times new roman",fontSize: 18.0)),value: "Lecture",));
  }

  int _currentIndex = 0;
    //DateTime _dateTime =DateTime.now();

  final tabs = [
    Center(child: Text('Schedule')),
    Center(child: Text('Chat')),
    Center(child: Text('Calendar')),
    Center(child: Text('Teams')),
    Center(child: Text('Activity')),
  ];
  @override
  Widget build(BuildContext context) {
    loaddata();
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
                              email: widget.email
                            )),
                    (Route<dynamic> route) => false);
              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onTap: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                username: widget.username,
                                email: widget.email,
                                photoUrl: widget.photoUrl,
                              )),
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
                              email: widget.email
                            )),
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
      body:   
          Form(
          key: _formKey,
          child: Column(
            
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,left:20.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text("Type:  ",style: TextStyle(fontFamily: "Times new roman",fontSize: 20.0),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: DropdownButton(
                        value: selected,
                        items: typ,
                        hint: Text("Select Type",style: TextStyle(fontFamily: "Times new roman",fontSize: 25.0),),
                        onChanged: (String value){
                          selected=value;
                          info.type=value;
                          setState(() {
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  child:MyForm(
                    hintText: "Meeting Agenda",
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter Meeting Agenda";
                      }
                      return null;
                    },
                    onSaved:(String value){
                      info.agenda=value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  child:MyForm(
                    controller: ted,
                    hintText: "Pick a Date",
                    onTap: () async{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _dateTime = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                      var parsedate = DateTime.parse(_dateTime.toString());
                      String convertedDate = new DateFormat("dd/MM/yyyy").format(parsedate);
                      ted.text= convertedDate;
                    },
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter Date";
                      }
                      return null;
                    },
                    onSaved:(String value){
                      info.date=value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  child:MyForm(
                    controller: tim,
                    hintText: "Start Time",
                    onTap: () async{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      TimeOfDay picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      tim.text=picked.format(context);
                    },
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter start time";
                      }
                      return null;
                    },
                    onSaved:(String value){
                      info.startTime=value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  child:MyForm(
                    controller: tiem,
                    hintText: "End Time",
                    onTap: () async{
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
                      tiem.text=picked.format(context);
                    },
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter end time";
                      }
                      return null;
                    },
                    onSaved:(String value){
                      info.endTime=value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  child:MyForm(
                    controller: cap,
                    hintText: "Capacity",
                    keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.toString().isEmpty){
                        return "Enter Capacity";
                      }
                      return null;
                    },
                    onSaved:(String value){
                      info.capacity=value;
                    },
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.blueGrey,
                  child: Text("Schedule",style: TextStyle(color: Colors.white,),),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      a=info.type+"\n"+info.agenda+"\n"+info.date+"\n"+info.startTime+"\n"+info.endTime+"\n"+info.capacity;
                      showDialog(context: context,builder: (context){
                        return AlertDialog(
                          title: Text("Meeting Created Successfully"),
                          content: Text(a),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Done"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text("Share"),
                              onPressed: (){
                                Share.share(a);
                              },
                            ),
                          ],
                        );
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        
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
            case 0: Navigator.of(context).pushAndRemoveUntil(
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
            case 4:Navigator.of(context).pushAndRemoveUntil(
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
class MyForm extends StatelessWidget{
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onTap;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const MyForm({
    this.hintText,
    this.validator,
    this.onSaved,
    this.onTap,
    this.controller,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 0,style: BorderStyle.none),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }

}