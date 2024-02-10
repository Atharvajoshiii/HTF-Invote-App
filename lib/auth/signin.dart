import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invote/Assets/appassets.dart';
import 'package:invote/auth/signup.dart';
import 'package:invote/color/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invote/screens/adddetail.dart';

class ShoeAppSignInPage extends StatefulWidget {
  const ShoeAppSignInPage({Key? key}) : super(key: key);

  @override
  State<ShoeAppSignInPage> createState() => _ShoeAppSignInPageState();
}

class _ShoeAppSignInPageState extends State<ShoeAppSignInPage> {
  bool isRemember = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.kLightWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 56),
              const Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Welcome back! Please enter your details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 68),
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
              RememberMeCheckbox(
                onRememberChanged: (value) {
                  setState(() {
                    isRemember = value;
                  });
                },
              ),
              const SizedBox(height: 125),
              CustomTextButton(
                onPressed: () {},
                text: 'Forgot Password',
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signInWithEmailAndPassword(
                      _mailController.text.trim(),
                      _passwordController.text,
                      context
                    );
                  }
                },
                child: Text("Sign In"),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Create account',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ShoeAppSignUpPage()),
                      );
                    },
                    child: Text("SIGN UP"),
                  ),
                ],
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.kPrimary,
          fontSize: fontSize ?? 14,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? btnColor;
  final Color? fontColor;
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.btnColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: btnColor ?? AppColors.kPrimary,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fontColor ?? AppColors.kLightWhite,
          fontSize: fontSize ?? 20,
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final Color? iconColor;
  const SocialButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 59,
        width: 59,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.kLightWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 32,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.25),
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}

class RememberMeCheckbox extends StatefulWidget {
  final void Function(bool) onRememberChanged;
  const RememberMeCheckbox({
    Key? key,
    required this.onRememberChanged,
  }) : super(key: key);

  @override
  State<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isRemember = !isRemember;
        });

        widget.onRememberChanged(isRemember);
      },
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: isRemember ? AppColors.kPrimary : null,
              borderRadius: BorderRadius.circular(6),
              border: !isRemember
                  ? Border.all(color: const Color(0xFFB6B6B8))
                  : null,
            ),
            child: isRemember
                ? Icon(Icons.done, size: 14, color: AppColors.kLightWhite)
                : null,
          ),
          const SizedBox(width: 10),
          const Text(
            'Remember',
            style: TextStyle(fontSize: 12, color: Colors.black),
          )
        ],
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
  const AuthField({
    Key? key,
    required this.iconColor,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: AppColors.kLightWhite2,
        filled: true,
        errorMaxLines: 3,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}

// Firebase authentication function
Future<void> signInWithEmailAndPassword(String email, String password,BuildContext context) async {
  try {
    // Sign in the user with email and password
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserVoterIdDetailsPage()));
    });
    // Sign in successful, navigate to the next screen or perform necessary actions
    print('User signed in successfully');
  } catch (e) {
    // Sign in failed, handle the error
    print('Failed to sign in: $e');
    // You can show error messages to the user if needed
  }
}
