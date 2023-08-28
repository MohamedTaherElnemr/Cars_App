import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/layouts/home_layout.dart';
import 'package:cars_app/screens/register_screen.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:cars_app/widgets/custome_text_form_field.dart';
import 'package:cars_app/widgets/message_on_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          showMessage(message: 'incorrect user data', state: ToastState.ERROR);
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomeLayout();
          }), (route) => false);
          showMessage(message: 'welcome', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: ColorManager.primaryColor,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/images/car2.jfif',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email can not be empty ';
                          }
                          return null;
                        },
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        isPass: true,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password can not be empty ';
                          }
                          return null;
                        },
                        hintText: 'Password',
                        prefixIcon: Icons.password_outlined,
                      ),
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<AppCubit>(context)
                                  .loginUser(
                                      email: emailController.text,
                                      password: passController.text);
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text('don\'t have an account ? '),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterScreen();
                                }));
                              },
                              child: const Text(
                                'Creat Account ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
