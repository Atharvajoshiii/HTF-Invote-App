import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invote/Assets/appassets.dart';
import 'package:invote/auth/signin.dart';
import 'package:invote/color/color.dart';
import 'package:invote/screens/adddetail.dart';

class ShoeAppSignUpPage extends StatefulWidget {
  const ShoeAppSignUpPage({super.key});

  @override
  State<ShoeAppSignUpPage> createState() => _ShoeAppSignUpPageState();
}

class _ShoeAppSignUpPageState extends State<ShoeAppSignUpPage> {
  bool isRemember = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 56),
              const Center(
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))),
              const SizedBox(height: 5),
              const Text('Welcome back! Please enter your details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              const SizedBox(height: 68),

              const SizedBox(height: 16),
              AuthField(
                iconColor: AppColors.kLavender,
                controller: _mailController,
                keyboardType: TextInputType.emailAddress,
                icon: AppAssets.kMail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }

                  return null;
                },
                hintText: 'Email address',
              ),
              const SizedBox(height: 16),
              AuthField(
                iconColor: AppColors.kPeriwinkle,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                icon: AppAssets.kLock,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                hintText: 'Password',
              ),
              const SizedBox(height: 14),

              const SizedBox(height: 95),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _auth.createUserWithEmailAndPassword(
                          email: _mailController.text.toString(),
                          password: _passwordController.text.toString()
                      ).then((value) {
                        print("successfully done");
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AddUserVoterIdDetailsPage()));
                      }).onError((error, stackTrace) {
                        print(error.toString());
                      });
                    }
                  },
                  child:Text('Sign Up')),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text('Already have an account',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ShoeAppSignInPage()));
                  }, child: Text("SIGN IN"))

                ],
              ),
              const SizedBox(height: 56),

            ],
          ),
        ),
      ),
    );
  }
//
//   bool _isPasswordStrong(String password) {
//     if (password.length < 8) {
//       return false;
//     }
//     if (!password.contains(RegExp(r'[A-Z]'))) {
//       return false;
//     }
//     if (!password.contains(RegExp(r'[a-z]'))) {
//       return false;
//     }
//     if (!password.contains(RegExp(r'[0-9]'))) {
//       return false;
//     }
//     return true;
//   }
}


class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: color ?? AppColors.kPrimary, fontSize: fontSize ?? 14),
      ),
    );
  }
}



class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const AuthField(
      {super.key,
        required this.iconColor,
        required this.controller,
        required this.icon,
        required this.hintText,
        this.validator,
        this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColors.kLightWhite2,
          filled: true,

          hintStyle: const TextStyle(color: Colors.grey),
          errorMaxLines: 3,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: iconColor),
              child: SvgPicture.asset(icon),
            ),
          )),
    );
  }
}
