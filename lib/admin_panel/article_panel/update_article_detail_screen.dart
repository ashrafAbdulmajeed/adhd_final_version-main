import 'package:adhd_app/admin_panel/article_panel/articles_control.dart';
import 'package:adhd_app/admin_panel/widgets/custom_button.dart';
import 'package:adhd_app/models/article.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/widgets/default_form_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdateArticleDetailsScreen extends StatefulWidget {
  const UpdateArticleDetailsScreen({Key? key, required this.mainArticleModel})
      : super(key: key);
  final MainArticleModel mainArticleModel;
  @override
  _UpdateArticleDetailsScreenState createState() =>
      _UpdateArticleDetailsScreenState();
}

class _UpdateArticleDetailsScreenState
    extends State<UpdateArticleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _articleIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _titleArController = TextEditingController();
  final _authorController = TextEditingController();
  final _authorArController = TextEditingController();
  final _subTitleController = TextEditingController();
  final _subTitleArController = TextEditingController();
  final _referencesController = TextEditingController();
  final _referencesArController = TextEditingController();
  final _tipTitleController = TextEditingController();
  final _tipTitleControllerAr = TextEditingController();
  final _tipDescriptionController = TextEditingController();
  final _tipDescriptionControllerAr = TextEditingController();
  // final _tipsController = TextEditingController();

  List<TipModel> _tipsList = [];
  @override
  void initState() {
    _articleIdController.text = widget.mainArticleModel.articleId.toString();
    widget.mainArticleModel.title == null
        ? null
        : _titleArController.text = widget.mainArticleModel.title.toString();
    _titleController.text =
        widget.mainArticleModel.articleModel!.title.toString();
    _titleArController.text =
        widget.mainArticleModel.articleModel!.titleAr.toString();
    _authorArController.text =
        widget.mainArticleModel.articleModel!.authorAr.toString();
    _authorController.text =
        widget.mainArticleModel.articleModel!.author.toString();
    _referencesArController.text =
        widget.mainArticleModel.articleModel!.referencesAr.toString();
    _referencesController.text =
        widget.mainArticleModel.articleModel!.references.toString();
    _subTitleArController.text = widget.mainArticleModel.subtitleAr.toString();
    _subTitleController.text = widget.mainArticleModel.subtitle.toString();
    _tipsList = widget.mainArticleModel.articleModel!.tips ?? [];
    super.initState();
  }

  bool isLoading = false;
  @override
  void dispose() {
    _articleIdController.dispose();
    _titleController.dispose();
    _titleArController.dispose();
    _authorController.dispose();
    _authorArController.dispose();
    _subTitleController.dispose();
    _subTitleArController.dispose();
    _referencesController.dispose();
    _referencesArController.dispose();
    _tipDescriptionControllerAr.dispose();
    _tipDescriptionController.dispose();
    _tipTitleControllerAr.dispose();
    _tipTitleController.dispose();

    // _tipsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Article Details'),
        centerTitle: true,
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
                //Article Title
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _titleController,
                  label: 'Title',
                  hintText: 'Title',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Title';
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
                  hintText: 'Title (Arabic)',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Title (Arabic)';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Author field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _authorController,
                  label: 'Author  ',
                  hintText: 'Author ',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Author';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Arabic Author field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _authorArController,
                  label: 'Author(Arabic) ',
                  hintText: 'Author (Arabic)',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Author (Arabic)';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Subtitle field
                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _subTitleController,
                  label: 'Subtitle  ',
                  hintText: 'Subtitle ',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Subtitle (Arabic) ';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Arabic Subtitle field

                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _subTitleArController,
                  label: 'Subtitle (Arabic) ',
                  hintText: 'Subtitle (Arabic) ',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Subtitle (Arabic) ';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // References field

                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _referencesController,
                  label: 'References ',
                  hintText: 'References ',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a References ';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),

                const SizedBox(height: 10),
                // Arabic References field

                DefaultFormField(
                  prefix: FontAwesomeIcons.solidPenToSquare,
                  controller: _referencesArController,
                  label: 'References (Arabic)',
                  hintText: 'References (Arabic)',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a References (Arabic)';
                    }
                    return null;
                  },
                  borderColor: AppColors.mainColor,
                ),
                const SizedBox(height: 25),
                // Tips field

                CustomAdminButton(
                  title: "Update Tips ${_tipsList.length}",
                  onPressed: () {
                    // tipModel= TipModel();
                    AwesomeDialog(
                      dialogBackgroundColor: Colors.white,
                      btnCancelIcon: FontAwesomeIcons.drumSteelpan,
                      btnCancelOnPress: () {
                        _tipTitleController.clear();
                        _tipDescriptionController.clear();
                        _tipDescriptionControllerAr.clear();
                        _tipTitleControllerAr.clear();
                      },
                      btnCancelText: " Cancel",
                      // title: "Enter tips To the Article if you want",
                      dialogType: DialogType.noHeader,
                      btnCancelColor: Colors.red,
                      btnOkIcon: FontAwesomeIcons.expeditedssl,
                      btnOkColor: AppColors.mainColor,
                      // showCloseIcon: true,
                      btnOkText: "Save",
                      buttonsTextStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white, fontSize: 14),
                      btnOkOnPress: () {
                        setState(() {
                          _tipsList.add(
                            TipModel(
                              title: _tipTitleController.text,
                              description: _tipDescriptionController.text,
                              descriptionAr: _tipDescriptionControllerAr.text,
                              titleAr: _tipTitleControllerAr.text,
                            ),
                          );
                        });
                        _tipTitleController.clear();
                        _tipDescriptionController.clear();
                        _tipDescriptionControllerAr.clear();
                        _tipTitleControllerAr.clear();
                      },
                      context: context,
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //Tip title
                            DefaultFormField(
                              prefix: FontAwesomeIcons.solidPenToSquare,
                              controller: _tipTitleController,
                              label: "Tip Title",
                              hintText: 'Tip Title',
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Tip Title';
                                }
                                return null;
                              },
                              borderColor: AppColors.mainColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Tip Description
                            DefaultFormField(
                              prefix: FontAwesomeIcons.solidPenToSquare,
                              controller: _tipDescriptionController,
                              label: "Tip Description",
                              hintText: 'Tip Description',
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Tip Description';
                                }
                                return null;
                              },
                              borderColor: AppColors.mainColor,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            DefaultFormField(
                              prefix: FontAwesomeIcons.solidPenToSquare,
                              controller: _tipTitleControllerAr,
                              label: 'Tip Title (Arabic)',
                              hintText: 'Tip Title (Arabic)',
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Tip Title (Arabic)';
                                }
                                return null;
                              },
                              borderColor: AppColors.mainColor,
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            DefaultFormField(
                              prefix: FontAwesomeIcons.solidPenToSquare,
                              controller: _tipDescriptionControllerAr,
                              label: 'Tip Description (Arabic)',
                              hintText: 'Tip Description (Arabic)',
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Tip Description (Arabic)';
                                }
                                return null;
                              },
                              borderColor: AppColors.mainColor,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ).show();
                  },
                ),
                const SizedBox(height: 16),

                StatefulBuilder(
                  builder: (context, state) {
                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : CustomAdminButton(
                            title: 'Submit',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                final newArticle = widget
                                    .mainArticleModel.articleModel
                                    ?.copyWith(
                                  imageUrl: widget.mainArticleModel.imageUrl
                                      .toString(),
                                  articleId: _articleIdController.text.trim(),
                                  title: _titleController.text.trim(),
                                  titleAr: _titleArController.text.trim(),
                                  author: _authorController.text.trim(),
                                  authorAr: _authorArController.text.trim(),
                                  subTitle: _subTitleController.text.trim(),
                                  subTitleAr: _subTitleArController.text.trim(),
                                  references: _referencesController.text.trim(),
                                  referencesAr:
                                      _referencesArController.text.trim(),
                                  tips: _tipsList,
                                );

                                await FirebaseFirestore.instance
                                    .collection('MainArticle')
                                    .doc(widget.mainArticleModel.articleId)
                                    .update({
                                  "articleModel": newArticle!.toJson()
                                }).then((value) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Article Details Updated successfully',
                                      ),
                                    ),
                                  );
                                }).whenComplete(() {
                                  state(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ArticlesControl(),
                                  ));
                                }).catchError((e) =>
                                        print("Error =>>>>>>>${e.toString()}"));
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
