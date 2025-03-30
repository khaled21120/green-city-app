abstract class Constants {
  static const String appName = 'Green City';
  static const String _images = 'assets/images/';
  static const String _assets = 'assets/';

  static const String db = '${_assets}db.json';
  static const String animation = '${_images}animation.json';
  static const String animation2 = '${_images}animation2.json';
  static const String logo = '${_images}logo.png';
  static const String logoDark = '${_images}logodark.png';
  static const String person = '${_images}person.png';
  static const String bg = '${_images}BG.png';
  static const String themeKey = 'themeMode';

  static const List<Map<String, String>> faqs = [
    {
      'question': 'What is Green City?',
      'answer':
          'Green City is a platform that connects people to green spaces and nature reserves.',
    },
    {
      'question': 'How can I use Green City?',
      'answer':
          'You can use Green City to find green spaces, reserve them, and manage your reservations.',
    },
    {
      'question': 'Is Green City free to use?',
      'answer': 'Yes, Green City is free to use.',
    },
    {
      'question': 'Can I use Green City on multiple devices?',
      'answer': 'Yes, Green City is available on multiple devices.',
    },
    {
      'question': 'Can I use Green City on multiple platforms?',
      'answer': 'Yes, Green City is available on multiple platforms.',
    },
    {
      'question': 'Can I use Green City on multiple countries?',
      'answer': 'Yes, Green City is available on multiple countries.',
    },
    {
      'question': 'Can I use Green City on multiple cities?',
      'answer': 'Yes, Green City is available on multiple cities.',
    },
  ];

  static const String kUserData = 'userData';

  static const String kIsLogin = 'isLogin';
  static const String kToken = 'token';
  static const String kLanguage = 'language';
}
