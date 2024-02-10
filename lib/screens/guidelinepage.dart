import 'package:flutter/material.dart';
import 'package:invote/auth/signup.dart';
import 'package:invote/components/button.dart';
import 'package:invote/components/checkbox.dart';

class GuidelinePage extends StatelessWidget {
  const GuidelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Instructions For Voting Digitally",style: TextStyle(
                  fontSize: 23,
                  color: Colors.red,
                ),),
                SizedBox(height: 20,),
                Text(" 1) Please give your respectful vote as per Election Commison of India Guideline \n "
                    "2) Voter Id will be directly verified with goverment documents"
                    " \n 3)Vote can be given to only one candidate and after submission the selection cannot be changed \n"
                    " 4) Password or OTP will be only sent to regsitered mobile number . \n"
                    " 5) Please vote if your age is 18 years and above as per rules .",style: TextStyle(
                  fontSize: 18,
                ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    CustomGlowCheckBox(),
                    SizedBox(width: 20,),
                    Text("Have read all the guidlines and information",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
                SizedBox(height: 30,),
            MyButton( // Using the MyButton widget
              ontap: () {
                // Your onTap callback logic here
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoeAppSignUpPage()));
              },
              text: 'Proceed',), // Setting the button text



              ],
            ),
          ),
        ),
      ),
    );
  }
}
