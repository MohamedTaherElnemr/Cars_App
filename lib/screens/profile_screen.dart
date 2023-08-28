// ignore_for_file: must_be_immutable

import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/screens/edit_profile_screen.dart';
import 'package:cars_app/screens/login_screen.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:cars_app/widgets/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        nameController.text =
            BlocProvider.of<AppCubit>(context).userModel!.name;

        emailController.text =
            BlocProvider.of<AppCubit>(context).userModel!.email;

        phoneController.text =
            BlocProvider.of<AppCubit>(context).userModel!.phone;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.primaryColor,
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/images/person.jfif'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customeTextFormField(
                        isclick: false,
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (vale) {
                          return null;
                        },
                        hintText: nameController.text,
                        prefixIcon: Icons.person),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                        isclick: false,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (vale) {
                          return null;
                        },
                        hintText: emailController.text,
                        prefixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                        isclick: false,
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (vale) {
                          return null;
                        },
                        hintText: phoneController.text,
                        prefixIcon: Icons.phone_android_outlined),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditProfileScreen();
                                }));
                              },
                              child: const Text('Update Profile')),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginScreen();
                                }), (route) => false);
                              },
                              child: const Text('Logout')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
