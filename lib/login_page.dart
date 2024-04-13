import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:management/Screens/home.dart';
import 'package:management/registrationpage.dart';
import 'package:management/widgets/bottomnavigationbar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  int _selectedIndex = 0;

  // static const List<Widget> _pages = <Widget>[
  //   Home(), // This is your home page
  //   Placeholder(), // Add your other pages here
  //   Placeholder(), // Add your other pages here
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isChecked = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  void _login() async {

    String enteredEmail = email.text;
    String enteredPassword = pass.text;

    _userBox = await Hive.openBox('users');

    if (_userBox.get("email") == enteredEmail && _userBox.get("password") == enteredPassword) {
      // Successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Bottom(),
        ),
      );
    } else {
      // Invalid credentials
      Fluttertoast.showToast(
          msg: "Invalid Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  Future<void> _initHive() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: const Color.fromARGB(255, 47, 125, 121),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    
                  ),
                  const HeightBox(10),
                  Text(
                    "Login",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  const HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white,width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white,width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Remember Me",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          isChecked = !isChecked;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password ? Reset Now",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  const HeightBox(10),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const HeightBox(30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User?",style: GoogleFonts.inter(fontWeight: FontWeight.w900,color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const registrationpage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    child: Text(
                      "Register Now",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const HeightBox(20),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
