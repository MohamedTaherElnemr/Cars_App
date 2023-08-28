import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/screens/add_car_screen.dart';
import 'package:cars_app/screens/profile_screen.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_order_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            centerTitle: true,
            title: Text(
              '${BlocProvider.of<AppCubit>(context).titles[BlocProvider.of<AppCubit>(context).currentIndex]}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfileScreen();
                    }));
                  },
                  icon: const Icon(Icons.person))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorManager.primaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
              currentIndex: BlocProvider.of<AppCubit>(context).currentIndex,
              onTap: (index) {
                BlocProvider.of<AppCubit>(context).changeNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.car_rental_outlined),
                    label: 'Cars for Sale'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.edit), label: 'Orders'),
              ]),
          floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.primaryColor,
              child: const Text('Add'),
              onPressed: () {
                if (BlocProvider.of<AppCubit>(context).currentIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddCarScreen();
                      },
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddOrderScreen();
                      },
                    ),
                  );
                }
              }),
          body: BlocProvider.of<AppCubit>(context)
              .screens[BlocProvider.of<AppCubit>(context).currentIndex],
        );
      },
    );
  }
}
