// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'dzevent';

  @override
  String get createNewEvent => 'Create New Event';

  @override
  String get eventName => 'Event Name';

  @override
  String get eventNameHint => 'Annual Tech Conference';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Join us for a day of insightful seminars...';

  @override
  String get date => 'Date';

  @override
  String get selectDate => 'Select Date';

  @override
  String get time => 'Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get location => 'Location';

  @override
  String get locationHint => '123 Main St, Any City';

  @override
  String get eventCategory => 'Event Category';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get catTech => 'Technology';

  @override
  String get catAIData => 'AI & Data Science';

  @override
  String get catBusiness => 'Business';

  @override
  String get catAgriculture => 'Agriculture';

  @override
  String get catSociology => 'Sociology';

  @override
  String get chooseImage => 'Choose Image';

  @override
  String get previewEvent => 'Preview Event';

  @override
  String get postEvent => 'Post Event';

  @override
  String get accountRequests => 'Account Requests';

  @override
  String get searchHint => 'Search by association name...';

  @override
  String get all => 'All';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String get rejected => 'Rejected';

  @override
  String get reject => 'Reject';

  @override
  String get accept => 'Accept';

  @override
  String requestedOn(Object date) {
    return 'Requested on: $date';
  }

  @override
  String get subscribers => 'Subscribers';

  @override
  String get eventsCount => 'Events';

  @override
  String get interested => 'Interested';

  @override
  String get eventsTitle => 'Events';

  @override
  String interestedCount(Object num) {
    return '$num interested';
  }

  @override
  String get aboutThisEvent => 'About this event';

  @override
  String get showInterest => 'Show interest';

  @override
  String get viewProfile => 'View profile';

  @override
  String get addEvent => 'Add Event';

  @override
  String get assocAdmin => 'Association Admin';

  @override
  String get assocProfileTwo => 'Association Profile';

  @override
  String get eventDetails => 'Event Details';

  @override
  String get eventFeed => 'Event Feed';

  @override
  String get publicAssocProfile => 'Public Association Profile';

  @override
  String get signup => 'Sign Up';

  @override
  String get welcome => 'Welcome';

  @override
  String get creds => 'Credentials';

  @override
  String get userRegs => 'User Registrations';

  @override
  String get home => 'Home';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get emailOrUsername => 'Email or username';

  @override
  String get enterEmailOrUsername => 'Enter email or username';

  @override
  String get password => 'Password';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get or => 'or';

  @override
  String get login => 'Login';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get newPasswordHint => 'New Password';

  @override
  String get cancel => 'Cancel';

  @override
  String get saveUpdate => 'Save Update';

  @override
  String get upcomingEvents => 'Upcoming events';

  @override
  String get searchBarHint => 'Search for events ...';

  @override
  String errorOccurred(Object error) {
    return 'Error: $error';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterMusic => 'Music';

  @override
  String get filterSports => 'Sports';

  @override
  String get filterArts => 'Arts';

  @override
  String get filterTech => 'Tech';

  @override
  String get oneEvent => '+1 event';

  @override
  String get followAssociation => 'Follow Association';

  @override
  String get aboutUs => 'About us';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get pastEvents => 'Past events';

  @override
  String get profile => 'Profile';

  @override
  String get myAccount => 'My Account';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get logOut => 'Log Out';

  @override
  String get createNewAccount => 'Create New Account';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailAddressHint => 'Enter your email address';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Confirm your password';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log In';

  @override
  String get byCreatingAccount => 'By creating an account, you agree to our';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get continueAsGuest => 'Continue as Guest';
}
