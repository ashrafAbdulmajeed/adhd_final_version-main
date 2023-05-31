import 'package:adhd_app/admin_panel/docotors_panel/add_doctor_screen.dart';
import 'package:adhd_app/admin_panel/docotors_panel/update_doctor_screen.dart';
import 'package:adhd_app/admin_panel/widgets/admin_functions.dart';
import 'package:adhd_app/injection_container.dart';
import 'package:adhd_app/localization/app_localizations.dart';
import 'package:adhd_app/models/doctor_model.dart';
import 'package:adhd_app/screens/home/home_screen.dart';
import 'package:adhd_app/screens/specialists/specialist_details_screen.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/components.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialistsScreen extends StatelessWidget {
  const SpecialistsScreen({Key? key, this.isAdmin}) : super(key: key);
  final bool? isAdmin;
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: isAdmin != null && isAdmin == true
          ? FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                navigateTo(
                  context,
                  const AddDoctorScreen(),
                );
              },
            )
          : null,
      appBar: AppBar(
        elevation: 0.4,
        centerTitle: true,
        actions: isAdmin != null && isAdmin == true
            ? null
            : [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey.shade700,
                    size: 30,
                  ),
                  onPressed: () {
                    navigateTo(context, const HomeScreen());
                  },
                ),
              ],
        title: Text(
          isAdmin != null && isAdmin == true
              ? "Manage Doctors"
              : "Specialists".tr(context),
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            top: 20,
            start: 10,
            end: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isAdmin != null && isAdmin == true
                    ? ""
                    : "Consult Specialists".tr(context),
                style: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(color: Colors.black87, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //TODO
              StreamBuilder<List<Doctor>>(
                  stream: getDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          return itemBuilder(
                            context,
                            doctor: snapshot.data![index],
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            height: 1,
                          );
                        }),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return const EmptyBoxWidget();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(context, {Doctor? doctor}) {
    print(doctor!.job);

    return GestureDetector(
      onTap: () {
        isAdmin != null && isAdmin == true
            ? AwesomeDialog(
                dialogBackgroundColor: Colors.white,
                btnCancelIcon: FontAwesomeIcons.drumSteelpan,
                btnCancelOnPress: () {
                  UsersOperations.deleteDoctor(
                      doctorId: doctor.id.toString(), context: context);
                },
                btnCancelText: " Delete",
                customHeader: CircleAvatar(
                  radius: 45,
                  onForegroundImageError: (exception, stackTrace) => const Icon(
                    Icons.person,
                    size: 40,
                  ),
                  foregroundImage:
                      doctor.image != null && !doctor.image!.contains("http")
                          ? AssetImage(
                              "assets/images/${doctor.image}.png",
                            )
                          : NetworkImage(doctor.image.toString())
                              as ImageProvider<Object>?,
                ),
                btnCancelColor: Colors.red,
                btnOkIcon: FontAwesomeIcons.expeditedssl,
                btnOkColor: AppColors.mainColor,
                btnOkText: " Update",
                buttonsTextStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontSize: 14),
                btnOkOnPress: () {
                  navigateTo(
                    context,
                    UpdateDoctorScreen(
                      doctor: doctor,
                    ),
                  );
                },
                context: context,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      infoCardBuilder(
                          title: "Address".tr(context),
                          subTitle: doctor.address,
                          icon: FontAwesomeIcons.addressCard),
                      const SizedBox(
                        height: 10,
                      ),
                      infoCardBuilder(
                          title: "Phone Number".tr(context),
                          subTitle: doctor.phone,
                          icon: FontAwesomeIcons.whatsapp,
                          iconSize: 20.0),
                      const SizedBox(
                        height: 10,
                      ),
                      infoCardBuilder(
                          title: "Email".tr(context),
                          subTitle: doctor.email,
                          icon: FontAwesomeIcons.envelope,
                          iconSize: 20.0),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ).show()
            : navigateTo(context, SpecialistDetailsScreen(doctor: doctor));
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(10),
        margin: const EdgeInsetsDirectional.only(top: 90),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                  start: 16, end: 10, top: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: Color.fromARGB(152, 192, 192, 192),
                      blurRadius: 7.0,
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.name!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              doctor.job!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -100,
              left: 0,

              ///TODO: if not contin http get asset
              child: doctor.image != null && !doctor.image!.contains("http")
                  ? Image.asset(
                      "assets/images/${doctor.image}.png",
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 40,
                      ),
                    )
                  : Image.network(
                      doctor.image.toString(),
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      height: 100,
                      width: 100,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Stream<List<Doctor>> getDoctors() {
  final result = sl<FirebaseFirestore>().collection('doctors').snapshots().map(
        (event) => event.docs
            .map(
              (e) => Doctor.fromMap(
                e.data(),
              ),
            )
            .toList(),
      );

  return result;
  // final result = sl<FirebaseFirestore>().collection('doctors').get().then(
  //       (value) => value.docs
  //           .map(
  //             (e) => Doctor.fromMap(
  //               e.data(),
  //             ),
  //           )
  //           .toList(),
  //     );
  // print(await result);
}
