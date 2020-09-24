import 'package:device_preview/device_preview.dart';
import 'package:fiftyoneeast/util/AppLanguage.dart';
import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:fiftyoneeast/util/Logout.dart';
import 'package:fiftyoneeast/view/ApplicationPreferencesScreen.dart';
import 'package:fiftyoneeast/view/BrandScreen.dart';
import 'package:fiftyoneeast/view/CommunicationPreferencesScreen.dart';
import 'package:fiftyoneeast/view/MyComplaintScreen.dart';
import 'package:fiftyoneeast/view/ComplaintsScreen.dart';
import 'package:fiftyoneeast/view/EditProfileScreen.dart';
import 'package:fiftyoneeast/view/GiftCardScreen.dart';
import 'package:fiftyoneeast/view/LearnMoreScreenNew.dart';
import 'package:fiftyoneeast/view/MyComplaintDetailScreen.dart';
import 'package:fiftyoneeast/view/OfferDetailScreen.dart';
import 'package:fiftyoneeast/view/SplashScreenNew.dart';
import 'package:fiftyoneeast/view/StoreLocationScreen.dart';
import 'package:fiftyoneeast/view/TierBenefit.dart';
import 'package:fiftyoneeast/view/TierBenefitNew.dart';
import 'package:fiftyoneeast/view/TransactionDetailScreen.dart';
import 'package:fiftyoneeast/view/changepasswordscreen.dart';
import 'package:fiftyoneeast/view/contactusscreen.dart';
import 'package:fiftyoneeast/view/dashboardscreen.dart';
import 'package:fiftyoneeast/view/faqscreen.dart';
import 'package:fiftyoneeast/view/homescreen.dart';
import 'package:fiftyoneeast/view/moreoptionscreen.dart';
import 'package:fiftyoneeast/view/myaccount/claim/MyClaimDetailScreen.dart';
import 'package:fiftyoneeast/view/myaccount/claim/MyClaimScreen.dart';
import 'package:fiftyoneeast/view/myaccount/claim/claimpointsscreen.dart';
import 'package:fiftyoneeast/view/myaccountscreen.dart';
import 'package:fiftyoneeast/view/offersscreen.dart';
import 'package:fiftyoneeast/view/registration/CreateAccountScreen.dart';
import 'package:fiftyoneeast/view/registration/CreatePasswordScreen.dart';
import 'package:fiftyoneeast/view/registration/EnterMobileNumberScreen.dart';
import 'package:fiftyoneeast/view/registration/ForgotPasswordScreen.dart';
import 'package:fiftyoneeast/view/registration/LoginScreen.dart';
import 'package:fiftyoneeast/view/registration/OTP.dart';
import 'package:fiftyoneeast/view/terms&conditionsscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppLanguage.dart';
import 'package:flutter_app/utils/AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


void main() async
{
  //--- create a instance of sharePrefernce
  //await PreferenceUtils.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await  appLanguage.fetchLocale();
  runApp(Main(appLanguage: appLanguage,));
  /*runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>  Main(appLanguage: appLanguage,),
    ), );*/

}

class Main extends StatelessWidget
{
  final AppLanguage appLanguage;

  Main({this.appLanguage});

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider<AppLanguage>(
      builder: (context) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child)
      {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xff9A6095),
            primaryColorDark: Color(0xE66E2F68),
            primaryColorLight: Color(0xffffffff),
            fontFamily: 'RobotoSlab',
          ),
          //home: SplashScreenNew(),
          //home: HomeScreen(),
          home: ApplicationPreferencesScreen(),
          routes: <String, WidgetBuilder>
          {
            '/login':(BuildContext context) => new LoginScreen(),
            '/home':(BuildContext context) => new HomeScreen(),
            '/createAccount':(BuildContext context) => new CreateAccountScreen(),
            '/createPassword':(BuildContext context) => new CreatePasswordScreen(),
            '/enterMobileNumber':(BuildContext context) => new EnterMobileNumberScreen(),
            '/otp':(BuildContext context) => new OTP(),
            '/forgotPassword':(BuildContext context) => new ForgotPasswordScreen(),
            '/applicationPreferencesS':(BuildContext context) => new ApplicationPreferencesScreen(),
            '/brand':(BuildContext context) => new BrandScreen(),
            '/changepassword':(BuildContext context) => new ChangePassword(),
            '/claimpoints':(BuildContext context) => new ClaimPoints(),
            '/myClaimScreen':(BuildContext context) => new MyClaimScreen(),
            '/myClaimDetailScreen':(BuildContext context) => new MyClaimDetailScreen(),
            '/communicationPreferences':(BuildContext context) => new CommunicationPreferencesScreen(),
            '/contactus':(BuildContext context) => new GetContactUsDetails(),
            '/dashboard':(BuildContext context) => new DashboardScreen(),
            '/editProfile':(BuildContext context) => new EditProfileScreen(),
            '/faq':(BuildContext context) => new GetFAQDetails(),
            '/learnMore':(BuildContext context) => new LearnMoreScreenNew(),
            '/moreoptions':(BuildContext context) => new MoreOptions(),
            '/myaccount':(BuildContext context) => new MyAccount(),
            '/offerDetail':(BuildContext context) => new OfferDetailScreen(),
            '/offersscreen':(BuildContext context) => new OfferScreen(),
            '/splash':(BuildContext context) => new SplashScreenNew(),
            '/storeLocation':(BuildContext context) => new StoreLocationScreen(),
            '/termsCondition':(BuildContext context) => new GetTandCDetails(),
            '/tierBenefit':(BuildContext context) => new TierBenefit(),
            '/tierBenefitNew':(BuildContext context) => new TierBenefitNew(),
            '/transactionDetail':(BuildContext context) => new TransactionDetailScreen(),
            '/logout':(BuildContext context) => new Logout(),
            '/giftCard':(BuildContext context) => new GiftCardScreen(),
            '/complaints':(BuildContext context) => new ComplaintsScreen(),
            '/myComplaintScreen':(BuildContext context) => new MyComplaintScreen(),
            '/myComplaintDetail':(BuildContext context) => new MyComplaintDetailScreen(),
          },

          locale: model.appLocal,
          supportedLocales: [Locale('en', 'US'), Locale('ar', ''),],
          localizationsDelegates: [
            AppLocalizations.delegate,
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          //supportedLocales: [Locale("en"), Locale('ar')],
          //onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).title,
        );
      },
      ),
    );
  }
}