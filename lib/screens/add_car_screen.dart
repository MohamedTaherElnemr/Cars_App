// ignore_for_file: must_be_immutable

import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:cars_app/styles/color_manager.dart';
import 'package:cars_app/widgets/custome_text_form_field.dart';
import 'package:cars_app/widgets/message_on_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarScreen extends StatelessWidget {
  AddCarScreen({super.key});
  var modelController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: const Text(
              'Sell a Car',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      if (BlocProvider.of<AppCubit>(context).carImage == null ||
                          state is RemoveCarImageSuccess ||
                          state is CarImageuploadedSuccess)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          child: const Image(
                            image: AssetImage('assets/images/caritem.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (BlocProvider.of<AppCubit>(context).carImage != null &&
                          state is CarImagePickedSuccess)
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  BlocProvider.of<AppCubit>(context).carImage!,
                                )),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      if (BlocProvider.of<AppCubit>(context).carImage != null &&
                          state is CarImagePickedSuccess)
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                BlocProvider.of<AppCubit>(context)
                                    .removeCarImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: ColorManager.primaryColor,
                              )),
                        ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AppCubit>(context).getCarImage();
                            },
                            icon: const Icon(
                              Icons.image,
                              color: ColorManager.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  customeTextFormField(
                      controller: modelController,
                      type: TextInputType.text,
                      validate: (value) {
                        return 'model can not be empty';
                      },
                      hintText: 'The Car Model',
                      prefixIcon: Icons.car_crash_outlined),
                  const SizedBox(
                    height: 10,
                  ),
                  customeTextFormField(
                      controller: priceController,
                      type: TextInputType.text,
                      validate: (value) {
                        return 'Price';
                      },
                      hintText: 'The Car Price',
                      prefixIcon: Icons.attach_money),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.primaryColor,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        BlocProvider.of<AppCubit>(context).uploadCarImage(
                            model: modelController.text,
                            dateTime: DateTime.now().toString(),
                            price: priceController.text);

                        BlocProvider.of<AppCubit>(context).carImage = null;

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Offer The Car',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
