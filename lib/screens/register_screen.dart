import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:cars_app/widgets/message_on_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custome_text_form_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showMessage(
              message: 'you have been registred ,login now',
              state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'REGIESTER',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Register Now To Join Our App',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          hintText: 'name',
                          prefixIcon: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      customeTextFormField(
                          isPass: false,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hintText: 'email',
                          prefixIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          isPass: false,
                          controller: phoneController,
                          type: TextInputType.phone,
                          hintText: 'phone',
                          prefixIcon: Icons.phone_android_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorManager.primaryColor,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AppCubit>(context).registerUser(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);

                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
