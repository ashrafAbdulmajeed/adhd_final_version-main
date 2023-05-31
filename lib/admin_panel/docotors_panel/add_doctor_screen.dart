import 'dart:io';

import 'package:adhd_app/admin_panel/widgets/custom_button.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/doctor_model.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({Key? key}) : super(key: key);

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  // ...
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _imageController = TextEditingController();

  File? _imageFile;
  bool _isUploadingImage = false;
  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(String doctorId) async {
    if (_imageFile == null) {
      return;
    }

    setState(() {
      _isUploadingImage = true;
    });

    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('doctors/$doctorId.jpg');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(_imageFile!, metadata);

    final downloadUrl = await ref.getDownloadURL();

    setState(() {
      _isUploadingImage = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image uploaded successfully')),
    );

    _imageFile = null;
    setState(() {
      _imageController.text = downloadUrl;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image preview
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                    )),
                    height: 150,
                    child: const Icon(
                      Icons.camera_alt_sharp,
                      size: 50,
                    ),
                  ),
                const SizedBox(height: 16),

                // Select Image button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                    ),
                    onPressed: _selectImage,
                    child: Text('Select Image',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                )),
                  ),
                ),
                const SizedBox(height: 16),

                // Name text field
                DefaultFormField(
                  controller: _nameController,
                  hintText: "Enter your Name",
                  label: "Name",
                  borderColor: AppColors.mainColor,
                  prefix: FontAwesomeIcons.info,
                  fillColor: Colors.white,
                  prefixColorIcon: AppColors.mainColor,
                  labelColor: Colors.grey[600],
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                // job
                const SizedBox(
                  height: 12.0,
                ),
                DefaultFormField(
                  controller: _jobController,
                  // type: TextInputType.text,
                  hintText: "Doctor in specific field",
                  label: "Job",
                  // label: "Address".tr(context),
                  borderColor: AppColors.mainColor,
                  prefix: FontAwesomeIcons.userDoctor,
                  fillColor: Colors.white,
                  prefixColorIcon: AppColors.mainColor,
                  labelColor: Colors.grey[600],
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Job';
                    }
                    return null;
                  },
                ),
                // address
                const SizedBox(
                  height: 12.0,
                ),

                DefaultFormField(
                  controller: _addressController,
                  // type: TextInputType.text,
                  hintText: "City-Street..",
                  label: "Address",
                  // label: "Address".tr(context),

                  borderColor: AppColors.mainColor,
                  prefix: FontAwesomeIcons.locationDot,
                  fillColor: Colors.white,
                  prefixColorIcon: AppColors.mainColor,
                  labelColor: Colors.grey[600],
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                // Phone text field
                const SizedBox(
                  height: 12.0,
                ),

                DefaultFormField(
                  controller: _phoneController,
                  type: TextInputType.text,
                  hintText: "05xxxxxxxx",
                  label: "Phone number".tr(context),
                  prefix: FontAwesomeIcons.phone,
                  borderColor: AppColors.mainColor,
                  fillColor: Colors.white,
                  labelColor: Colors.black54,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required'.tr(context);
                    }
                    // Regex pattern to validate phone number format and check for characters
                    String pattern = r'^[0-9]+$';
                    RegExp regExp = RegExp(pattern);
                    if (!regExp.hasMatch(value)) {
                      return 'please enter numbers only'.tr(context);
                    }
                    if (!value.startsWith("05")) {
                      return 'Please enter SA number'.tr(context);
                    }
                    if (value.length > 10) {
                      return 'please enter 10 numbers only'.tr(context);
                    }

                    if (value.length < 10) {
                      return 'please enter 10 numbers'.tr(context);
                    }

                    return null;
                  },
                ),
                // Email text field
                const SizedBox(
                  height: 12.0,
                ),

                DefaultFormField(
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                  hintText: "example@example.com",
                  label: "Email".tr(context),
                  borderColor: AppColors.mainColor,
                  prefix: FontAwesomeIcons.envelope,
                  fillColor: Colors.white,
                  prefixColorIcon: AppColors.mainColor,
                  labelColor: Colors.grey[600],
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Save button
                if (_isUploadingImage)
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                CustomAdminButton(
                  title: "Save",
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final doctorRef = FirebaseFirestore.instance
                          .collection('doctors')
                          .doc();
                      // doctor.id = doctorRef.id;
                      //
                      final doctor = Doctor(
                        id: doctorRef.id,
                        name: _nameController.text,
                        job: _jobController.text,
                        image: _imageController.text,
                        address: _addressController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                      );
                      await _uploadImage(doctorRef.id).then((value) async {
                        final doctorWithImage =
                            doctor.copyWith(image: _imageController.text);
                        await doctorRef
                            .set(doctorWithImage.toMap())
                            .then((value) => Navigator.pop(context));
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Image upload progress indicator

                // Manual image upload button
                // if (_imageFile != null)
                //   ElevatedButton(
                //     onPressed: () async {
                //       final doctorRef = FirebaseFirestore.instance
                //           .collection('doctors')
                //           .doc();
                //       await _uploadImage(doctorRef.id!);
                //     },
                //     child: const Text('Upload Image'),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
