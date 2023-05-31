// // import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization/local/locale_cubit.dart';
import 'utiles/network/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => LocaleCubit(), instanceName: "LocaleCubit");

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
