abstract class Endpoints {
  static const String baseUrl = 'https://greencityapi.runasp.net/';
  static const String geminiAPI = 'AIzaSyAFtkb6xTh1wFWvj3-ViM2Fj-_JubxuyOE';
  static const String _userEndpoints = 'api/Users';
  static const String _adminEndpoints = 'api/Users';
  static const String _driverEndpoints = 'api/TruckDrivers';

  static const String getUserData = '$_userEndpoints/my-profile';
  static const String login = 'api/Auth/Login';
  static const String register = 'api/Auth/RegisterUser';
  static const String activities = 'api/CommunityActivities';
  static const String myActivities = 'api/CommunityActivities/my-subscriptions';
  static const String polls = 'api/Polls';
  static const String contactUs = 'api/ContactUs';
  static const String region = 'api/Regions';
  static const String myPolls = 'api/Polls/subscribed';
  static const String sendAdminReports = 'api/Warehouse';
  static const String sendUserReports = 'api/UsersAnnouncements';
  static const String sendPayedReports = 'api/UsersAnnouncements/waste-request';
  static const String getUserReports =
      'api/UsersAnnouncements/my-announcements';
  static const String userNotifications = 'UserNotifications';
  static const String publicNotifications = 'PublicNotifications';
  static const String warehouses = 'api/Warehouses';
  static const String driverTasks = '$_driverEndpoints/my-tasks';
  static const String allDriversTasks = 'api/UsersAnnouncements/approved';
  static const String acceptDriverTask = '$_driverEndpoints/accept-tasks';
  static const String completeDriverTask = '$_driverEndpoints/complete-task';
  static const String sendDriverReports = '$_driverEndpoints/DriverReports';
}
