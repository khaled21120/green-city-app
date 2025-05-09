abstract class Endpoints {
  static const String baseUrl =
      'https://greencityapitest-abgugdhahqgjf4fp.uaenorth-01.azurewebsites.net/';
  static const String geminiAPI = 'AIzaSyC30i9_OIYrWzVAxOLhRDeEdNmlfUeWNLA';

  static const String usersEndpoint = 'api/Users/me';
  static const String login = 'api/Auth/Login';
  static const String register = 'api/Auth/RegisterUser';
  static const String activities = 'CommunityActivities';
  static const String polls = 'api/Polls';
  static const String sendAnnouncements = 'api/UsersAnnouncements';
  static const String getAnnouncements = 'api/UsersAnnouncements/my-announcements';
  static const String userNotifications = 'UserNotifications';
  static const String publicNotifications = 'PublicNotifications';
}
