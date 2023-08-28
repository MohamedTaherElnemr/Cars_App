part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

///////////////////Register States//////////////////////////////
final class RegisterLoading extends AppState {}

final class RegisterSuccess extends AppState {}

final class RegisterFailed extends AppState {}

/////////////////Login States //////////////////////////////////

final class LoginLoading extends AppState {}

final class LoginSuccess extends AppState {}

final class LoginFailed extends AppState {}
/////////////////////////// buttonnav bar////////////

final class ChangeButtonNavBar extends AppState {}
//////////////////////////////////// save user at firebase store ////////

final class SaveUserLoading extends AppState {}

final class SaveUserSuccess extends AppState {}

final class SaveUserFailed extends AppState {}

////////////////////////////////////////get user data from firebase ///////////////

final class GetUserDataLoading extends AppState {}

final class GetUserDataSuccess extends AppState {}

final class GetUserDataFailed extends AppState {}
//////////////////////////////// picking car image from gallery//////////

final class CarImagePickedLoading extends AppState {}

final class CarImagePickedSuccess extends AppState {}

final class CarImagePickedFailed extends AppState {}

final class RemoveCarImageSuccess extends AppState {}

//////////////////////////////////// uploading car image /////////////
final class CarImageuploadedLoading extends AppState {}

final class CarImageuploadedSuccess extends AppState {}

final class CarImageuploadedFailed extends AppState {}
//////////////////////////creating car offer in firebase///////////////

final class CreatingCarItemOfferLoading extends AppState {}

final class CreatingCarItemOfferSuccess extends AppState {}

final class CreatingCarItemOfferFailed extends AppState {}
//////////////////////////////// get Car offers from firebase states///////////

final class GetCarOffersLoading extends AppState {}

final class GetCarOffersSuccess extends AppState {}

final class GetCarOffersFailed extends AppState {}
///////////////////////////////////// upload car order////////////////////

final class CarImageOrderUploadedLoading extends AppState {}

final class CarImageOrderUploadedSuccess extends AppState {}

final class CarImageOrderUploadedFailed extends AppState {}

final class CreatingCarItemOrderLoading extends AppState {}

final class CreatingCarItemOrderSuccess extends AppState {}

final class CreatingCarItemOrderFailed extends AppState {}
///////////////////////////////////////////// get car orders from firebase ///////////+

final class GetCarOrdersLoading extends AppState {}

final class GetCarOrdersSuccess extends AppState {}

final class GetCarOrdersFailed extends AppState {}

final class CarImageOrderPickedSuccess extends AppState {}

final class CarImageOrderPickedFailed extends AppState {}
