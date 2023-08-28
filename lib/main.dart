import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/layouts/home_layout.dart';
import 'package:cars_app/network/local/cache_helper.dart';
import 'package:cars_app/screens/login_screen.dart';
import 'package:cars_app/widgets/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget startWidget;

  if (uId != null) {
    startWidget = HomeLayout();
  } else {
    startWidget = LoginScreen();
  }

  runApp(CarsApp(
    startWidget: startWidget,
  ));
}

class CarsApp extends StatelessWidget {
  const CarsApp({super.key, required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getUserData(uId: uId ?? '6JuvmuIxt8UnyqGpHBymUoccygN2')
              ..getCarOffers()
              ..getCarOrders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
