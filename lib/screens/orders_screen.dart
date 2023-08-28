import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business logic/app_cubit/app_cubit.dart';
import '../models/user_model.dart';
import '../widgets/car_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel userModel = BlocProvider.of<AppCubit>(context).userModel!;
        return ConditionalBuilder(
          condition: state is GetCarOrdersSuccess ||
              BlocProvider.of<AppCubit>(context).orders.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => CarItemOrder(
                  context, BlocProvider.of<AppCubit>(context).orders[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: BlocProvider.of<AppCubit>(context).orders.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
