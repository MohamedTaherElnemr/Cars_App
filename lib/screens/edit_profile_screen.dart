// ignore_for_file: must_be_immutable

import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custome_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

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
            title: const Text('Edit Your Information'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
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
                              BlocProvider.of<AppCubit>(context).updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  uId: BlocProvider.of<AppCubit>(context)
                                      .userModel!
                                      .uId,
                                  password: BlocProvider.of<AppCubit>(context)
                                      .userModel!
                                      .password);
                              Navigator.pop(context);
                            },
                            child: const Text('Update')),
                      ),
                    ],
                  ),
                ]),
          ),
        );
      },
    );
  }
}
