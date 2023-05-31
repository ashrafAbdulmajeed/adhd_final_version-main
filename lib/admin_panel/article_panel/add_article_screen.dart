import 'dart:io';

import 'package:adhd_app/admin_panel/article_panel/add_article_details_screen.dart';
import 'package:adhd_app/admin_panel/widgets/custom_button.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _articleIdController = TextEditingController();
  final _titleArController = TextEditingController();
  final _subtitleArController = TextEditingController();
  final _articleModelController = TextEditingController();

  File? _imageFile;
  bool _isUploadingImage = false;
  String _imageUrl = '';

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(String articleId) async {
    if (_imageFile == null) {
      return;
    }

    setState(() {
      _isUploadingImage = true;
    });

    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('articles/$articleId');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(_imageFile!, metadata);

    final downloadUrl = await ref.getDownloadURL();

    setState(() {
      _isUploadingImage = false;
      _imageUrl = downloadUrl;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image uploaded successfully')),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _articleIdController.dispose();
    _titleArController.dispose();
    _subtitleArController.dispose();
    _articleModelController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                // Image upload button
                CustomAdminButton(
                  title: 'Select Image',
                  onPressed: _selectImage,
                ),

                const SizedBox(height: 20),

                // Title field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _titleController,
                  label: "Title",
                  hintText: 'Main Title',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),
                const SizedBox(height: 10),
                // Subtitle field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _subtitleController,
                  label: "Subtitle",
                  hintText: 'Main Subtitle',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Subtitle';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),
                const SizedBox(height: 10),

                // Arabic Title field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _titleArController,
                  label: 'Title (Arabic)',
                  hintText: 'Main Title (Arabic)',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Arabic Subtitle field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _subtitleArController,
                  label: 'Subtitle (Arabic)',
                  hintText: 'Main Subtitle (Arabic)',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Subtitle';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 48),
                // Submit button
                StatefulBuilder(
                  builder: (context, state) {
                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : CustomAdminButton(
                            title: "Add",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                state(() {
                                  isLoading = true;
                                });
                                final collectionRef = FirebaseFirestore.instance
                                    .collection('MainArticle')
                                    .doc();
                                var newArticle = MainArticleModel(
                                  title: _titleController.text,
                                  subtitle: _subtitleController.text,
                                  articleId: collectionRef.id,
                                  titleAr: _titleArController.text,
                                  subtitleAr: _subtitleArController.text,
                                  imageUrl: _imageUrl,
                                );

                                await _uploadImage(newArticle.articleId!)
                                    .then((value) async {
                                  final newArticleWithImage =
                                      newArticle.copyWith(
                                    imageUrl: _imageUrl.toString(),
                                  );
                                  newArticle = newArticleWithImage;
                                  await collectionRef
                                      .set(newArticleWithImage.toJson())
                                      .then(
                                    (value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Article added successfully',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).whenComplete(
                                  () {
                                    // _formKey.
                                    // _formKey.currentContext.
                                    state(() {
                                      isLoading = false;
                                    });
                                    navigateTo(
                                        context,
                                        AddArticleDetailsScreen(
                                          mainArticleModel: newArticle,
                                        ));
                                  },
                                );
                                // Upload image if there is one
                              }
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
