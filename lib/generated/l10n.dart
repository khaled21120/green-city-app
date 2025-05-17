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

  /// `Forget Password?`
  String get forget_password {
    return Intl.message(
      'Forget Password?',
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

  /// `Reports`
  String get reports {
    return Intl.message('Reports', name: 'reports', desc: '', args: []);
  }

  /// `No Reports`
  String get no_reports {
    return Intl.message('No Reports', name: 'no_reports', desc: '', args: []);
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

  /// `Take photo`
  String get camera {
    return Intl.message('Take photo', name: 'camera', desc: '', args: []);
  }

  /// `Choose from Gallery`
  String get gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
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

  /// `Your Report Type`
  String get your_report_type {
    return Intl.message(
      'Your Report Type',
      name: 'your_report_type',
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

  /// `Accepted\n Reports`
  String get accepted_reports {
    return Intl.message(
      'Accepted\n Reports',
      name: 'accepted_reports',
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

  /// `Welcome back!`
  String get welcome_back {
    return Intl.message(
      'Welcome back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Quick Actions`
  String get quick_actions {
    return Intl.message(
      'Quick Actions',
      name: 'quick_actions',
      desc: '',
      args: [],
    );
  }

  /// `Submit Feedback`
  String get submit_feedback {
    return Intl.message(
      'Submit Feedback',
      name: 'submit_feedback',
      desc: '',
      args: [],
    );
  }

  /// `View My Reports`
  String get view_my_reports {
    return Intl.message(
      'View My Reports',
      name: 'view_my_reports',
      desc: '',
      args: [],
    );
  }

  /// `Report Location`
  String get report_location {
    return Intl.message(
      'Report Location',
      name: 'report_location',
      desc: '',
      args: [],
    );
  }

  /// `Add Report`
  String get add_report {
    return Intl.message('Add Report', name: 'add_report', desc: '', args: []);
  }

  /// `Please select`
  String get please_select {
    return Intl.message(
      'Please select',
      name: 'please_select',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Green City`
  String get welcome_title {
    return Intl.message(
      'Welcome to Green City',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Join our community to make your city cleaner and greener every day`
  String get welcome_subtitle {
    return Intl.message(
      'Join our community to make your city cleaner and greener every day',
      name: 'welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get about_app {
    return Intl.message('About App', name: 'about_app', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Copyright`
  String get copyright {
    return Intl.message('Copyright', name: 'copyright', desc: '', args: []);
  }

  /// `Developed By`
  String get developed_by {
    return Intl.message(
      'Developed By',
      name: 'developed_by',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Select Institution`
  String get selectInstitution {
    return Intl.message(
      'Select Institution',
      name: 'selectInstitution',
      desc: '',
      args: [],
    );
  }

  /// `Institution Name`
  String get institutionName {
    return Intl.message(
      'Institution Name',
      name: 'institutionName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Number`
  String get contactNumber {
    return Intl.message(
      'Contact Number',
      name: 'contactNumber',
      desc: '',
      args: [],
    );
  }

  /// `Location Address`
  String get locationAddress {
    return Intl.message(
      'Location Address',
      name: 'locationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Additional Notes`
  String get additionalNotes {
    return Intl.message(
      'Additional Notes',
      name: 'additionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Waste Type`
  String get wasteType {
    return Intl.message('Waste Type', name: 'wasteType', desc: '', args: []);
  }

  /// `Select type`
  String get selectType {
    return Intl.message('Select type', name: 'selectType', desc: '', args: []);
  }

  /// `Quantity (kg)`
  String get estimatedQuantity {
    return Intl.message(
      'Quantity (kg)',
      name: 'estimatedQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Payment Information`
  String get paymentInformation {
    return Intl.message(
      'Payment Information',
      name: 'paymentInformation',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Cost:`
  String get estimatedCost {
    return Intl.message(
      'Estimated Cost:',
      name: 'estimatedCost',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `For Institutions`
  String get for_Institutions {
    return Intl.message(
      'For Institutions',
      name: 'for_Institutions',
      desc: '',
      args: [],
    );
  }

  /// `For Individuals`
  String get for_Individuals {
    return Intl.message(
      'For Individuals',
      name: 'for_Individuals',
      desc: '',
      args: [],
    );
  }

  /// `My Reports`
  String get my_reports {
    return Intl.message('My Reports', name: 'my_reports', desc: '', args: []);
  }

  /// `No Image`
  String get no_image {
    return Intl.message('No Image', name: 'no_image', desc: '', args: []);
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Select Warehouse`
  String get select_warehouse {
    return Intl.message(
      'Select Warehouse',
      name: 'select_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get additional_information {
    return Intl.message(
      'Additional Information',
      name: 'additional_information',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `You have completed all tasks for this month`
  String get completed_tasks {
    return Intl.message(
      'You have completed all tasks for this month',
      name: 'completed_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Task Progress`
  String get task_progress {
    return Intl.message(
      'Task Progress',
      name: 'task_progress',
      desc: '',
      args: [],
    );
  }

  /// `Check Tasks`
  String get check_tasks {
    return Intl.message('Check Tasks', name: 'check_tasks', desc: '', args: []);
  }

  /// `Today's Tasks`
  String get todays_tasks {
    return Intl.message(
      'Today\'s Tasks',
      name: 'todays_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Pending Tasks`
  String get pending_tasks {
    return Intl.message(
      'Pending Tasks',
      name: 'pending_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get good_morning {
    return Intl.message(
      'Good Morning',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get good_afternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'good_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get good_evening {
    return Intl.message(
      'Good Evening',
      name: 'good_evening',
      desc: '',
      args: [],
    );
  }

  /// `Driver`
  String get driver {
    return Intl.message('Driver', name: 'driver', desc: '', args: []);
  }

  /// `Tasks Remaining for this month`
  String get remaining_tasks {
    return Intl.message(
      'Tasks Remaining for this month',
      name: 'remaining_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Not Provided`
  String get not_provided {
    return Intl.message(
      'Not Provided',
      name: 'not_provided',
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
