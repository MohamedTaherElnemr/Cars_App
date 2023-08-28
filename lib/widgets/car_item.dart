import 'package:cars_app/models/car_orders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/car_item_model.dart';
import '../styles/color_manager.dart';
import 'message_on_screeen.dart';

Widget CarItem(context, CarItemModel model) => Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image(
                      image: NetworkImage('${model.image}'),
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Model :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.model}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Price :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.preice}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Name :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Phone/WhatsApp :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.phone}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                const Divider(
                  indent: 5,
                  endIndent: 5,
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          TextButton(
                            onPressed: () async {
                              final Uri url =
                                  Uri(scheme: 'tel', path: '${model.phone}');

                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                showMessage(
                                    message: " can't call this number ",
                                    state: ToastState.WARNING);
                              }
                            },
                            child: const Text(
                              'Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );

Widget CarItemOrder(context, CarOrdersModel model) => Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image(
                      image: NetworkImage('${model.image}'),
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Model :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.model}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Details :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        '${model.details}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        maxLines: 5,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Name :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Phone/WhatsApp :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primaryColor,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.phone}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                    )
                  ],
                ),
                const Divider(
                  indent: 5,
                  endIndent: 5,
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          TextButton(
                            onPressed: () async {
                              final Uri url =
                                  Uri(scheme: 'tel', path: '${model.phone}');

                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                showMessage(
                                    message: " can't call this number ",
                                    state: ToastState.WARNING);
                              }
                            },
                            child: const Text(
                              'Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
