import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cars_app/models/car_item_model.dart';
import 'package:cars_app/models/car_orders_model.dart';
import 'package:cars_app/models/user_model.dart';
import 'package:cars_app/network/local/cache_helper.dart';
import 'package:cars_app/screens/orders_screen.dart';
import 'package:cars_app/screens/sell_screen.dart';
import 'package:cars_app/widgets/message_on_screeen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  UserModel? userModel;

  ////////////////// Register user ///////////////
  registerUser(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(RegisterLoading());

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CacheHelper.setData(key: 'uId', value: credential.user!.uid);
      userModel = UserModel(
          name: name,
          email: email,
          password: password,
          phone: phone,
          uId: credential.user!.uid);

      SaveUser(
          name: name,
          email: email,
          phone: phone,
          uId: credential.user!.uid,
          password: password);

      emit(RegisterSuccess());

      showMessage(
          message: 'you have been registred , please login',
          state: ToastState.SUCCESS);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showMessage(
            message: 'The password provided is too weak.',
            state: ToastState.WARNING);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showMessage(
            message: 'The account already exists for that email.',
            state: ToastState.WARNING);
      }
      emit(RegisterFailed());
    } catch (e) {
      print(e);
      showMessage(message: 'something went wrong', state: ToastState.ERROR);
      emit(RegisterFailed());
    }
  }

//////////////////////////////// Login User ////////////////////////////////
  loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      CacheHelper.setData(key: 'uId', value: credential.user!.uid);
      getUserData(uId: credential.user!.uid);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(LoginFailed());
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(LoginFailed());
      }
    }
  }

  ///////////////////////////// button nav bar ////////////////////

  int currentIndex = 0;
  List<Widget> screens = [
    SellScreen(),
    OrdersScreen(),
  ];

  List<String> titles = [
    ' Cars for Sale',
    'Orders',
  ];
  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeButtonNavBar());

    if (index == 0) {
      offers = [];
      getCarOffers();
    } else if (index == 1) {
      orders = [];
      getCarOrders();
    }
  }

////////////////////////////////////// save user at firebasestore //////////

  SaveUser(
      {required String name,
      required String email,
      required String phone,
      required String uId,
      required String password}) {
    emit(SaveUserLoading());
    UserModel usermodel = UserModel(
        name: name, email: email, phone: phone, uId: uId, password: password);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(usermodel.toMap())
        .then((value) {
      emit(SaveUserSuccess());
    }).catchError((error) {
      emit(SaveUserFailed());
    });
  }
////////////////////////////////////// get user data from firebase ///////////////////////

  void getUserData({required String uId}) {
    emit(GetUserDataLoading());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccess());
    }).catchError((error) {
      emit(GetUserDataFailed());
    });
  }

/////////////////////////////// Update user data in firebase //////////

  void updateUser(
      {required String name,
      required String phone,
      required String email,
      required String uId,
      required String password}) {
    UserModel usermodel = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: userModel!.uId,
      password: userModel!.password,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData(uId: userModel!.uId);
      showMessage(message: 'Profile updated', state: ToastState.SUCCESS);
    }).catchError((erorr) {
      showMessage(
          message: 'user info not updated , try again later',
          state: ToastState.ERROR);
    });
  }

///////////////////////////  upload car item /////////////////////////////////

///////////// first pick the car Image

  File? carImage;
  var picker = ImagePicker();
  Future<void> getCarImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      carImage = File(pickedFile.path);
      emit(CarImagePickedSuccess());
    } else {
      emit(CarImagePickedFailed());
      print(' no image selected');
    }
  }

  removeCarImage() {
    carImage == null;
    emit(RemoveCarImageSuccess());
  }

  ////////////// store caro ffer at data base and craete Car ofer at firebase
  void uploadCarImage({
    required String model,
    required String dateTime,
    required String price,
  }) {
    emit(CarImageuploadedLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('carOffers/${Uri.file(carImage!.path).pathSegments.last}')
        .putFile(carImage!)
        .then((value) {
      emit(CarImageuploadedSuccess());
      value.ref.getDownloadURL().then((value) {
        createCarItemOffer(
            model: model, dateTime: dateTime, carImage: value, price: price);
      }).catchError((error) {});
    }).catchError((error) {
      emit(CarImageuploadedFailed());
    });
  }

  void createCarItemOffer({
    required String model,
    required String dateTime,
    required String price,
    String? carImage,
  }) {
    emit(CreatingCarItemOfferLoading());

    CarItemModel carItemModel = CarItemModel(
        model: model,
        preice: price,
        name: userModel!.name,
        phone: userModel!.phone,
        uid: userModel!.uId,
        image: carImage!,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection('CarOffers')
        .add(carItemModel.toMap())
        .then((value) {
      emit(CreatingCarItemOfferSuccess());
      showMessage(message: 'Offer Uploaded', state: ToastState.SUCCESS);
    }).catchError((erorr) {
      emit(CreatingCarItemOfferFailed());
      showMessage(message: '$Error', state: ToastState.ERROR);
    });
  }

  ///////////////////////////// get car offers from firebase ////////

  List<CarItemModel> offers = [];
  getCarOffers() {
    emit(GetCarOffersLoading());

    FirebaseFirestore.instance
        .collection('CarOffers')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        offers.add(CarItemModel.fromJson(element.data()));
      });

      emit(GetCarOffersSuccess());
    }).catchError((error) {
      emit(GetCarOffersFailed());
      showMessage(message: error.toString(), state: ToastState.ERROR);
    });
  }

  //////////////////// make car orders in firebase /////////////
  ///

  File? carImageOrder;
  var picker2 = ImagePicker();
  Future<void> getCarImageOrder() async {
    final pickedFile = await picker2.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      carImageOrder = File(pickedFile.path);
      emit(CarImageOrderPickedSuccess());
    } else {
      emit(CarImageOrderPickedFailed());
      print(' no image selected');
    }
  }

  void uploadCarOrderImage({
    required String model,
    required String dateTime,
    required String details,
  }) {
    emit(CarImageOrderUploadedLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('carOrders/${Uri.file(carImageOrder!.path).pathSegments.last}')
        .putFile(carImageOrder!)
        .then((value) {
      emit(CarImageOrderUploadedSuccess());
      value.ref.getDownloadURL().then((value) {
        createCarOrderItem(
            model: model,
            dateTime: dateTime,
            carImage: value,
            details: details);
      }).catchError((error) {});
    }).catchError((error) {
      emit(CarImageOrderUploadedFailed());
    });
  }

  void createCarOrderItem({
    required String model,
    required String dateTime,
    required String details,
    String? carImage,
  }) {
    emit(CreatingCarItemOrderLoading());

    CarOrdersModel carOrdersModel = CarOrdersModel(
        model: model,
        name: userModel!.name,
        phone: userModel!.phone,
        uid: userModel!.uId,
        dateTime: dateTime,
        details: details,
        image: carImage!);
    FirebaseFirestore.instance
        .collection('carOrders')
        .add(carOrdersModel.toMap())
        .then((value) {
      emit(CreatingCarItemOrderSuccess());
      showMessage(message: 'Order Uploaded', state: ToastState.SUCCESS);
    }).catchError((erorr) {
      emit(CreatingCarItemOrderFailed());
      showMessage(message: '$Error', state: ToastState.ERROR);
    });
  }

  ///////////////////////// get orders form firebase //////////////////////////////////

  List<CarOrdersModel> orders = [];
  getCarOrders() {
    emit(GetCarOrdersLoading());

    FirebaseFirestore.instance
        .collection('carOrders')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        orders.add(CarOrdersModel.fromJson(element.data()));
      });

      emit(GetCarOrdersSuccess());
    }).catchError((error) {
      emit(GetCarOrdersFailed());
      showMessage(message: error.toString(), state: ToastState.ERROR);
    });
  }
}
