import 'package:admin/config/config.dart';
import 'package:admin/pages/home.dart';
import 'package:admin/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var passwordCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String password;
  String email;
  int role = 0;

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;

  handleSignUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Container(
            height: 638,
            width: 600,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 10,
                    offset: Offset(3, 3))
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  Config().appName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                Text(
                  'Welcome to Admin Panel',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your role:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  role == 1 ? role = 0 : role = 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: role != 1 ?
                                BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white, border: Border.all(width: 1, color: Colors.black),)
                                    :
                                BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.green),
                              ),
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            'Travel Agent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  role == 2 ? role = 0 : role = 2;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: role != 2 ?
                                BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white, border: Border.all(width: 1, color: Colors.black),)
                                    :
                                BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              ),
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            'Hotel manager',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  role == 3 ? role = 0 : role = 3;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: role != 3 ?
                                BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white, border: Border.all(width: 1, color: Colors.black),)
                                    :
                                BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              ),
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            'Admin',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            hintText: 'Enter email',
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            contentPadding: EdgeInsets.only(right: 0, left: 10),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey[300],
                                child: IconButton(
                                    icon: Icon(Icons.close, size: 15),
                                    onPressed: () {
                                      emailCtrl.clear();
                                    }),
                              ),
                            ),
                          ),
                          validator: (String value) {
                            if (value.length == 0)
                              return "Email can't be empty";
                            return null;
                          },
                          onChanged: (String value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Enter Password',
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              contentPadding:
                                  EdgeInsets.only(right: 0, left: 10),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(
                                      icon: Icon(Icons.close, size: 15),
                                      onPressed: () {
                                        passwordCtrl.clear();
                                      }),
                                ),
                              )),
                          validator: (String value) {
                            if (value.length == 0)
                              return "Password can't be empty";
                            return null;
                          },
                          onChanged: (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ]),
                  child: FlatButton.icon(
                    //padding: EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    icon: Icon(
                      LineIcons.arrow_right,
                      color: Colors.white,
                      size: 25,
                    ),
                    label: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    onPressed: () async {
                      String userRole;
                      switch(role){
                        case 1:
                          {
                            userRole = 'Travel agent';
                          }
                          break;
                        case 2:
                          {
                            userRole = 'Hotel manager';
                          }
                          break;
                        case 3:
                          {
                            userRole = 'admin';
                          }
                          break;
                      }
                      try {
                        final newUser = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          _database.collection('admin_panel_users').add({
                            'email': email,
                            'role': userRole,
                            'uid': _auth.currentUser.uid,
                          });
                          nextScreenReplace(context, HomePage());
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
