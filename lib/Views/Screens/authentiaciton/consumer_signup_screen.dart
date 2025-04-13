import 'package:farmz/Views/Screens/authentiaciton/consumer_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumerSignupScreen extends StatefulWidget {
  const ConsumerSignupScreen({super.key});

  @override
  State<ConsumerSignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<ConsumerSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final AuthController _authController = AuthController();

  late String email;
  late String username;
  late String password;
  bool isLoading = false;
  // SignupUser() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await _authController
  //       .signUpUsers(
  //           context: context,
  //           username: username,
  //           email: email,
  //           password: password)
  //       .whenComplete(() {
  //       // _formKey.currentState!.reset();
  //     setState(() {

  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(240),
      appBar: AppBar(
        title: Text('Signup'),
        backgroundColor: const Color.fromARGB(255, 242, 157, 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Signup Your Account",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: Colors.black87,
                        letterSpacing: 0.2,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "To Explore the world exclusives",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: Colors.black45,
                        letterSpacing: 0.2,
                        fontSize: 14,
                      ),
                    ),
                    Image.asset(
                      'assets/images/Illustration.png',
                      width: 250,
                      height: 250,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Full Name',
                        style: GoogleFonts.getFont('Nunito Sans',
                            fontWeight: FontWeight.w600, letterSpacing: 0.2),
                      ),
                    ),
                    // const SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (value) {
                        username = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your full name',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.person,
                          
                          )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.getFont('Nunito Sans',
                            fontWeight: FontWeight.w600, letterSpacing: 0.2),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your email',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.email)
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Village';
                        }  else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText: 'enter your village',
                          labelStyle: GoogleFonts.getFont(
                            'Nunito Sans',
                            fontSize: 14,
                            letterSpacing: 0.1,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on)
                          ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText: 'enter your password',
                          labelStyle: GoogleFonts.getFont(
                            'Nunito Sans',
                            fontSize: 14,
                            letterSpacing: 0.1,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.lock)
                          ),
                          suffixIcon: Icon(Icons.visibility)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // SignupUser();
                          print("Correct");
                        } else {
                          // print("incorrect");
                        }
                      },
                      child: Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              const Color.fromARGB(255, 229, 182, 111)
                            ],
                          ),
                          // color: Colors.blue,
                        ),
                        child: Center(
                            child: Stack(
                          children: [
                            Positioned(
                                left: 278,
                                top: 19,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 12,
                                            color: Colors.orange),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                )),
                            Positioned(
                              left: 260,
                              top: 29,
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                    ),
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 311,
                                top: 36,
                                child: Opacity(
                                  opacity: 0.3,
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                )),
                            Positioned(
                                left: 281,
                                top: -10,
                                child: Opacity(
                                  opacity: 0.3,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )),
                            Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Sign Up',
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: Colors.white,
                                          letterSpacing: 0.2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account? ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConsumerLoginScreen()));
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
