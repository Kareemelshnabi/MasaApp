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

  /// `The phone number entered is incorrect`
  String get errorPhone_3 {
    return Intl.message(
      'The phone number entered is incorrect',
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

  /// `Login as a guest?`
  String get mainAutrhVisitLogin {
    return Intl.message(
      'Login as a guest?',
      name: 'mainAutrhVisitLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get mainAutrhVisitClick {
    return Intl.message(
      'Login',
      name: 'mainAutrhVisitClick',
      desc: '',
      args: [],
    );
  }

  /// `Click to select the governorate`
  String get chhoseGovernorate {
    return Intl.message(
      'Click to select the governorate',
      name: 'chhoseGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Choose your governorate`
  String get chooseGovernorateList {
    return Intl.message(
      'Choose your governorate',
      name: 'chooseGovernorateList',
      desc: '',
      args: [],
    );
  }

  /// `Please log in or create an account`
  String get erroGuest {
    return Intl.message(
      'Please log in or create an account',
      name: 'erroGuest',
      desc: '',
      args: [],
    );
  }

  /// `Listening...`
  String get listenSearch {
    return Intl.message(
      'Listening...',
      name: 'listenSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search with us`
  String get search {
    return Intl.message(
      'Search with us',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Speech not available`
  String get errorListenSearch {
    return Intl.message(
      'Speech not available',
      name: 'errorListenSearch',
      desc: '',
      args: [],
    );
  }

  /// `you`
  String get you {
    return Intl.message(
      'you',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `No products`
  String get noProduct {
    return Intl.message(
      'No products',
      name: 'noProduct',
      desc: '',
      args: [],
    );
  }

  /// `Other services`
  String get anotherServices {
    return Intl.message(
      'Other services',
      name: 'anotherServices',
      desc: '',
      args: [],
    );
  }

  /// `Browse our selection of different services that will help you with everything you need.`
  String get anotherServiceDescrip {
    return Intl.message(
      'Browse our selection of different services that will help you with everything you need.',
      name: 'anotherServiceDescrip',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Our Services`
  String get services {
    return Intl.message(
      'Our Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buy {
    return Intl.message(
      'Buy Now',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm address`
  String get confirmAddress {
    return Intl.message(
      'Confirm address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favouritePage {
    return Intl.message(
      'Favourite',
      name: 'favouritePage',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get cardPage {
    return Intl.message(
      'My Wallet',
      name: 'cardPage',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePage {
    return Intl.message(
      'Profile',
      name: 'profilePage',
      desc: '',
      args: [],
    );
  }

  /// `Favourite Products`
  String get favItems {
    return Intl.message(
      'Favourite Products',
      name: 'favItems',
      desc: '',
      args: [],
    );
  }

  /// `No favorites`
  String get noFav {
    return Intl.message(
      'No favorites',
      name: 'noFav',
      desc: '',
      args: [],
    );
  }

  /// `You can add an item to your favorites by clicking on the heart icon.`
  String get descripFav {
    return Intl.message(
      'You can add an item to your favorites by clicking on the heart icon.',
      name: 'descripFav',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get orders {
    return Intl.message(
      'My Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `My account details`
  String get profileInfoTitle {
    return Intl.message(
      'My account details',
      name: 'profileInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact {
    return Intl.message(
      'Contact us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get infoAboutUs {
    return Intl.message(
      'About us',
      name: 'infoAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get logOut {
    return Intl.message(
      'LogOut',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message(
      'Governorate',
      name: 'governorate',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get country {
    return Intl.message(
      'State',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPass {
    return Intl.message(
      'Current Password',
      name: 'currentPass',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPass {
    return Intl.message(
      'New Password',
      name: 'newPass',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChange {
    return Intl.message(
      'Save changes',
      name: 'saveChange',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get changeImage {
    return Intl.message(
      'Change Image',
      name: 'changeImage',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions, please contact us. We will be happy to assist you.`
  String get bodyContact {
    return Intl.message(
      'If you have any questions, please contact us. We will be happy to assist you.',
      name: 'bodyContact',
      desc: '',
      args: [],
    );
  }

  /// `You can call, text or WhatsApp us on the numbers below, charges will apply according to your network providers.`
  String get mobileInfo {
    return Intl.message(
      'You can call, text or WhatsApp us on the numbers below, charges will apply according to your network providers.',
      name: 'mobileInfo',
      desc: '',
      args: [],
    );
  }

  /// `We respond to emails within 24 hours.`
  String get emailInfo {
    return Intl.message(
      'We respond to emails within 24 hours.',
      name: 'emailInfo',
      desc: '',
      args: [],
    );
  }

  /// `Social Media`
  String get socialMedia {
    return Intl.message(
      'Social Media',
      name: 'socialMedia',
      desc: '',
      args: [],
    );
  }

  /// `Follow us on our social media sites to get notifications of exciting updates and offers.`
  String get socialInfo {
    return Intl.message(
      'Follow us on our social media sites to get notifications of exciting updates and offers.',
      name: 'socialInfo',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacy {
    return Intl.message(
      'privacy policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termOfServic {
    return Intl.message(
      'Terms of Service',
      name: 'termOfServic',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get faceIcon {
    return Intl.message(
      'Facebook',
      name: 'faceIcon',
      desc: '',
      args: [],
    );
  }

  /// `Instegram`
  String get instaIcon {
    return Intl.message(
      'Instegram',
      name: 'instaIcon',
      desc: '',
      args: [],
    );
  }

  /// `No categories yet`
  String get noCategory {
    return Intl.message(
      'No categories yet',
      name: 'noCategory',
      desc: '',
      args: [],
    );
  }

  /// `Explore our diverse collection of categories to find the services and products that fit your individual needs.`
  String get bodyCategoryPage {
    return Intl.message(
      'Explore our diverse collection of categories to find the services and products that fit your individual needs.',
      name: 'bodyCategoryPage',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category {
    return Intl.message(
      'Categories',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Shop with confidence`
  String get confidence {
    return Intl.message(
      'Shop with confidence',
      name: 'confidence',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get cashOnDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'cashOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Ship from Mas`
  String get shipFromMas {
    return Intl.message(
      'Ship from Mas',
      name: 'shipFromMas',
      desc: '',
      args: [],
    );
  }

  /// `Free shipping`
  String get freeShipping {
    return Intl.message(
      'Free shipping',
      name: 'freeShipping',
      desc: '',
      args: [],
    );
  }

  /// `Your transaction is safe`
  String get transactionSafe {
    return Intl.message(
      'Your transaction is safe',
      name: 'transactionSafe',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get detailProduct {
    return Intl.message(
      'Product Details',
      name: 'detailProduct',
      desc: '',
      args: [],
    );
  }

  /// `Additional Details`
  String get additionalDeatail {
    return Intl.message(
      'Additional Details',
      name: 'additionalDeatail',
      desc: '',
      args: [],
    );
  }

  /// `User Reviews`
  String get review {
    return Intl.message(
      'User Reviews',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Price without discount : `
  String get priceWithoutDiscount {
    return Intl.message(
      'Price without discount : ',
      name: 'priceWithoutDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Prices include tax`
  String get tax {
    return Intl.message(
      'Prices include tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Ships From `
  String get shipFrom {
    return Intl.message(
      'Ships From ',
      name: 'shipFrom',
      desc: '',
      args: [],
    );
  }

  /// `Sold by `
  String get soldBy {
    return Intl.message(
      'Sold by ',
      name: 'soldBy',
      desc: '',
      args: [],
    );
  }

  /// `Please specify quantity`
  String get specifyQuantity {
    return Intl.message(
      'Please specify quantity',
      name: 'specifyQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get currentOrder {
    return Intl.message(
      'Current',
      name: 'currentOrder',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get periviousOrder {
    return Intl.message(
      'Previous',
      name: 'periviousOrder',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceledOrder {
    return Intl.message(
      'Canceled',
      name: 'canceledOrder',
      desc: '',
      args: [],
    );
  }

  /// `No Orders Yet`
  String get noOrder {
    return Intl.message(
      'No Orders Yet',
      name: 'noOrder',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get valid {
    return Intl.message(
      'Valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `There are no cancelled orders yet`
  String get noCancelOrder {
    return Intl.message(
      'There are no cancelled orders yet',
      name: 'noCancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Your request has been confirmed`
  String get confirmStatus {
    return Intl.message(
      'Your request has been confirmed',
      name: 'confirmStatus',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paidStatus {
    return Intl.message(
      'Paid',
      name: 'paidStatus',
      desc: '',
      args: [],
    );
  }

  /// `Out for delivery`
  String get deliverStatus {
    return Intl.message(
      'Out for delivery',
      name: 'deliverStatus',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get deliveredStatus {
    return Intl.message(
      'Delivered',
      name: 'deliveredStatus',
      desc: '',
      args: [],
    );
  }

  /// `Back to chat`
  String get returnChat {
    return Intl.message(
      'Back to chat',
      name: 'returnChat',
      desc: '',
      args: [],
    );
  }

  /// `Your order details`
  String get detailOrder {
    return Intl.message(
      'Your order details',
      name: 'detailOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetail {
    return Intl.message(
      'Order Details',
      name: 'orderDetail',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNum {
    return Intl.message(
      'Order Number',
      name: 'orderNum',
      desc: '',
      args: [],
    );
  }

  /// `order date`
  String get orderDate {
    return Intl.message(
      'order date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal Price`
  String get subtotalPrice {
    return Intl.message(
      'Subtotal Price',
      name: 'subtotalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Tax Value`
  String get taxVAlue {
    return Intl.message(
      'Tax Value',
      name: 'taxVAlue',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to change the delivery address?`
  String get messageAddress {
    return Intl.message(
      'Are you sure you want to change the delivery address?',
      name: 'messageAddress',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `No Chats Yet`
  String get noChats {
    return Intl.message(
      'No Chats Yet',
      name: 'noChats',
      desc: '',
      args: [],
    );
  }

  /// `You: Voice Message`
  String get voiceMessage {
    return Intl.message(
      'You: Voice Message',
      name: 'voiceMessage',
      desc: '',
      args: [],
    );
  }

  /// `Review Order`
  String get reviewOrder {
    return Intl.message(
      'Review Order',
      name: 'reviewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirmOrder {
    return Intl.message(
      'Confirm Order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Choose Payment`
  String get choosePayment {
    return Intl.message(
      'Choose Payment',
      name: 'choosePayment',
      desc: '',
      args: [],
    );
  }

  /// `Pay Online`
  String get payyOnline {
    return Intl.message(
      'Pay Online',
      name: 'payyOnline',
      desc: '',
      args: [],
    );
  }

  /// `Payment by cash`
  String get payCash {
    return Intl.message(
      'Payment by cash',
      name: 'payCash',
      desc: '',
      args: [],
    );
  }

  /// `Click to write...`
  String get clickWrite {
    return Intl.message(
      'Click to write...',
      name: 'clickWrite',
      desc: '',
      args: [],
    );
  }

  /// `This conversation has ended and`
  String get bottomPartOneChat {
    return Intl.message(
      'This conversation has ended and',
      name: 'bottomPartOneChat',
      desc: '',
      args: [],
    );
  }

  /// `Your request`
  String get bottomPartTwoChat {
    return Intl.message(
      'Your request',
      name: 'bottomPartTwoChat',
      desc: '',
      args: [],
    );
  }

  /// `Additional Options`
  String get additionalOption {
    return Intl.message(
      'Additional Options',
      name: 'additionalOption',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not registered`
  String get phoneNoteRegister {
    return Intl.message(
      'Phone number not registered',
      name: 'phoneNoteRegister',
      desc: '',
      args: [],
    );
  }

  /// `The account has not been verified`
  String get notVerify {
    return Intl.message(
      'The account has not been verified',
      name: 'notVerify',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the number`
  String get confirmNum {
    return Intl.message(
      'Please verify the number',
      name: 'confirmNum',
      desc: '',
      args: [],
    );
  }

  /// `Verify the number`
  String get verifyPhone {
    return Intl.message(
      'Verify the number',
      name: 'verifyPhone',
      desc: '',
      args: [],
    );
  }

  /// `The phone number is already registered`
  String get phoneRegister {
    return Intl.message(
      'The phone number is already registered',
      name: 'phoneRegister',
      desc: '',
      args: [],
    );
  }

  /// `Please choose the governorate`
  String get chooseGovernorateError {
    return Intl.message(
      'Please choose the governorate',
      name: 'chooseGovernorateError',
      desc: '',
      args: [],
    );
  }

  /// `The entered code is incorrect`
  String get codeVerifyIncorrect {
    return Intl.message(
      'The entered code is incorrect',
      name: 'codeVerifyIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `From the camera`
  String get fromCamera {
    return Intl.message(
      'From the camera',
      name: 'fromCamera',
      desc: '',
      args: [],
    );
  }

  /// `From the Gallery`
  String get fromGallery {
    return Intl.message(
      'From the Gallery',
      name: 'fromGallery',
      desc: '',
      args: [],
    );
  }

  /// `The current password entered is incorrect`
  String get errorCurrentPass {
    return Intl.message(
      'The current password entered is incorrect',
      name: 'errorCurrentPass',
      desc: '',
      args: [],
    );
  }

  /// `Your account information has been successfully changed. In a few moments you will be redirected to your home page.`
  String get succsesUpdate {
    return Intl.message(
      'Your account information has been successfully changed. In a few moments you will be redirected to your home page.',
      name: 'succsesUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get messageLogOut {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'messageLogOut',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message(
      'File',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `the phone not verified`
  String get phoneNotVerify {
    return Intl.message(
      'the phone not verified',
      name: 'phoneNotVerify',
      desc: '',
      args: [],
    );
  }

  /// `please enter code`
  String get errorEnterCode {
    return Intl.message(
      'please enter code',
      name: 'errorEnterCode',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get messageDeleteAccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'messageDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
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
