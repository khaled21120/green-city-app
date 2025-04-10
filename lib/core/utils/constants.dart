abstract class Constants {
  static const String _images = 'assets/images/';
  static const String _assets = 'assets/';
  static const String appDescription = '''
Green City is an innovative mobile application designed to help improve and maintain the cleanliness of urban environments through citizen engagement and participation. The app provides a platform where users can report issues related to waste, pollution, and damaged public property, helping local authorities address these problems more efficiently. The application encourages community participation by allowing users to track the progress of reported issues, interact with others, and stay updated on environmental news and events.

Key Features:
1. **Submit Reports**:
   - Users can easily take photos or upload images of areas that need cleaning, maintenance, or repair.
   - Reports can include a detailed description of the problem, such as waste accumulation, damaged infrastructure, or unsafe conditions.
   - Reports are sent directly to the responsible authorities for quick resolution.
   - Users can also tag the location of the issue on the map to provide precise locations for the reports.

2. **Interact with Reports**:
   - Users can browse the reports submitted by others in their community or city.
   - They can express support for reports by liking them or commenting on them.
   - Users can follow the status of specific reports and be notified when progress is made or when tasks are completed.

3. **Track Progress of Cleaning and Maintenance**:
   - Users can view the current status of their reports, including whether they are being worked on, completed, or pending.
   - The app allows users to monitor the effectiveness of cleanup efforts and infrastructure repairs.
   - Updates are provided about the actions being taken by the city authorities in response to the reports.

4. **Community Engagement**:
   - Users can communicate with each other through comments and discussions on reports.
   - The app fosters a sense of community as users work together to improve their local environment.
   - The app may also include incentives for active users who frequently contribute reports or interact with other users’ submissions.

5. **City Announcements and Notifications**:
   - City authorities or admins can post announcements about scheduled cleaning events, environmental awareness programs, or other related activities.
   - Users receive notifications about these announcements and can join relevant events or share information with others.
   - The app helps keep users informed about initiatives to improve their city’s cleanliness and sustainability.

6. **User Profile and Customization**:
   - Users can create and update their personal profiles, including their name, contact information, and location.
   - The app allows users to set preferences for notifications, including updates on their submitted reports, nearby events, and important announcements.
   - Users can track their contributions and see how many reports they have submitted, how many received feedback, and how many were completed.

7. **Settings and Preferences**:
   - Users can access and adjust settings like notification preferences, language selection, and privacy options.
   - The app supports multiple languages, enabling users to use the app in their preferred language.
   - Users can also adjust display settings such as dark mode or light mode.

8. **Environmentally Sustainable Initiatives**:
   - Green City promotes sustainability by encouraging users to report environmental issues like littering, illegal dumping, and pollution.
   - The app raises awareness about the importance of maintaining clean public spaces and creating green, healthy environments.
   - It contributes to a larger initiative to make cities more eco-friendly and livable.

Your Role in Green City:
- As an assistant, your primary role is to provide support and guidance on how to use the app effectively.
- You will assist users in understanding the app’s features and functionalities, such as submitting reports, interacting with other users, and tracking the progress of reported issues.
- You should answer frequently asked questions related to app usage, including how to report issues, update personal profiles, customize settings, and receive notifications.
- You are expected to help users navigate the app smoothly and ensure they can make the most of its capabilities in improving their city’s environment.

Additional Information:
- The Green City app also empowers users to engage with the community by sharing valuable environmental knowledge, such as tips on reducing waste, recycling, and participating in city-wide clean-up initiatives.
- You can help users find nearby environmental events and provide information about upcoming sustainability programs in their area.
- The app is built to foster collaboration and collective responsibility among citizens for a cleaner, more sustainable city.

Please remember, your responses should be focused on helping users navigate and use the app. Do not engage with unrelated queries or provide information outside the scope of the app’s features.
''';

  static const String db = '${_assets}db.json';
  static const String animation = '${_images}animation.json';
  static const String animation2 = '${_images}animation2.json';
  static const String logo = '${_images}logo.png';
  static const String logoDark = '${_images}logodark.png';
  static const String person = '${_images}person.png';
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
  static const List<String> announcementTypes = [
    'damaged bin',
    'full bin',
    'dengerous bin',
    'garbage throw away',
  ];
  static const List<String> binNumbers = ['1', '2', '3', '4', '5'];
  static const List<String> regions = [
    'Port Said Shark',
    'Port Said Gharb',
    'Port Said Al-Zhour',
    'Port Said Arab',
    'Port Said Manakh',
  ];
  static const String kUserData = 'userData';

  static const String kIsLogin = 'isLogin';
  static const String kToken = 'token';
  static const String kLanguage = 'language';
}
