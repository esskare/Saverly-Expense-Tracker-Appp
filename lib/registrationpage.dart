import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:management/login_page.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Screens/home.dart';

class registrationpage extends StatefulWidget {
  const registrationpage({Key? key}) : super(key: key);

  @override
  _registrationpageState createState() => _registrationpageState();
}

class _registrationpageState extends State<registrationpage> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  late Box _userBox;

  void _registration() {
    String enteredEmail = email.text;
    String enteredPassword = pass.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
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
    } else {
      _userBox.put('email', enteredEmail);
      _userBox.put('password', enteredPassword);

      _userBox.close();

      // Successful account creation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login_Page(),
        ),
      );

    }
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();

    _userBox = await Hive.openBox('users');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initHive();
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
                    "Registration",
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
                  const HeightBox(10),
                  ElevatedButton(
                    onPressed: _registration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    child: Text(
                      "Create Account",
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
                        "Already have an account?",style: GoogleFonts.inter(fontWeight: FontWeight.w900,color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login_Page(),
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
                      "Login",
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
