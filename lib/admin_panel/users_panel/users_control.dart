import 'package:adhd_app/admin_panel/users_panel/add_user_screen.dart';

import 'package:adhd_app/admin_panel/users_panel/add_user_screen.dart';import 'package:adhd_app/admin_panel/widgets/admin_functions.dart';
import 'package:adhd_app/models/user_model.dart';
import 'package:adhd_app/utiles/colors.dart';
import 'package:adhd_app/utiles/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@override
class UsersControl extends StatefulWidget {
  const UsersControl({Key? key}) : super(key: key);

  @override
  State<UsersControl> createState() => _UsersControlState();
}

class _UsersControlState extends State<UsersControl> {
  final _firestore = FirebaseFirestore.instance;
  int adminPermission = 40;
  @override
  void initState() {
    getCurrentUserPermission(adminPermission).then((value) {
      setState(() {
        adminPermission = value;
      });
    });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddUserScreen(),
            ),
          );
        },
      ),
      drawer: const Drawer(
        child: Column(
          children: [],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Manage Users",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        elevation: 0.4,
        centerTitle: true,
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      UsersOperations.adminDialog(
                          context: context,
                          adminPermission: adminPermission,
                          userId: snapshot.data![i].id.toString(),
                          data: snapshot.data![i]);
                    },
                    style: ListTileStyle.drawer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                            color: Colors.black26, width: 1.5)),
                    leading: CircleAvatar(
                      foregroundImage: (!(snapshot.data![i].image
                                      .toString()
                                      .startsWith('assets')) &&
                                  snapshot.data![i].image != null
                              ? NetworkImage(snapshot.data![i].image.toString())
                              : const AssetImage("assets/images/avatar.jpg"))
                          as ImageProvider<Object>?,
                    ),
                    title: Text(
                      snapshot.data![i].username.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      snapshot.data![i].role ?? "Normal User",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: snapshot.data![i].role == "admin"
                                ? Colors.red
                                : Colors.black,
                          ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<int> getCurrentUserPermission(int permission) async {
    return await _firestore
        .collection('users')
        .doc(CacheHelper.getData(key: "userId"))
        .get()
        .then((value) {
      permission = value.data()!['permissions'] ?? 0;

      return permission;
    });
  }

  Stream<List<UserModel>> getAllUsers() {
    final userDataStream =
        _firestore.collection('users').snapshots().map((event) => event.docs
            .map((e) => UserModel.fromMap(
                  e.data(),
                ))
            .toList());

    return userDataStream;
  }
}
