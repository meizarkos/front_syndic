class AppText {
  /* General API */
  static const String apiErrorText = 'Une erreur est survenue';
  static const String apiNoResult = 'Pas de résultat';

  /*General*/
  static const String commentary = 'Commentaire';
  static const String contact = 'Contact';
  static const String save = 'Enregister';
  static const String minute = 'Minute';
  static const String hour = 'Heure';
  static const String modify = 'Modifier';
  static const String delete = 'Supprimer';
  static const String cancel = 'Annuler';
  static const String confirm = 'Confirmer';
  static const String refuse = 'Refuser';
  static const String at = 'à';
  static const String le = 'Le';
  static const String for_ = 'Pour : ';
  static const String to = 'Au';
  static const String from = 'du';
  static const String one = 'Un';

  /* General not found */
  static const String noCategoryFound = 'Pas de catégorie';
  static const String noDescriptionWorkRequest = 'Pas de description';
  static const String noDate = 'Pas de date';
  static const String noPhone = 'Pas de numéro de téléphone trouvée';

  /* LoginStrings */
  static const String loginTitle = 'Connexion';
  static const String loginConnectionButtonText = 'Se connecter';
  static const String loginLinkToRegister = 'Pas encore de compte ? Inscrivez-vous';
  static const String loginLabelTextEmail = 'Email';
  static const String loginLabelTextPassword = 'Mot de passe';
  static const String loginErrorText = 'Mauvais identifiants';

  /* UnionMainStrings */
  static const String noStringNameForCowner = 'Nom introuvable';
  static const String noStringNameForCownerSubtitle = 'Adresse inconnu';
  static const String unionMainSearchBarEmpty = 'Rechercher';
  static const String unionMainAddButton = 'Ajouter';

  /* CoOwnerMain */
  static const String conversation = 'Conversations';
  static const String buttonSeeInvoice = 'Voir mes factures';
  static const String buttonCreateARequest = 'Créer une demande';

  static const String titleMeeting = 'Mon prochain devis';
  static const String titleNextMeeting = 'Passage pour un devis le :';
  static const String seeEstimate = 'Voir mes rendez-vous';
  static const String noTimingFound = 'Pas de rendez-vous fixé';

  static const String titleNextWorkMeeting = 'Mes prochains travaux';
  static const String titleTimingEstimate = 'Passage pour les travaux le :';
  static const String buttonTextWorkMeeting = 'Voir mes dates de travaux';

  static const String titleNextWork = 'Mes demandes';
  static const String noDateForWork = 'Pas de date fixée';
  static const String noTitleForWork = 'Pas de titre';
  static const String buttonTextWorkRequest = 'Voir mes demandes';
  static const String preTextWorkRequest = 'Devis pour le : ';

  static const String titleNexEstimate = 'Mes devis';
  static const String buttonTextEstimate = 'Voir mes devis';
  static const String subtitleEstimate = 'Travaux prévus pour le : ';

  /* WorkRequest */
  static const String workRequestsPending = 'En attente';
  static const String workRequestsHistory = 'Historique';

  /* takePictureWorkRequest */
  static const String takePictureSkip = 'Passer cette étape';
  static const String takePictureSave = 'Continuer';
  static const String takePictureEraseAll = 'Tout effacer';
  static const String takePictureApprove = 'Enregistrer cette photo ?';

  /* createWorkRequest */
  static const String title = 'Titre';
  static const String description = 'Description';
  static const String category = 'Catégorie';
  static const String yourDisposition = 'Vos disponibilitées';
  static const String descriptionPlaceHolder = 'Décrivez votre demande';
  static const String titlePlaceHolder = 'Titre de votre demande';
  static const String createTitleWorkErrorText = 'Veuillez remplir tous les champs';
  static const String createCategoryTitle = 'Choisissez une catégorie';
  static const List<String> listOfTaskCategory = ['Plomberie', 'Electricité', 'Peinture', 'Sol', 'Menuiserie'];
  static const List<String> listOfTaskCategoryWithNull = [
    ...listOfTaskCategory,
    'Pas de categorie'
  ];
  static const String createWorkRequestCategoryIsEmpty = 'Veuillez choisir une catégorie';
  static const String createWorkRequestTimingWrong = 'Veuillez choisir une date de disponibilité';
  static const String createWorkRequestTiming = 'Sélectionner le';
  static const String createWorkRequestInterventionDate = 'Date d\'intervention';
  static const String createWorkRequestRecap = 'Récapitulatif';
  static const String createWorkRequestConfirm = 'Confirmer cette demande';

  /* Recap */
  static const String recapError = 'Tous les champs sont obligatoieres';
  static const String recapGoToMeeting = 'Modifier mes disponibilitées';
  static const String recapSuccessModifying = 'Votre demande a bien été modifiée';
  static const String recapDialogDelete = "Confirmer la supression vous fera perdre toutes les données liées à l'affaire en cours, devis, rendez-vous et autres seront annulés/supprimés";
  static const String recapDialogTitle = 'Confirmer la supression';

  /* WorRequestArtisanSide */
  static const String workRequestArtisanSideInterventionOf = 'Intervention de type : ';
  static const String workRequestArtisanSideFilterBy = 'Filtrer par : ';
  static const String workRequestArtisanSideSendFirstMessage = 'Contacter';
  static const String workRequestArtisanSideDisponibility = 'Disponibilitées';

  /* WorkRequestMessage */
  static const String workRequestMessageHint = 'Type your message...';
  static const String workRequestNoMessage = 'No message';
  static const String createAMeeting = 'Créez un rendez-vous';
  static const String createAMeetingTime = 'Choisir une heure';
  static const String createAMeetingMessage = 'Rendez-vous créer pour le';
  static const String createAMeetingError = 'Veuillez choisir une date et une heure';

  /* Conversation */
  static const String messageNoMessage = 'Pas de message';
  static const String titleCouncilMessage = 'Vos messages';
  static const String seeWorkRequest = 'Voir la demande';
  static const String seeMeeting = 'Voir le rendez-vous';

  /* Timing */
  static const String timing = 'Rendez-vous';
  static const String timingListTitle = 'Vos rendez-vous';
  static const String create = 'a été fixé :';
  static const String meetingEstimateText = 'Rencontrez vous pour faire un devis le';
  static const String interventionPlace = 'Lieu de l\'intervention :';
  static const String phoneContact = 'Votre numéro de contact est :';
  static const String contactUs = "pour plus d'informations";
  static const String contactez = 'Contactez';
  static const String contactUnion = "Si vous n'êtes pas à l'origine de cette demande adressez vous à votre conseil syndical :";

  /* Timing Detail */
  static const String seeConv = 'Message';
  static const String seeEstimateDetail = 'Voir le devis';

  /* Estimate */
  static const String createEstimate = 'Créer un devis';
  static const String createEstimatePrice = 'Prix';
  static const String createEstimatePricePlaceHolder = 'Prix de votre devis';
  static const String noCommentary = 'Pas de commentaire';
  static const String createEstimateCommentaryPlaceHolder = 'Commentaire sur le devis';
  static const String descEstimate = 'Description des travaux';
  static const String descEstimatePlaceHolder = 'Description de vos travaux';
  static const String estimate = 'Devis';
  static const String noPriceEstimate = 'Pas de prix trouvée';
  static const String euro = '€';
  static const String estimateDetailTitle = 'Détail du devis';
  static const String noDescriptionEstimate = 'Pas de description pour ce devis';

  /* Timing Estimate */
  static const String timingEstimate = 'Date travaux';
  static const String timingEstimateListTitle = 'Proposition de travaux du';

  /* In Progress */
  static const String inProgress = 'Affaire en cours';
  static const List<String> inProgressListCouncil = [
    conversation,
    timing,
    estimate,
    timingEstimate
  ];
}