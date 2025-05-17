abstract class Endpoints {
  static const String baseUrl =
      'https://greencityapitest-abgugdhahqgjf4fp.uaenorth-01.azurewebsites.net/';
  static const String geminiAPI = 'AIzaSyAFtkb6xTh1wFWvj3-ViM2Fj-_JubxuyOE';

  static const String usersEndpoint = 'api/Users/my-profile';
  static const String login = 'api/Auth/Login';
  static const String register = 'api/Auth/RegisterUser';
  static const String activities = 'api/CommunityActivities';
  static const String polls = 'api/Polls';
  static const String sendAdminReports = 'api/Polls';
  static const String sendUserReports = 'api/UsersAnnouncements';
  static const String getUserReports =
      'api/UsersAnnouncements/my-announcements';
  static const String userNotifications = 'UserNotifications';
  static const String publicNotifications = 'PublicNotifications';
  static const String warehouses = 'api/Warehouses';
  static const String driverTasks = 'api/DriverTasks';
  static const String allDriversTasks = 'api/DriverTasks';
  static const String sendDriverReports = 'api/DriverReports';
}
