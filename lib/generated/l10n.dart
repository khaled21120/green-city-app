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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in with `
  String get sign_in_with {
    return Intl.message(
      'Sign in with ',
      name: 'sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message('Sign in', name: 'sign_in', desc: '', args: []);
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message('Sign up', name: 'sign_up', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome {
    return Intl.message('Welcome Back', name: 'welcome', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue`
  String get sign_in_to_continue {
    return Intl.message(
      'Sign in to continue',
      name: 'sign_in_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to continue`
  String get sign_up_to_continue {
    return Intl.message(
      'Sign up to continue',
      name: 'sign_up_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get faqs {
    return Intl.message('FAQs', name: 'faqs', desc: '', args: []);
  }

  /// `Announcements`
  String get announcements {
    return Intl.message(
      'Announcements',
      name: 'announcements',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message('About Us', name: 'about_us', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Sign out`
  String get sign_out {
    return Intl.message('Sign out', name: 'sign_out', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Change Phone Number`
  String get change_phone_number {
    return Intl.message(
      'Change Phone Number',
      name: 'change_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get change_address {
    return Intl.message(
      'Change Address',
      name: 'change_address',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Activities`
  String get activities {
    return Intl.message('Activities', name: 'activities', desc: '', args: []);
  }

  /// `User Name`
  String get user_name {
    return Intl.message('User Name', name: 'user_name', desc: '', args: []);
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message('Join', name: 'join', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Enter`
  String get enter {
    return Intl.message('Enter', name: 'enter', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Update Your Profile Picture`
  String get update_profile_picture {
    return Intl.message(
      'Update Your Profile Picture',
      name: 'update_profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Our Mission`
  String get our_mission {
    return Intl.message('Our Mission', name: 'our_mission', desc: '', args: []);
  }

  /// `To create a cleaner and greener city through sustainable waste management practices, awareness campaigns, and modern recycling solutions.`
  String get our_mission_description {
    return Intl.message(
      'To create a cleaner and greener city through sustainable waste management practices, awareness campaigns, and modern recycling solutions.',
      name: 'our_mission_description',
      desc: '',
      args: [],
    );
  }

  /// `Our Vision`
  String get our_vision {
    return Intl.message('Our Vision', name: 'our_vision', desc: '', args: []);
  }

  /// `To make Green City the cleanest and most environmentally friendly city in the world.`
  String get our_vision_description {
    return Intl.message(
      'To make Green City the cleanest and most environmentally friendly city in the world.',
      name: 'our_vision_description',
      desc: '',
      args: [],
    );
  }

  /// `Our Services`
  String get our_services {
    return Intl.message(
      'Our Services',
      name: 'our_services',
      desc: '',
      args: [],
    );
  }

  /// `We provide waste collection, street cleaning, recycling initiatives, and public awareness programs.`
  String get our_services_description {
    return Intl.message(
      'We provide waste collection, street cleaning, recycling initiatives, and public awareness programs.',
      name: 'our_services_description',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `📍 123 Green City Street, EcoTown\n📧 support@greencity.com\n📞 +1 234 567 890`
  String get contact_us_description {
    return Intl.message(
      '📍 123 Green City Street, EcoTown\n📧 support@greencity.com\n📞 +1 234 567 890',
      name: 'contact_us_description',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Green City Cleaning Department`
  String get welcome_message {
    return Intl.message(
      'Welcome to Green City Cleaning Department',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `We are dedicated to keeping our city clean and green. Our mission is to provide eco-friendly waste management solutions, ensuring a healthier environment for future generations.`
  String get description {
    return Intl.message(
      'We are dedicated to keeping our city clean and green. Our mission is to provide eco-friendly waste management solutions, ensuring a healthier environment for future generations.',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Number of participants is complete`
  String get number_of_participants {
    return Intl.message(
      'Number of participants is complete',
      name: 'number_of_participants',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Participants`
  String get participants {
    return Intl.message(
      'Participants',
      name: 'participants',
      desc: '',
      args: [],
    );
  }

  /// `Polls`
  String get polls {
    return Intl.message('Polls', name: 'polls', desc: '', args: []);
  }

  /// `Vote`
  String get vote {
    return Intl.message('Vote', name: 'vote', desc: '', args: []);
  }

  /// `Select Date`
  String get select_date {
    return Intl.message('Select Date', name: 'select_date', desc: '', args: []);
  }

  /// `Your Announcement Type`
  String get your_announcement_type {
    return Intl.message(
      'Your Announcement Type',
      name: 'your_announcement_type',
      desc: '',
      args: [],
    );
  }

  /// `Your Bin Number`
  String get your_bin_number {
    return Intl.message(
      'Your Bin Number',
      name: 'your_bin_number',
      desc: '',
      args: [],
    );
  }

  /// `Your Region`
  String get your_region {
    return Intl.message('Your Region', name: 'your_region', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message('Private', name: 'private', desc: '', args: []);
  }

  /// `Public`
  String get public {
    return Intl.message('Public', name: 'public', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Assistant`
  String get assistant {
    return Intl.message('Assistant', name: 'assistant', desc: '', args: []);
  }

  /// `Type message...`
  String get typeMessage {
    return Intl.message(
      'Type message...',
      name: 'typeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Completed\n Announcements`
  String get completed_announcements {
    return Intl.message(
      'Completed\n Announcements',
      name: 'completed_announcements',
      desc: '',
      args: [],
    );
  }

  /// `Completed\n Activities`
  String get completed_activities {
    return Intl.message(
      'Completed\n Activities',
      name: 'completed_activities',
      desc: '',
      args: [],
    );
  }

  /// `Completed\n Polls`
  String get completed_polls {
    return Intl.message(
      'Completed\n Polls',
      name: 'completed_polls',
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
