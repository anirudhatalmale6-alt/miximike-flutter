import 'package:flutter_music/widgets/settings/notification/notification_details.dart';
import 'package:flutter_music/widgets/settings/privacy.dart';
import 'package:flutter_music/widgets/settings/terms_and_conditions.dart';
import 'package:flutter_music/widgets/sign_in.dart';
import 'package:flutter_music/widgets/sign_up.dart';
import 'package:get/get.dart';

import '../pages/home.dart';
import '../screens/home/tracks/details.dart';
import '../widgets/settings/account/account.dart';
import '../widgets/settings/account/faq/faq.dart';

class Routes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String artistDetails = '/home/search/artist/details';
  static const String productDetails = '/home/search/product/details';
  static const String trackDetails = '/home/search/song/details';
  static const String account = '/home/settings/account';
  static const String notificationDetails = '/home/settings/notifications/details';
  static const String faq = '/home/settings/faq';
  static const String termsAndConditions = '/profile/terms-and-conditions';
  static const String privacy = '/profile/privacy';

  static List<GetPage> getPages() => [
    GetPage(name: signIn, page: () => const SignIn()),
    GetPage(name: signUp, page: () => const SignUp()),
    GetPage(name: home, page: () => const HomePage()),
    // GetPage(name: artistDetails, page: () => const ArtistDetailsScreen()),
    // GetPage(name: productDetails, page: () => const ProductDetailsScreen()),
    GetPage(name: notificationDetails, page: () => const NotificationDetailsScreen()),
    GetPage(name: faq, page: () => const FAQScreen()),
    GetPage(
        name: trackDetails,
        page: () => const TrackDetailsScreen(),
        transition: Transition.downToUp,
        fullscreenDialog: true
    ),
    GetPage(name: account, page: () => const AccountScreen()),
    GetPage(name: termsAndConditions, page: () => const TermsAndConditions()),
    GetPage(name: privacy, page: () => const Privacy()),
  ];
}
