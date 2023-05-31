//

abstract class AppStates {}

//// --------- MAIN APP --------
class AppInitialState extends AppStates {}

class AppChangeModeState extends AppStates {}

class ChangeSelectedAgeState extends AppStates {}

class AnswerSelectedState extends AppStates {}

class RemoveLastItemState extends AppStates {}

class AdhdResultDoneState extends AppStates {
  final String result;
  final String resultAr;
  AdhdResultDoneState(this.result, this.resultAr);
}

class AdhdResultLoadingState extends AppStates {}

class AnxietyLevelLoadingState extends AppStates {}

class AnxietyLevelSuccessfullyState extends AppStates {
  final message;
  final String messageAr;
  AnxietyLevelSuccessfullyState({this.message,required this.messageAr});
}

class AnxietyLevelFailState extends AppStates {
  final message;
  AnxietyLevelFailState({this.message});
}

// Login
class AppLoginSuccessState extends AppStates {
  final String uId;
  AppLoginSuccessState(this.uId);
}

class AppLoginLoadingState extends AppStates {}

class AppLangChangedState extends AppStates {}

class AppLoginErrorState extends AppStates {
  late final String error;
  AppLoginErrorState(this.error);
}

class SignInWithGoogleLoading extends AppStates {}

class SignInWithGoogleSuccessful extends AppStates {}

class SignInWithGoogleFailed extends AppStates {
  final String error;
  SignInWithGoogleFailed(this.error);
}

class SignInWithFBLoading extends AppStates {}

class SignInWithFBSuccessful extends AppStates {}

class SignInWithFBFailed extends AppStates {
  final String error;
  SignInWithFBFailed(this.error);
}

class ResetPasswordLoading extends AppStates {}

class ResetPasswordSuccessful extends AppStates {}

class ResetPasswordFailed extends AppStates {
  final String error;
  ResetPasswordFailed(this.error);
}

class SignInWithTwitterLoading extends AppStates {}

class SignInWithTwitterSuccessful extends AppStates {}

class SignInWithTwitterFailed extends AppStates {
  final String error;
  SignInWithTwitterFailed(this.error);
}

class SignoutLoading extends AppStates {}

class SignoutSuccessful extends AppStates {}

class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class ProfileImagePickedLoadingState extends AppStates {}

// Get User Data
class GetUserDataSuccessState extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataErrorState extends AppStates {
  late final String error;
  GetUserDataErrorState(this.error);
}

class UpdatetUserDataLoadingState extends AppStates {}

class UpdatetUserDataSuccessState extends AppStates {}

class UpdatetUserDataErrorState extends AppStates {
  late final String error;
  UpdatetUserDataErrorState(this.error);
}

class ChildAddedLoadingState extends AppStates {}

class ChildAddedSuccessState extends AppStates {}

class ChildAddedErrState extends AppStates {
  final String error;
  ChildAddedErrState(this.error);
}

class ChildUpdatedLoadingState extends AppStates {}

class ChildUpdatedSuccessState extends AppStates {}

class ChildUpdatedErrState extends AppStates {
  final String error;
  ChildUpdatedErrState(this.error);
}

class RemoveChildLoadingState extends AppStates {}

class RemoveChildSuccessState extends AppStates {}

class RemoveChildErrState extends AppStates {
  final String error;
  RemoveChildErrState(this.error);
}

class GetChildrenLoadingState extends AppStates {}

class GetChildrenSuccessState extends AppStates {}

class GetChildrenErrState extends AppStates {
  final String error;
  GetChildrenErrState(this.error);
}

// Register
class AppRegisterSuccessState extends AppStates {}

class AppRegisterLoadingState extends AppStates {}

class AppRegisterErrorState extends AppStates {
  late final String error;
  AppRegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends AppStates {}
