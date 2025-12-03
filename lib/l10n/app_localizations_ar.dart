// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ديزيفينت';

  @override
  String get createNewEvent => 'إنشاء حدث جديد';

  @override
  String get eventName => 'اسم الحدث';

  @override
  String get eventNameHint => 'المؤتمر التقني السنوي';

  @override
  String get description => 'الوصف';

  @override
  String get descriptionHint => 'انضم إلينا ليوم مليء بالندوات المفيدة...';

  @override
  String get date => 'التاريخ';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get time => 'الوقت';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String get location => 'الموقع';

  @override
  String get locationHint => '123 شارع الرئيسي، أي مدينة';

  @override
  String get eventCategory => 'فئة الحدث';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get catTech => 'تكنولوجيا';

  @override
  String get catAIData => 'الذكاء الاصطناعي وعلوم البيانات';

  @override
  String get catBusiness => 'أعمال';

  @override
  String get catAgriculture => 'فلاحة';

  @override
  String get catSociology => 'علوم اجتماعية';

  @override
  String get chooseImage => 'اختر صورة';

  @override
  String get previewEvent => 'معاينة الحدث';

  @override
  String get postEvent => 'نشر الحدث';

  @override
  String get accountRequests => 'طلبات الحساب';

  @override
  String get searchHint => 'ابحث باسم الجمعية...';

  @override
  String get all => 'الكل';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get accepted => 'مقبول';

  @override
  String get rejected => 'مرفوض';

  @override
  String get reject => 'رفض';

  @override
  String get accept => 'قبول';

  @override
  String requestedOn(Object date) {
    return 'تم الطلب في: $date';
  }

  @override
  String get subscribers => 'المشتركين';

  @override
  String get eventsCount => 'الأحداث';

  @override
  String get interested => 'مهتمون';

  @override
  String get eventsTitle => 'الأحداث';

  @override
  String interestedCount(Object num) {
    return '$num مهتم';
  }

  @override
  String get aboutThisEvent => 'حول هذا الحدث';

  @override
  String get showInterest => 'أبدِ اهتمامك';

  @override
  String get viewProfile => 'عرض الملف الشخصي';

  @override
  String get addEvent => 'إضافة فعالية';

  @override
  String get assocAdmin => 'إدارة الجمعية';

  @override
  String get assocProfileTwo => 'ملف الجمعية';

  @override
  String get eventDetails => 'تفاصيل الفعالية';

  @override
  String get eventFeed => 'تدفق الفعاليات';

  @override
  String get publicAssocProfile => 'الملف العام للجمعية';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get welcome => 'مرحبا';

  @override
  String get creds => 'بيانات الحساب';

  @override
  String get userRegs => 'تسجيل المستخدمين';

  @override
  String get home => 'الرئيسية';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get emailOrUsername => 'البريد الإلكتروني أو اسم المستخدم';

  @override
  String get enterEmailOrUsername => 'أدخل البريد الإلكتروني أو اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'سجل الآن';

  @override
  String get continueWithGoogle => 'المتابعة مع جوجل';

  @override
  String get or => 'أو';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get name => 'الاسم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phone => 'الهاتف';

  @override
  String get address => 'العنوان';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get newPasswordHint => 'كلمة المرور الجديدة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get saveUpdate => 'حفظ التحديث';

  @override
  String get upcomingEvents => 'الفعاليات القادمة';

  @override
  String get searchBarHint => 'ابحث عن الفعاليات ...';

  @override
  String errorOccurred(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get filterAll => 'الكل';

  @override
  String get filterMusic => 'الموسيقى';

  @override
  String get filterSports => 'الرياضة';

  @override
  String get filterArts => 'الفنون';

  @override
  String get filterTech => 'التقنية';

  @override
  String get oneEvent => '+1 فعالية';

  @override
  String get followAssociation => 'متابعة الجمعية';

  @override
  String get aboutUs => 'معلومات عنا';

  @override
  String get contactInformation => 'معلومات الاتصال';

  @override
  String get pastEvents => 'الأحداث السابقة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get myAccount => 'حسابي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أدخل اسمك الكامل';

  @override
  String get emailAddress => 'عنوان البريد الإلكتروني';

  @override
  String get emailAddressHint => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get passwordHint => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordHint => 'أكد كلمة المرور الخاصة بك';

  @override
  String get createAccount => 'إنشاء الحساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get byCreatingAccount => 'من خلال إنشاء حساب، فإنك توافق على';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get and => 'و';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get continueAsGuest => 'المتابعة كضيف';
}
