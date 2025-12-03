// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'dzevent';

  @override
  String get createNewEvent => 'Créer un nouvel événement';

  @override
  String get eventName => 'Nom de l\'événement';

  @override
  String get eventNameHint => 'Conférence technologique annuelle';

  @override
  String get description => 'Description';

  @override
  String get descriptionHint => 'Rejoignez-nous pour une journée riche en séminaires...';

  @override
  String get date => 'Date';

  @override
  String get selectDate => 'Sélectionner une date';

  @override
  String get time => 'Heure';

  @override
  String get selectTime => 'Sélectionner une heure';

  @override
  String get location => 'Lieu';

  @override
  String get locationHint => '123 Rue Principale, Toute Ville';

  @override
  String get eventCategory => 'Catégorie de l\'événement';

  @override
  String get selectCategory => 'Sélectionner une catégorie';

  @override
  String get catTech => 'Technologie';

  @override
  String get catAIData => 'IA & Science des données';

  @override
  String get catBusiness => 'Business';

  @override
  String get catAgriculture => 'Agriculture';

  @override
  String get catSociology => 'Sociologie';

  @override
  String get chooseImage => 'Choisir une image';

  @override
  String get previewEvent => 'Aperçu de l\'événement';

  @override
  String get postEvent => 'Publier l\'événement';

  @override
  String get accountRequests => 'Demandes de compte';

  @override
  String get searchHint => 'Rechercher par nom de l\'association...';

  @override
  String get all => 'Tout';

  @override
  String get pending => 'En attente';

  @override
  String get accepted => 'Accepté';

  @override
  String get rejected => 'Rejeté';

  @override
  String get reject => 'Refuser';

  @override
  String get accept => 'Accepter';

  @override
  String requestedOn(Object date) {
    return 'Demandé le : $date';
  }

  @override
  String get subscribers => 'Abonnés';

  @override
  String get eventsCount => 'Événements';

  @override
  String get interested => 'Intéressés';

  @override
  String get eventsTitle => 'Événements';

  @override
  String interestedCount(Object num) {
    return '$num intéressés';
  }

  @override
  String get aboutThisEvent => 'À propos de cet événement';

  @override
  String get showInterest => 'Manifester de l\'intérêt';

  @override
  String get viewProfile => 'Voir le profil';

  @override
  String get addEvent => 'Ajouter un événement';

  @override
  String get assocAdmin => 'Admin de l\'association';

  @override
  String get assocProfileTwo => 'Profil de l\'association';

  @override
  String get eventDetails => 'Détails de l\'événement';

  @override
  String get eventFeed => 'Fil des événements';

  @override
  String get publicAssocProfile => 'Profil public de l\'association';

  @override
  String get signup => 'S\'inscrire';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get creds => 'Identifiants';

  @override
  String get userRegs => 'Inscriptions des utilisateurs';

  @override
  String get home => 'Accueil';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get emailOrUsername => 'Email ou nom d\'utilisateur';

  @override
  String get enterEmailOrUsername => 'Entrez l\'email ou le nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get enterYourPassword => 'Entrez votre mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié?';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte?';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get or => 'ou';

  @override
  String get login => 'Connexion';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get name => 'Nom';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Téléphone';

  @override
  String get address => 'Adresse';

  @override
  String get oldPassword => 'Ancien mot de passe';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get newPasswordHint => 'Nouveau mot de passe';

  @override
  String get cancel => 'Annuler';

  @override
  String get saveUpdate => 'Enregistrer la mise à jour';

  @override
  String get upcomingEvents => 'Événements à venir';

  @override
  String get searchBarHint => 'Rechercher des événements ...';

  @override
  String errorOccurred(Object error) {
    return 'Erreur: $error';
  }

  @override
  String get filterAll => 'Tous';

  @override
  String get filterMusic => 'Musique';

  @override
  String get filterSports => 'Sports';

  @override
  String get filterArts => 'Arts';

  @override
  String get filterTech => 'Tech';

  @override
  String get oneEvent => '+1 événement';

  @override
  String get followAssociation => 'Suivre l\'association';

  @override
  String get aboutUs => 'À propos de nous';

  @override
  String get contactInformation => 'Informations de contact';

  @override
  String get pastEvents => 'Événements passés';

  @override
  String get profile => 'Profil';

  @override
  String get myAccount => 'Mon Compte';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Paramètres';

  @override
  String get helpCenter => 'Centre d\'aide';

  @override
  String get logOut => 'Se Déconnecter';

  @override
  String get createNewAccount => 'Créer un nouveau compte';

  @override
  String get fullName => 'Nom complet';

  @override
  String get fullNameHint => 'Entrez votre nom complet';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get emailAddressHint => 'Entrez votre adresse e-mail';

  @override
  String get passwordHint => 'Entrez votre mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordHint => 'Confirmez votre mot de passe';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte?';

  @override
  String get logIn => 'Se connecter';

  @override
  String get byCreatingAccount => 'En créant un compte, vous acceptez nos';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get and => 'et';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';
}
