import 'dart:io';
import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invote/components/checkbox.dart';
import 'package:invote/components/datepickertextfeild.dart';
import 'package:invote/components/dropdown.dart';
import 'package:invote/components/gendercheckbox.dart';
import 'package:invote/components/normaltextfeild.dart';

class AddUserVoterIdDetailsPage extends StatefulWidget {
  const AddUserVoterIdDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddUserVoterIdDetailsPage> createState() =>
      _AddUserVoterIdDetailsPageState();
}

class _AddUserVoterIdDetailsPageState extends State<AddUserVoterIdDetailsPage> {
  final _datecontroller = TextEditingController();
  final _fullnamecontroller = TextEditingController();
  final _fathernamecontroller = TextEditingController();
  final _aadharcardcontroller = TextEditingController();
  final _voteridcontroller = TextEditingController();
  String? _selectedGender;
  XFile? _imageFile;

  void _handleGenderChange(String? gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future<void> _uploadDetails() async {
    try {
      // Get the UID of the current user
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        // Reference to the Firestore collection
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        // Add user details to Firestore
        await users.doc(uid).set({
          'fullName': _fullnamecontroller.text.toString(), // Replace with actual value
          'fatherName': _fathernamecontroller.text.toString(), // Replace with actual value
          'dob': _datecontroller.text.toString(), // Replace with actual value
          'gender': _selectedGender ?? 'Not Specified',
          'aadharCardNumber': _aadharcardcontroller.text.toString(), // Replace with actual value
          'voterID': _voteridcontroller.text.toString(), // Replace with actual value
          // 'imageUrl': _imageFile != null ? _imageFile!.path : '', // Include if needed
        });

        // Show success message or navigate to another page
        print('Details uploaded successfully!');
      }
    } catch (error) {
      // Handle errors here
      print('Error uploading details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Voter Card Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              LabelTextField(label: "Full Name",controller: _fullnamecontroller,),
              SizedBox(height: 15),
              LabelTextField(label: "Father's Name",controller: _fathernamecontroller,),
              SizedBox(height: 15),
              DatePickerTextField(controller: _datecontroller,),
              SizedBox(height: 15),
              Row(
                children: [
                  GenderCheckbox(
                    label: 'Male',
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: _handleGenderChange,
                  ),
                  GenderCheckbox(
                    label: 'Female',
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: _handleGenderChange,
                  ),
                  GenderCheckbox(
                    label: 'Others',
                    value: 'others',
                    groupValue: _selectedGender,
                    onChanged: _handleGenderChange,
                  ),
                ],
              ),
              SizedBox(height: 15),
              LabelTextField(label: "Aadhar Card Number",controller: _aadharcardcontroller,),
              SizedBox(height: 15),
              LabelTextField(label: "Voter ID",controller: _voteridcontroller,),
              SizedBox(height: 15),
              _imageFile == null
                  ? ElevatedButton(
                      onPressed: _getImage,
                      child: Text('Choose Image'),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(_imageFile!.path)),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadDetails,
                child: Text("Upload details"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
