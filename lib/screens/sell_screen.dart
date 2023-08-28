import 'package:cars_app/business%20logic/app_cubit/app_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/car_item.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is GetCarOffersSuccess ||
                BlocProvider.of<AppCubit>(context).offers.length > 0,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => CarItem(
                    context, BlocProvider.of<AppCubit>(context).offers[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: BlocProvider.of<AppCubit>(context).offers.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
