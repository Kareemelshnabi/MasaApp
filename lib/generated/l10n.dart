// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select user type`
  String get titleOftypePage {
    return Intl.message(
      'Select user type',
      name: 'titleOftypePage',
      desc: '',
      args: [],
    );
  }

  /// `Please select the user type that best describes your role to best assist you.`
  String get bodyOftypePage {
    return Intl.message(
      'Please select the user type that best describes your role to best assist you.',
      name: 'bodyOftypePage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get bottomOfTypePage {
    return Intl.message(
      'Confirm',
      name: 'bottomOfTypePage',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get visit {
    return Intl.message(
      'Visitor',
      name: 'visit',
      desc: '',
      args: [],
    );
  }

  /// `Seller`
  String get seller {
    return Intl.message(
      'Seller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signup {
    return Intl.message(
      'SignUp',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get facebook {
    return Intl.message(
      'Login with Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with iCloud`
  String get icloud {
    return Intl.message(
      'Login with iCloud',
      name: 'icloud',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get google {
    return Intl.message(
      'Sign in with Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Not Activated Yet ..!`
  String get NotActivated {
    return Intl.message(
      'Not Activated Yet ..!',
      name: 'NotActivated',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get titleLoginPage {
    return Intl.message(
      'Login',
      name: 'titleLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back. Please enter your phone number and password to log in.`
  String get bodyLoginPage {
    return Intl.message(
      'Welcome back. Please enter your phone number and password to log in.',
      name: 'bodyLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgetPass {
    return Intl.message(
      'Forgot your password?',
      name: 'forgetPass',
      desc: '',
      args: [],
    );
  }

  /// ` ? Don't have an account`
  String get notHaveAccount {
    return Intl.message(
      ' ? Don\'t have an account',
      name: 'notHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get errorPhone_1 {
    return Intl.message(
      'Please enter your phone number',
      name: 'errorPhone_1',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get errorPhone_2 {
    return Intl.message(
      'Invalid phone number',
      name: 'errorPhone_2',
      desc: '',
      args: [],
    );
  }

  /// `Please start with [5,6,9,2]965+`
  String get errorPhone_3 {
    return Intl.message(
      'Please start with [5,6,9,2]965+',
      name: 'errorPhone_3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get errorPass_1 {
    return Intl.message(
      'Please enter your password',
      name: 'errorPass_1',
      desc: '',
      args: [],
    );
  }

  /// `Password is short`
  String get errorPass_2 {
    return Intl.message(
      'Password is short',
      name: 'errorPass_2',
      desc: '',
      args: [],
    );
  }

  /// `password is long`
  String get errorPass_3 {
    return Intl.message(
      'password is long',
      name: 'errorPass_3',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your connection and try again.`
  String get noInternetApi {
    return Intl.message(
      'No internet connection. Please check your connection and try again.',
      name: 'noInternetApi',
      desc: '',
      args: [],
    );
  }

  /// `The requested resource was not found.`
  String get serverException {
    return Intl.message(
      'The requested resource was not found.',
      name: 'serverException',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unExcepectedException {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unExcepectedException',
      desc: '',
      args: [],
    );
  }

  /// `Failed to complete the operation. Please try again.`
  String get defultException {
    return Intl.message(
      'Failed to complete the operation. Please try again.',
      name: 'defultException',
      desc: '',
      args: [],
    );
  }

  /// `The server is currently unavailable. Please try again later.`
  String get serverError {
    return Intl.message(
      'The server is currently unavailable. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `The request has timed out. Please try again later.`
  String get timeOutException {
    return Intl.message(
      'The request has timed out. Please try again later.',
      name: 'timeOutException',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect phone number or password`
  String get passwordNotCorrect {
    return Intl.message(
      'Incorrect phone number or password',
      name: 'passwordNotCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `try again`
  String get tryAgain {
    return Intl.message(
      'try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get titleSign {
    return Intl.message(
      'Create your account',
      name: 'titleSign',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your information. Don't worry, your information will remain private and only you will be able to see it.`
  String get bodySign {
    return Intl.message(
      'Please complete your information. Don\'t worry, your information will remain private and only you will be able to see it.',
      name: 'bodySign',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get userName {
    return Intl.message(
      'user name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `e-mail`
  String get email {
    return Intl.message(
      'e-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `address`
  String get address {
    return Intl.message(
      'address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPass {
    return Intl.message(
      'Confirm password',
      name: 'confirmPass',
      desc: '',
      args: [],
    );
  }

  /// `If you have an account already ? `
  String get haveAccount {
    return Intl.message(
      'If you have an account already ? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `By clicking here you agree to`
  String get multiText_1 {
    return Intl.message(
      'By clicking here you agree to',
      name: 'multiText_1',
      desc: '',
      args: [],
    );
  }

  /// `Our Terms of Service`
  String get multiText_2 {
    return Intl.message(
      'Our Terms of Service',
      name: 'multiText_2',
      desc: '',
      args: [],
    );
  }

  /// `And you have read`
  String get multiText_3 {
    return Intl.message(
      'And you have read',
      name: 'multiText_3',
      desc: '',
      args: [],
    );
  }

  /// `Our Policy Terms`
  String get multiText_4 {
    return Intl.message(
      'Our Policy Terms',
      name: 'multiText_4',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get errorEmail_1 {
    return Intl.message(
      'Please enter your email',
      name: 'errorEmail_1',
      desc: '',
      args: [],
    );
  }

  /// `Invalid mail`
  String get errorEmail_2 {
    return Intl.message(
      'Invalid mail',
      name: 'errorEmail_2',
      desc: '',
      args: [],
    );
  }

  /// `Invalid mail`
  String get errorEmail_3 {
    return Intl.message(
      'Invalid mail',
      name: 'errorEmail_3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the address`
  String get errorAddress_1 {
    return Intl.message(
      'Please enter the address',
      name: 'errorAddress_1',
      desc: '',
      args: [],
    );
  }

  /// `The address is too short`
  String get errorAddress_2 {
    return Intl.message(
      'The address is too short',
      name: 'errorAddress_2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get errorConfirmPass_1 {
    return Intl.message(
      'Please enter your password',
      name: 'errorConfirmPass_1',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get errorConfirmPass_2 {
    return Intl.message(
      'Password does not match',
      name: 'errorConfirmPass_2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter name`
  String get errorUserName_1 {
    return Intl.message(
      'Please enter name',
      name: 'errorUserName_1',
      desc: '',
      args: [],
    );
  }

  /// `The name is too short`
  String get errorUserName_2 {
    return Intl.message(
      'The name is too short',
      name: 'errorUserName_2',
      desc: '',
      args: [],
    );
  }

  /// `The name is too long`
  String get errorUserName_3 {
    return Intl.message(
      'The name is too long',
      name: 'errorUserName_3',
      desc: '',
      args: [],
    );
  }

  /// `warning`
  String get warning {
    return Intl.message(
      'warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Please allow location`
  String get messageLocation {
    return Intl.message(
      'Please allow location',
      name: 'messageLocation',
      desc: '',
      args: [],
    );
  }

  /// `allow`
  String get allow {
    return Intl.message(
      'allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `The phone number is already in use`
  String get errorPhoneUseBeforeApi {
    return Intl.message(
      'The phone number is already in use',
      name: 'errorPhoneUseBeforeApi',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to the terms of service.`
  String get errorConfirmPrivacy {
    return Intl.message(
      'Please agree to the terms of service.',
      name: 'errorConfirmPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized access has been granted. Please check your credentials and try again.`
  String get errorUnAuthorized {
    return Intl.message(
      'Unauthorized access has been granted. Please check your credentials and try again.',
      name: 'errorUnAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `verify code`
  String get titleVerify {
    return Intl.message(
      'verify code',
      name: 'titleVerify',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code sent to your phone number so you can continue.`
  String get bodyVerifyLogin {
    return Intl.message(
      'Please enter the code sent to your phone number so you can continue.',
      name: 'bodyVerifyLogin',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back. In a few moments you will be redirected to the home page.`
  String get succseLogin {
    return Intl.message(
      'Welcome back. In a few moments you will be redirected to the home page.',
      name: 'succseLogin',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created successfully. In a few moments you will be redirected to the home page.`
  String get succsesSign {
    return Intl.message(
      'Your account has been created successfully. In a few moments you will be redirected to the home page.',
      name: 'succsesSign',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get titleForgetPass {
    return Intl.message(
      'Reset password',
      name: 'titleForgetPass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number to send the secret code.`
  String get bodyForgetPass {
    return Intl.message(
      'Please enter your phone number to send the secret code.',
      name: 'bodyForgetPass',
      desc: '',
      args: [],
    );
  }

  /// `The phone number used is not registered..!`
  String get errorForgetPass {
    return Intl.message(
      'The phone number used is not registered..!',
      name: 'errorForgetPass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get titleAddNewPass {
    return Intl.message(
      'New Password',
      name: 'titleAddNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password.`
  String get bodyAddNewPass {
    return Intl.message(
      'Please enter your new password.',
      name: 'bodyAddNewPass',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
