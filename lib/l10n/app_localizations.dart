import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh')
  ];

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @alertRow1Sub.
  ///
  /// In en, this message translates to:
  /// **'Due Nov 30'**
  String get alertRow1Sub;

  /// No description provided for @alertRow1Title.
  ///
  /// In en, this message translates to:
  /// **'Missing Scope 3 data — supplier A'**
  String get alertRow1Title;

  /// No description provided for @alertRow2Sub.
  ///
  /// In en, this message translates to:
  /// **'Review in Q1'**
  String get alertRow2Sub;

  /// No description provided for @alertRow2Title.
  ///
  /// In en, this message translates to:
  /// **'EU taxonomy update'**
  String get alertRow2Title;

  /// No description provided for @alertsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsSectionTitle;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Verdai'**
  String get appTitle;

  /// No description provided for @authBulletCompanies.
  ///
  /// In en, this message translates to:
  /// **'340+ companies already trust Verdai'**
  String get authBulletCompanies;

  /// No description provided for @authBulletGdpr.
  ///
  /// In en, this message translates to:
  /// **'GDPR compliant'**
  String get authBulletGdpr;

  /// No description provided for @authBulletSetup.
  ///
  /// In en, this message translates to:
  /// **'Set up in 5 minutes'**
  String get authBulletSetup;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @badgeCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get badgeCritical;

  /// No description provided for @badgeWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get badgeWarning;

  /// No description provided for @billing.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billing;

  /// No description provided for @billingCancelSub.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get billingCancelSub;

  /// No description provided for @billingCardMask.
  ///
  /// In en, this message translates to:
  /// **'Card •••• 4242 • exp 12/28'**
  String get billingCardMask;

  /// No description provided for @billingCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current plan'**
  String get billingCurrent;

  /// No description provided for @billingDanger.
  ///
  /// In en, this message translates to:
  /// **'Danger zone'**
  String get billingDanger;

  /// No description provided for @billingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get billingInvoices;

  /// No description provided for @billingManagePortal.
  ///
  /// In en, this message translates to:
  /// **'Manage plan (Customer Portal)'**
  String get billingManagePortal;

  /// No description provided for @billingPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get billingPayment;

  /// No description provided for @billingRenewExample.
  ///
  /// In en, this message translates to:
  /// **'Growth • renews 12/12/2026'**
  String get billingRenewExample;

  /// No description provided for @billingTitle.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billingTitle;

  /// No description provided for @billingUpdateCard.
  ///
  /// In en, this message translates to:
  /// **'Update method'**
  String get billingUpdateCard;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'Verdai'**
  String get brandName;

  /// No description provided for @catEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get catEnergy;

  /// No description provided for @catEnergyOpt.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get catEnergyOpt;

  /// No description provided for @catGas.
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get catGas;

  /// No description provided for @catOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// No description provided for @catSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get catSuppliers;

  /// No description provided for @catSuppliersOpt.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get catSuppliersOpt;

  /// No description provided for @catTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get catTransport;

  /// No description provided for @catTransportOpt.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get catTransportOpt;

  /// No description provided for @catWaste.
  ///
  /// In en, this message translates to:
  /// **'Waste'**
  String get catWaste;

  /// No description provided for @catWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get catWater;

  /// No description provided for @chartModeMonth.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get chartModeMonth;

  /// No description provided for @chartModeQuarter.
  ///
  /// In en, this message translates to:
  /// **'Q'**
  String get chartModeQuarter;

  /// No description provided for @chartModeYear.
  ///
  /// In en, this message translates to:
  /// **'Y'**
  String get chartModeYear;

  /// No description provided for @colColumnA.
  ///
  /// In en, this message translates to:
  /// **'Column A'**
  String get colColumnA;

  /// No description provided for @colColumnB.
  ///
  /// In en, this message translates to:
  /// **'Column B'**
  String get colColumnB;

  /// No description provided for @compAlert1Sub.
  ///
  /// In en, this message translates to:
  /// **'Validate data scope'**
  String get compAlert1Sub;

  /// No description provided for @compAlert1Title.
  ///
  /// In en, this message translates to:
  /// **'CSRD reporting'**
  String get compAlert1Title;

  /// No description provided for @compAlert2Sub.
  ///
  /// In en, this message translates to:
  /// **'Supplier deadline'**
  String get compAlert2Sub;

  /// No description provided for @compAlert2Title.
  ///
  /// In en, this message translates to:
  /// **'CDP questionnaire'**
  String get compAlert2Title;

  /// No description provided for @companyProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Company profile'**
  String get companyProfileTitle;

  /// No description provided for @complianceCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get complianceCardTitle;

  /// No description provided for @complianceCsrdProgress.
  ///
  /// In en, this message translates to:
  /// **'CSRD: in progress'**
  String get complianceCsrdProgress;

  /// No description provided for @complianceDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline: Dec 2025'**
  String get complianceDeadline;

  /// No description provided for @complianceTitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get complianceTitle;

  /// No description provided for @countryDE.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryDE;

  /// No description provided for @countryFR.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFR;

  /// No description provided for @countryIT.
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get countryIT;

  /// No description provided for @dashAlerts.
  ///
  /// In en, this message translates to:
  /// **'Compliance alerts'**
  String get dashAlerts;

  /// No description provided for @dashBreadcrumb.
  ///
  /// In en, this message translates to:
  /// **'home / overview'**
  String get dashBreadcrumb;

  /// No description provided for @dashBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get dashBreakdownTitle;

  /// No description provided for @dashCo2Delta.
  ///
  /// In en, this message translates to:
  /// **'-12% vs 2022'**
  String get dashCo2Delta;

  /// No description provided for @dashCo2Title.
  ///
  /// In en, this message translates to:
  /// **'Total CO₂'**
  String get dashCo2Title;

  /// No description provided for @dashCo2TonsFmt.
  ///
  /// In en, this message translates to:
  /// **'{value} t'**
  String dashCo2TonsFmt(Object value);

  /// No description provided for @dashEsgCardTitle.
  ///
  /// In en, this message translates to:
  /// **'ESG score'**
  String get dashEsgCardTitle;

  /// No description provided for @dashEsgDelta.
  ///
  /// In en, this message translates to:
  /// **'+5 vs last year'**
  String get dashEsgDelta;

  /// No description provided for @dashLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Could not load dashboard'**
  String get dashLoadingError;

  /// No description provided for @dashRecentReports.
  ///
  /// In en, this message translates to:
  /// **'Latest reports'**
  String get dashRecentReports;

  /// No description provided for @dashReportsLeft.
  ///
  /// In en, this message translates to:
  /// **'{n} left on plan'**
  String dashReportsLeft(Object n);

  /// No description provided for @dashReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports generated'**
  String get dashReportsTitle;

  /// No description provided for @dashSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get dashSeeAll;

  /// No description provided for @dashSeeAllArrow.
  ///
  /// In en, this message translates to:
  /// **'See all →'**
  String get dashSeeAllArrow;

  /// No description provided for @dashTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashTitle;

  /// No description provided for @demoCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Demo SpA'**
  String get demoCompanyName;

  /// No description provided for @dialogCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription?'**
  String get dialogCancelTitle;

  /// No description provided for @dialogRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent (demo).'**
  String get dialogRequestSent;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dropExcelPick.
  ///
  /// In en, this message translates to:
  /// **'or choose a file'**
  String get dropExcelPick;

  /// No description provided for @dropExcelTitle.
  ///
  /// In en, this message translates to:
  /// **'Drop your Excel file here'**
  String get dropExcelTitle;

  /// No description provided for @emissionsChartTitle.
  ///
  /// In en, this message translates to:
  /// **'CO₂ emissions'**
  String get emissionsChartTitle;

  /// No description provided for @emissionsUploadTitle.
  ///
  /// In en, this message translates to:
  /// **'Data & emissions'**
  String get emissionsUploadTitle;

  /// No description provided for @errConfigureSupabase.
  ///
  /// In en, this message translates to:
  /// **'Configure Supabase.'**
  String get errConfigureSupabase;

  /// No description provided for @errLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign‑in failed. Check your credentials.'**
  String get errLoginFailed;

  /// No description provided for @errOAuth.
  ///
  /// In en, this message translates to:
  /// **'OAuth requires a configured Supabase project.'**
  String get errOAuth;

  /// No description provided for @errRegisterFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Try again.'**
  String get errRegisterFailed;

  /// No description provided for @errSupabaseLogin.
  ///
  /// In en, this message translates to:
  /// **'Configure Supabase with --dart-define to sign in.'**
  String get errSupabaseLogin;

  /// No description provided for @errSupabaseRegister.
  ///
  /// In en, this message translates to:
  /// **'Configure Supabase with --dart-define.'**
  String get errSupabaseRegister;

  /// No description provided for @errTerms.
  ///
  /// In en, this message translates to:
  /// **'Accept the Terms and Privacy Policy to continue.'**
  String get errTerms;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'No. Verdai is 100% web and mobile.'**
  String get faqA1;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'GDPR‑aligned design, EU hosting options, encryption at rest with your cloud provider.'**
  String get faqA2;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'Yes — upload Excel or enter data manually.'**
  String get faqA3;

  /// No description provided for @faqA4.
  ///
  /// In en, this message translates to:
  /// **'Yes, no lock‑in: cancel in one click from the portal.'**
  String get faqA4;

  /// No description provided for @faqA5.
  ///
  /// In en, this message translates to:
  /// **'After Omnibus I (Directive (EU) 2026/470), mandatory CSRD reporting applies only to companies with more than 1,000 employees and more than €450M net turnover, from financial years starting on 1 January 2027. Most SMEs are out of legal scope. The urgent work is answering buyers and banks in VSME. This is not legal advice.'**
  String get faqA5;

  /// No description provided for @faqA6.
  ///
  /// In en, this message translates to:
  /// **'In‑app chat, email, and onboarding calls included from Growth.'**
  String get faqA6;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'Do I need to install anything?'**
  String get faqQ1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'Is my data secure?'**
  String get faqQ2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'Does it work without an ERP?'**
  String get faqQ3;

  /// No description provided for @faqQ4.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel anytime?'**
  String get faqQ4;

  /// No description provided for @faqQ5.
  ///
  /// In en, this message translates to:
  /// **'Does CSRD still apply to my company?'**
  String get faqQ5;

  /// No description provided for @faqQ6.
  ///
  /// In en, this message translates to:
  /// **'Do you offer support?'**
  String get faqQ6;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @featuresHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'From CO₂ measurement to signed reports'**
  String get featuresHeroTitle;

  /// No description provided for @featuresPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'From measurement to compliance'**
  String get featuresPageSubtitle;

  /// No description provided for @fieldKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get fieldKm;

  /// No description provided for @fieldKwh.
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get fieldKwh;

  /// No description provided for @fieldLegalName.
  ///
  /// In en, this message translates to:
  /// **'Legal name'**
  String get fieldLegalName;

  /// No description provided for @fieldLitersDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel litres'**
  String get fieldLitersDiesel;

  /// No description provided for @fieldReportLang.
  ///
  /// In en, this message translates to:
  /// **'Report language'**
  String get fieldReportLang;

  /// No description provided for @fieldStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get fieldStandard;

  /// No description provided for @fieldVat.
  ///
  /// In en, this message translates to:
  /// **'VAT ID'**
  String get fieldVat;

  /// No description provided for @fieldWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get fieldWebsite;

  /// No description provided for @fieldYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get fieldYear;

  /// No description provided for @finalCtaButton.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get finalCtaButton;

  /// No description provided for @finalCtaSub.
  ///
  /// In en, this message translates to:
  /// **'14 days free, no credit card.'**
  String get finalCtaSub;

  /// No description provided for @finalCtaTitle.
  ///
  /// In en, this message translates to:
  /// **'Start today. Buyer questionnaires won’t wait.'**
  String get finalCtaTitle;

  /// No description provided for @finalCtaTrust.
  ///
  /// In en, this message translates to:
  /// **'SSL • GDPR • EU hosting • Cancel anytime'**
  String get finalCtaTrust;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} Verdai. All rights reserved.'**
  String footerCopyright(Object year);

  /// No description provided for @footerFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get footerFeatures;

  /// No description provided for @footerLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get footerLogin;

  /// No description provided for @footerPricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get footerPricing;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'ESG compliance in 5 minutes. Not in 5 months.'**
  String get footerTagline;

  /// No description provided for @forgotBack.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get forgotBack;

  /// No description provided for @forgotMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your email for the reset link.'**
  String get forgotMessage;

  /// No description provided for @forgotSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get forgotSubmit;

  /// No description provided for @forgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotTitle;

  /// No description provided for @forward.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get forward;

  /// No description provided for @genStepCalc.
  ///
  /// In en, this message translates to:
  /// **'Calculating emissions…'**
  String get genStepCalc;

  /// No description provided for @genStepCollect.
  ///
  /// In en, this message translates to:
  /// **'Collecting data…'**
  String get genStepCollect;

  /// No description provided for @genStepCompliance.
  ///
  /// In en, this message translates to:
  /// **'Checking compliance…'**
  String get genStepCompliance;

  /// No description provided for @genStepDone.
  ///
  /// In en, this message translates to:
  /// **'Report ready'**
  String get genStepDone;

  /// No description provided for @genStepPdf.
  ///
  /// In en, this message translates to:
  /// **'Building PDF…'**
  String get genStepPdf;

  /// No description provided for @heroBadgeCsrd.
  ///
  /// In en, this message translates to:
  /// **'VSME — the SME standard after Omnibus'**
  String get heroBadgeCsrd;

  /// No description provided for @heroCtaDemo.
  ///
  /// In en, this message translates to:
  /// **'Watch demo →'**
  String get heroCtaDemo;

  /// No description provided for @heroCtaFree.
  ///
  /// In en, this message translates to:
  /// **'Start free — 14 days'**
  String get heroCtaFree;

  /// No description provided for @heroEsgScore.
  ///
  /// In en, this message translates to:
  /// **'ESG score'**
  String get heroEsgScore;

  /// No description provided for @heroHeadline.
  ///
  /// In en, this message translates to:
  /// **'ESG data for your buyers.\nIn 5 minutes.\nNot in 5 months.'**
  String get heroHeadline;

  /// No description provided for @heroScope1.
  ///
  /// In en, this message translates to:
  /// **'Scope 1 ✓'**
  String get heroScope1;

  /// No description provided for @heroScope2.
  ///
  /// In en, this message translates to:
  /// **'Scope 2 ✓'**
  String get heroScope2;

  /// No description provided for @heroScopeCsrd.
  ///
  /// In en, this message translates to:
  /// **'VSME ✓'**
  String get heroScopeCsrd;

  /// No description provided for @heroScore.
  ///
  /// In en, this message translates to:
  /// **'{current} / {max}'**
  String heroScore(Object current, Object max);

  /// No description provided for @heroSocialProof.
  ///
  /// In en, this message translates to:
  /// **'Already used by 340+ European SMEs'**
  String get heroSocialProof;

  /// No description provided for @heroSub.
  ///
  /// In en, this message translates to:
  /// **'Verdai calculates your CO₂ footprint and produces a VSME report you can send to customers, banks and investors — even if CSRD no longer applies to you.'**
  String get heroSub;

  /// No description provided for @hintLegalDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo SpA'**
  String get hintLegalDemo;

  /// No description provided for @hintVatDemo.
  ///
  /// In en, this message translates to:
  /// **'IT00000000000'**
  String get hintVatDemo;

  /// No description provided for @hintWebsite.
  ///
  /// In en, this message translates to:
  /// **'https://'**
  String get hintWebsite;

  /// No description provided for @integConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get integConnect;

  /// No description provided for @integGenApiKey.
  ///
  /// In en, this message translates to:
  /// **'Generate API key'**
  String get integGenApiKey;

  /// No description provided for @integNameApi.
  ///
  /// In en, this message translates to:
  /// **'Custom API'**
  String get integNameApi;

  /// No description provided for @integNameExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel'**
  String get integNameExcel;

  /// No description provided for @integNameFic.
  ///
  /// In en, this message translates to:
  /// **'Cloud invoicing'**
  String get integNameFic;

  /// No description provided for @integNameQuickbooks.
  ///
  /// In en, this message translates to:
  /// **'QuickBooks'**
  String get integNameQuickbooks;

  /// No description provided for @integNameSap.
  ///
  /// In en, this message translates to:
  /// **'SAP'**
  String get integNameSap;

  /// No description provided for @integNameSheets.
  ///
  /// In en, this message translates to:
  /// **'Google Sheets'**
  String get integNameSheets;

  /// No description provided for @integOAuth.
  ///
  /// In en, this message translates to:
  /// **'OAuth'**
  String get integOAuth;

  /// No description provided for @integStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get integStatusAvailable;

  /// No description provided for @integStatusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected ✓'**
  String get integStatusConnected;

  /// No description provided for @integStatusSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get integStatusSoon;

  /// No description provided for @integrationsOpenDetail.
  ///
  /// In en, this message translates to:
  /// **'Open Integrations from the menu for details.'**
  String get integrationsOpenDetail;

  /// No description provided for @integrationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integrationsTitle;

  /// No description provided for @invoiceExample.
  ///
  /// In en, this message translates to:
  /// **'€299 • 01/03/2026'**
  String get invoiceExample;

  /// No description provided for @labelCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get labelCompany;

  /// No description provided for @labelField.
  ///
  /// In en, this message translates to:
  /// **'Field'**
  String get labelField;

  /// No description provided for @landingFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get landingFeatures;

  /// No description provided for @landingNavHowItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get landingNavHowItWorks;

  /// No description provided for @landingLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get landingLogin;

  /// No description provided for @landingPricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get landingPricing;

  /// No description provided for @landingTryFree.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get landingTryFree;

  /// No description provided for @langName_ar.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get langName_ar;

  /// No description provided for @langName_de.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get langName_de;

  /// No description provided for @langName_el.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get langName_el;

  /// No description provided for @langName_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langName_en;

  /// No description provided for @langName_es.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get langName_es;

  /// No description provided for @langName_fa.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get langName_fa;

  /// No description provided for @langName_fr.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get langName_fr;

  /// No description provided for @langName_he.
  ///
  /// In en, this message translates to:
  /// **'Hebrew'**
  String get langName_he;

  /// No description provided for @langName_hi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get langName_hi;

  /// No description provided for @langName_it.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get langName_it;

  /// No description provided for @langName_ja.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get langName_ja;

  /// No description provided for @langName_ko.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get langName_ko;

  /// No description provided for @langName_nl.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get langName_nl;

  /// No description provided for @langName_pl.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get langName_pl;

  /// No description provided for @langName_pt.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get langName_pt;

  /// No description provided for @langName_ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get langName_ru;

  /// No description provided for @langName_sv.
  ///
  /// In en, this message translates to:
  /// **'Swedish'**
  String get langName_sv;

  /// No description provided for @langName_tr.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get langName_tr;

  /// No description provided for @langName_uk.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get langName_uk;

  /// No description provided for @langName_zh.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get langName_zh;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @loginEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmail;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'name@company.com'**
  String get loginEmailHint;

  /// No description provided for @loginForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgot;

  /// No description provided for @loginGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginGoogle;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account?'**
  String get loginNoAccount;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPassword;

  /// No description provided for @loginRegisterCta.
  ///
  /// In en, this message translates to:
  /// **'Sign up free →'**
  String get loginRegisterCta;

  /// No description provided for @loginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginSubmit;

  /// No description provided for @loginSubmitLoading.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get loginSubmitLoading;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Verdai'**
  String get loginTitle;

  /// No description provided for @manualAdd.
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get manualAdd;

  /// No description provided for @manualCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get manualCategory;

  /// No description provided for @manualDieselL.
  ///
  /// In en, this message translates to:
  /// **'Diesel litres'**
  String get manualDieselL;

  /// No description provided for @manualFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual entry'**
  String get manualFullTitle;

  /// No description provided for @manualKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get manualKm;

  /// No description provided for @manualKwh.
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get manualKwh;

  /// No description provided for @manualRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get manualRecords;

  /// No description provided for @manualTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual entry'**
  String get manualTitle;

  /// No description provided for @mappingColExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel column'**
  String get mappingColExcel;

  /// No description provided for @mappingColVerdant.
  ///
  /// In en, this message translates to:
  /// **'Verdai field'**
  String get mappingColVerdant;

  /// No description provided for @mappingImport.
  ///
  /// In en, this message translates to:
  /// **'Import & calculate CO₂'**
  String get mappingImport;

  /// No description provided for @mappingTitle.
  ///
  /// In en, this message translates to:
  /// **'Column mapping'**
  String get mappingTitle;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @navCompliance.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get navCompliance;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navEmissions.
  ///
  /// In en, this message translates to:
  /// **'Data & emissions'**
  String get navEmissions;

  /// No description provided for @navIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get navIntegrations;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'ESG reports'**
  String get navReports;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navShortCompliance.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get navShortCompliance;

  /// No description provided for @navShortDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navShortDashboard;

  /// No description provided for @navShortData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get navShortData;

  /// No description provided for @navShortIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get navShortIntegrations;

  /// No description provided for @navShortReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navShortReports;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @onbAddress.
  ///
  /// In en, this message translates to:
  /// **'Headquarters'**
  String get onbAddress;

  /// No description provided for @onbCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get onbCountry;

  /// No description provided for @onbDataHint.
  ///
  /// In en, this message translates to:
  /// **'You can add details later from emissions.'**
  String get onbDataHint;

  /// No description provided for @onbDataTitle.
  ///
  /// In en, this message translates to:
  /// **'First data points'**
  String get onbDataTitle;

  /// No description provided for @onbDemoNote.
  ///
  /// In en, this message translates to:
  /// **'Demo: no real registry API call in this build.'**
  String get onbDemoNote;

  /// No description provided for @onbEmployees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get onbEmployees;

  /// No description provided for @onbEnergy2023.
  ///
  /// In en, this message translates to:
  /// **'Energy use 2023 (kWh)'**
  String get onbEnergy2023;

  /// No description provided for @onbFleetKm2023.
  ///
  /// In en, this message translates to:
  /// **'Fleet km 2023'**
  String get onbFleetKm2023;

  /// No description provided for @onbLegalName.
  ///
  /// In en, this message translates to:
  /// **'Legal name'**
  String get onbLegalName;

  /// No description provided for @onbPlanPaid.
  ///
  /// In en, this message translates to:
  /// **'Go to Stripe checkout'**
  String get onbPlanPaid;

  /// No description provided for @onbPlanSub.
  ///
  /// In en, this message translates to:
  /// **'Or start 14 days free on Growth.'**
  String get onbPlanSub;

  /// No description provided for @onbPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a plan'**
  String get onbPlanTitle;

  /// No description provided for @onbPlanTrial.
  ///
  /// In en, this message translates to:
  /// **'Growth trial (demo)'**
  String get onbPlanTrial;

  /// No description provided for @onbSectorConstruction.
  ///
  /// In en, this message translates to:
  /// **'Construction'**
  String get onbSectorConstruction;

  /// No description provided for @onbSectorEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get onbSectorEnergy;

  /// No description provided for @onbSectorFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get onbSectorFood;

  /// No description provided for @onbSectorLogistics.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get onbSectorLogistics;

  /// No description provided for @onbSectorManufacturing.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing'**
  String get onbSectorManufacturing;

  /// No description provided for @onbSectorOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get onbSectorOther;

  /// No description provided for @onbSectorRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail'**
  String get onbSectorRetail;

  /// No description provided for @onbSectorServices.
  ///
  /// In en, this message translates to:
  /// **'Professional services'**
  String get onbSectorServices;

  /// No description provided for @onbSectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Your sector'**
  String get onbSectorTitle;

  /// No description provided for @onbStandardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Which standards apply?'**
  String get onbStandardsTitle;

  /// No description provided for @onbVat.
  ///
  /// In en, this message translates to:
  /// **'VAT ID'**
  String get onbVat;

  /// No description provided for @onbVatHint.
  ///
  /// In en, this message translates to:
  /// **'IT01234567890'**
  String get onbVatHint;

  /// No description provided for @onbWelcomeSub.
  ///
  /// In en, this message translates to:
  /// **'Let’s set up your company in 2 minutes.'**
  String get onbWelcomeSub;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Verdai 👋'**
  String get onbWelcomeTitle;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingFinish.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get onboardingFinish;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Onboarding • {step}/5'**
  String onboardingTitle(Object step);

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @pdfBulletCo2.
  ///
  /// In en, this message translates to:
  /// **'Total emissions estimate: {tons} t CO₂e'**
  String pdfBulletCo2(Object tons);

  /// No description provided for @pdfBulletScore.
  ///
  /// In en, this message translates to:
  /// **'Overall ESG score: {score}/100'**
  String pdfBulletScore(Object score);

  /// No description provided for @pdfCompany.
  ///
  /// In en, this message translates to:
  /// **'Company: {name}'**
  String pdfCompany(Object name);

  /// No description provided for @pdfCoverTitle.
  ///
  /// In en, this message translates to:
  /// **'ESG report — {standard}'**
  String pdfCoverTitle(Object standard);

  /// No description provided for @pdfExecSummary.
  ///
  /// In en, this message translates to:
  /// **'Executive summary'**
  String get pdfExecSummary;

  /// No description provided for @pdfFooter.
  ///
  /// In en, this message translates to:
  /// **'Generated with Verdai ESG Platform • {date}'**
  String pdfFooter(Object date);

  /// No description provided for @pdfScopeColScope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get pdfScopeColScope;

  /// No description provided for @pdfScopeColTons.
  ///
  /// In en, this message translates to:
  /// **'t CO₂e'**
  String get pdfScopeColTons;

  /// No description provided for @pdfScopeDash.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get pdfScopeDash;

  /// No description provided for @pdfScopeTableTitle.
  ///
  /// In en, this message translates to:
  /// **'Emissions by scope'**
  String get pdfScopeTableTitle;

  /// No description provided for @pdfYear.
  ///
  /// In en, this message translates to:
  /// **'Year: {year}'**
  String pdfYear(Object year);

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// No description provided for @perMonthAnnual.
  ///
  /// In en, this message translates to:
  /// **'/month (billed annually)'**
  String get perMonthAnnual;

  /// No description provided for @planBadgePartner.
  ///
  /// In en, this message translates to:
  /// **'For consultants & firms'**
  String get planBadgePartner;

  /// No description provided for @planBadgePopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get planBadgePopular;

  /// No description provided for @planCtaContactSales.
  ///
  /// In en, this message translates to:
  /// **'Contact sales'**
  String get planCtaContactSales;

  /// No description provided for @planCtaStartTrial.
  ///
  /// In en, this message translates to:
  /// **'Start 14‑day free trial'**
  String get planCtaStartTrial;

  /// No description provided for @planGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get planGrowth;

  /// No description provided for @planGrowthF1.
  ///
  /// In en, this message translates to:
  /// **'✓ Everything in Starter'**
  String get planGrowthF1;

  /// No description provided for @planGrowthF10.
  ///
  /// In en, this message translates to:
  /// **'✗ White label'**
  String get planGrowthF10;

  /// No description provided for @planGrowthF2.
  ///
  /// In en, this message translates to:
  /// **'✓ Multi‑site (up to 5)'**
  String get planGrowthF2;

  /// No description provided for @planGrowthF3.
  ///
  /// In en, this message translates to:
  /// **'✓ Scope 3 supply chain'**
  String get planGrowthF3;

  /// No description provided for @planGrowthF4.
  ///
  /// In en, this message translates to:
  /// **'✓ Unlimited reports'**
  String get planGrowthF4;

  /// No description provided for @planGrowthF5.
  ///
  /// In en, this message translates to:
  /// **'✓ CSRD + ISSB + CDP'**
  String get planGrowthF5;

  /// No description provided for @planGrowthF6.
  ///
  /// In en, this message translates to:
  /// **'✓ Automatic regulatory alerts'**
  String get planGrowthF6;

  /// No description provided for @planGrowthF7.
  ///
  /// In en, this message translates to:
  /// **'✓ Advanced Excel integration'**
  String get planGrowthF7;

  /// No description provided for @planGrowthF8.
  ///
  /// In en, this message translates to:
  /// **'✓ Sector benchmark dashboard'**
  String get planGrowthF8;

  /// No description provided for @planGrowthF9.
  ///
  /// In en, this message translates to:
  /// **'✗ API access'**
  String get planGrowthF9;

  /// No description provided for @planPartner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get planPartner;

  /// No description provided for @planPartnerF1.
  ///
  /// In en, this message translates to:
  /// **'✓ Everything in Growth'**
  String get planPartnerF1;

  /// No description provided for @planPartnerF2.
  ///
  /// In en, this message translates to:
  /// **'✓ Unlimited clients'**
  String get planPartnerF2;

  /// No description provided for @planPartnerF3.
  ///
  /// In en, this message translates to:
  /// **'✓ Full API access'**
  String get planPartnerF3;

  /// No description provided for @planPartnerF4.
  ///
  /// In en, this message translates to:
  /// **'✓ White label & branding'**
  String get planPartnerF4;

  /// No description provided for @planPartnerF5.
  ///
  /// In en, this message translates to:
  /// **'✓ Dedicated onboarding'**
  String get planPartnerF5;

  /// No description provided for @planPartnerF6.
  ///
  /// In en, this message translates to:
  /// **'✓ Personal account manager'**
  String get planPartnerF6;

  /// No description provided for @planPartnerF7.
  ///
  /// In en, this message translates to:
  /// **'✓ 99.9% SLA uptime'**
  String get planPartnerF7;

  /// No description provided for @planPartnerF8.
  ///
  /// In en, this message translates to:
  /// **'✓ Co‑branded reports'**
  String get planPartnerF8;

  /// No description provided for @planStarter.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get planStarter;

  /// No description provided for @planStarterF1.
  ///
  /// In en, this message translates to:
  /// **'✓ 1 company site'**
  String get planStarterF1;

  /// No description provided for @planStarterF2.
  ///
  /// In en, this message translates to:
  /// **'✓ CO₂ Scope 1 & 2'**
  String get planStarterF2;

  /// No description provided for @planStarterF3.
  ///
  /// In en, this message translates to:
  /// **'✓ 3 ESG reports/year'**
  String get planStarterF3;

  /// No description provided for @planStarterF4.
  ///
  /// In en, this message translates to:
  /// **'✓ Basic CSRD templates'**
  String get planStarterF4;

  /// No description provided for @planStarterF5.
  ///
  /// In en, this message translates to:
  /// **'✓ PDF export'**
  String get planStarterF5;

  /// No description provided for @planStarterF6.
  ///
  /// In en, this message translates to:
  /// **'✗ Scope 3 (suppliers)'**
  String get planStarterF6;

  /// No description provided for @planStarterF7.
  ///
  /// In en, this message translates to:
  /// **'✗ API access'**
  String get planStarterF7;

  /// No description provided for @planStarterF8.
  ///
  /// In en, this message translates to:
  /// **'✗ Multi‑site'**
  String get planStarterF8;

  /// No description provided for @planStarterSidebar.
  ///
  /// In en, this message translates to:
  /// **'Starter plan'**
  String get planStarterSidebar;

  /// No description provided for @pricingBilling.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get pricingBilling;

  /// No description provided for @pricingEnterprise.
  ///
  /// In en, this message translates to:
  /// **'Enterprise with 1000+ employees? Contact us for custom pricing.'**
  String get pricingEnterprise;

  /// No description provided for @pricingPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricingPageTitle;

  /// No description provided for @pricingPayMc.
  ///
  /// In en, this message translates to:
  /// **'MC'**
  String get pricingPayMc;

  /// No description provided for @pricingPaySecure.
  ///
  /// In en, this message translates to:
  /// **'Secure payment via Stripe • e‑invoicing included'**
  String get pricingPaySecure;

  /// No description provided for @pricingPayStripe.
  ///
  /// In en, this message translates to:
  /// **'Stripe'**
  String get pricingPayStripe;

  /// No description provided for @pricingPayVisa.
  ///
  /// In en, this message translates to:
  /// **'VISA'**
  String get pricingPayVisa;

  /// No description provided for @pricingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a plan and scale with your company.'**
  String get pricingSubtitle;

  /// No description provided for @pricingTransparent.
  ///
  /// In en, this message translates to:
  /// **'Transparent pricing'**
  String get pricingTransparent;

  /// No description provided for @pricingBananiHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Transparent pricing. No surprises.'**
  String get pricingBananiHeroTitle;

  /// No description provided for @pricingBananiHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the right plan for your business. All plans include automatic regulatory updates and support in your language.'**
  String get pricingBananiHeroSubtitle;

  /// No description provided for @pricingBananiPlanStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'🌱 Starter'**
  String get pricingBananiPlanStarterTitle;

  /// No description provided for @pricingBananiPlanStarterDesc.
  ///
  /// In en, this message translates to:
  /// **'For companies up to 50 employees'**
  String get pricingBananiPlanStarterDesc;

  /// No description provided for @pricingBananiPlanBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'🏢 Business'**
  String get pricingBananiPlanBusinessTitle;

  /// No description provided for @pricingBananiPlanBusinessDesc.
  ///
  /// In en, this message translates to:
  /// **'For companies with 50–500 employees'**
  String get pricingBananiPlanBusinessDesc;

  /// No description provided for @pricingBananiPlanEnterpriseTitle.
  ///
  /// In en, this message translates to:
  /// **'🏭 Enterprise'**
  String get pricingBananiPlanEnterpriseTitle;

  /// No description provided for @pricingBananiPlanEnterpriseDesc.
  ///
  /// In en, this message translates to:
  /// **'For groups and holding companies'**
  String get pricingBananiPlanEnterpriseDesc;

  /// No description provided for @pricingBananiMostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get pricingBananiMostPopular;

  /// No description provided for @pricingBananiStarterF1.
  ///
  /// In en, this message translates to:
  /// **'VSME report (SME standard)'**
  String get pricingBananiStarterF1;

  /// No description provided for @pricingBananiStarterF2.
  ///
  /// In en, this message translates to:
  /// **'Basic carbon footprint calculation'**
  String get pricingBananiStarterF2;

  /// No description provided for @pricingBananiStarterF3.
  ///
  /// In en, this message translates to:
  /// **'1 report per year'**
  String get pricingBananiStarterF3;

  /// No description provided for @pricingBananiStarterF4.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get pricingBananiStarterF4;

  /// No description provided for @pricingBananiBusinessF1.
  ///
  /// In en, this message translates to:
  /// **'Full ESRS report'**
  String get pricingBananiBusinessF1;

  /// No description provided for @pricingBananiBusinessF2.
  ///
  /// In en, this message translates to:
  /// **'Scope 1, 2 & 3 calculation'**
  String get pricingBananiBusinessF2;

  /// No description provided for @pricingBananiBusinessF3.
  ///
  /// In en, this message translates to:
  /// **'Unlimited reports'**
  String get pricingBananiBusinessF3;

  /// No description provided for @pricingBananiBusinessF4.
  ///
  /// In en, this message translates to:
  /// **'Supply chain dashboard (5 suppliers)'**
  String get pricingBananiBusinessF4;

  /// No description provided for @pricingBananiBusinessF5.
  ///
  /// In en, this message translates to:
  /// **'Priority chat support'**
  String get pricingBananiBusinessF5;

  /// No description provided for @pricingBananiBusinessF6.
  ///
  /// In en, this message translates to:
  /// **'Full audit trail'**
  String get pricingBananiBusinessF6;

  /// No description provided for @pricingBananiEnterpriseF1.
  ///
  /// In en, this message translates to:
  /// **'Everything in Business'**
  String get pricingBananiEnterpriseF1;

  /// No description provided for @pricingBananiEnterpriseF2.
  ///
  /// In en, this message translates to:
  /// **'Group consolidated reporting'**
  String get pricingBananiEnterpriseF2;

  /// No description provided for @pricingBananiEnterpriseF3.
  ///
  /// In en, this message translates to:
  /// **'Unlimited supply chain'**
  String get pricingBananiEnterpriseF3;

  /// No description provided for @pricingBananiEnterpriseF4.
  ///
  /// In en, this message translates to:
  /// **'API integration (ERP, SAP, TeamSystem)'**
  String get pricingBananiEnterpriseF4;

  /// No description provided for @pricingBananiEnterpriseF5.
  ///
  /// In en, this message translates to:
  /// **'Dedicated account manager'**
  String get pricingBananiEnterpriseF5;

  /// No description provided for @pricingBananiEnterpriseF6.
  ///
  /// In en, this message translates to:
  /// **'99.9% SLA'**
  String get pricingBananiEnterpriseF6;

  /// No description provided for @pricingBananiCtaTrial.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get pricingBananiCtaTrial;

  /// No description provided for @pricingBananiAllPlansNote.
  ///
  /// In en, this message translates to:
  /// **'All plans include: automatic regulatory updates, GDPR compliance, data hosted in Europe (AWS Frankfurt), 14‑day free trial.'**
  String get pricingBananiAllPlansNote;

  /// No description provided for @landingHeaderContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get landingHeaderContact;

  /// No description provided for @landingHeaderRegister.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get landingHeaderRegister;

  /// No description provided for @problem1Body.
  ///
  /// In en, this message translates to:
  /// **'Spreadsheets, email, PDFs, ERP — no single system for metrics.'**
  String get problem1Body;

  /// No description provided for @problem1Title.
  ///
  /// In en, this message translates to:
  /// **'Data everywhere'**
  String get problem1Title;

  /// No description provided for @problem2Body.
  ///
  /// In en, this message translates to:
  /// **'Customer questionnaires, banks, VSME, CDP — a different format every time.'**
  String get problem2Body;

  /// No description provided for @problem2Title.
  ///
  /// In en, this message translates to:
  /// **'Inconsistent requests'**
  String get problem2Title;

  /// No description provided for @problem3Body.
  ///
  /// In en, this message translates to:
  /// **'For reports that law changes every year.'**
  String get problem3Body;

  /// No description provided for @problem3Title.
  ///
  /// In en, this message translates to:
  /// **'€200/h consultants'**
  String get problem3Title;

  /// No description provided for @problemTitle.
  ///
  /// In en, this message translates to:
  /// **'The ESG chaos you have today'**
  String get problemTitle;

  /// No description provided for @problemWarning.
  ///
  /// In en, this message translates to:
  /// **'Omnibus removed CSRD duty for most SMEs. Large customers still ask for ESG data — and the legal cap is VSME.'**
  String get problemWarning;

  /// No description provided for @qaAddEmissions.
  ///
  /// In en, this message translates to:
  /// **'Add emissions'**
  String get qaAddEmissions;

  /// No description provided for @qaConnectErp.
  ///
  /// In en, this message translates to:
  /// **'Connect ERP'**
  String get qaConnectErp;

  /// No description provided for @qaGenReport.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get qaGenReport;

  /// No description provided for @qaUploadExcel.
  ///
  /// In en, this message translates to:
  /// **'Upload Excel'**
  String get qaUploadExcel;

  /// No description provided for @quickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quickActionsTitle;

  /// No description provided for @registerCompany.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get registerCompany;

  /// No description provided for @registerEmail.
  ///
  /// In en, this message translates to:
  /// **'Business email'**
  String get registerEmail;

  /// No description provided for @registerHasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get registerHasAccount;

  /// No description provided for @registerPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerPassword;

  /// No description provided for @registerSector.
  ///
  /// In en, this message translates to:
  /// **'Sector'**
  String get registerSector;

  /// No description provided for @registerSize.
  ///
  /// In en, this message translates to:
  /// **'Company size'**
  String get registerSize;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerSubmit;

  /// No description provided for @registerSubmitLoading.
  ///
  /// In en, this message translates to:
  /// **'Creating account…'**
  String get registerSubmitLoading;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No credit card required'**
  String get registerSubtitle;

  /// No description provided for @registerTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms and Privacy Policy'**
  String get registerTerms;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your 14‑day free trial'**
  String get registerTitle;

  /// No description provided for @reportAddNow.
  ///
  /// In en, this message translates to:
  /// **'Add now →'**
  String get reportAddNow;

  /// No description provided for @reportBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get reportBack;

  /// No description provided for @reportDataCompleteness.
  ///
  /// In en, this message translates to:
  /// **'Data completeness'**
  String get reportDataCompleteness;

  /// No description provided for @reportForward.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get reportForward;

  /// No description provided for @reportGenTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get reportGenTitle;

  /// No description provided for @reportGenerateBtn.
  ///
  /// In en, this message translates to:
  /// **'Generate {standard} report'**
  String reportGenerateBtn(Object standard);

  /// No description provided for @reportGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating…'**
  String get reportGenerating;

  /// No description provided for @reportMissingScope3.
  ///
  /// In en, this message translates to:
  /// **'Missing: Scope 3 tier‑1 suppliers'**
  String get reportMissingScope3;

  /// No description provided for @reportPreviewPdf.
  ///
  /// In en, this message translates to:
  /// **'Preview / print PDF'**
  String get reportPreviewPdf;

  /// No description provided for @reportsEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No reports generated yet. Add emissions data to create your first report.'**
  String get reportsEmptyState;

  /// No description provided for @reportsGeneratedForYear.
  ///
  /// In en, this message translates to:
  /// **'Generated ESG report {year}'**
  String reportsGeneratedForYear(Object year);

  /// No description provided for @reportRow1Title.
  ///
  /// In en, this message translates to:
  /// **'CSRD 2024 — Draft'**
  String get reportRow1Title;

  /// No description provided for @reportRow2Title.
  ///
  /// In en, this message translates to:
  /// **'ISSB climate'**
  String get reportRow2Title;

  /// No description provided for @reportRow3Title.
  ///
  /// In en, this message translates to:
  /// **'CDP responses'**
  String get reportRow3Title;

  /// No description provided for @reportsListTitle.
  ///
  /// In en, this message translates to:
  /// **'ESG reports'**
  String get reportsListTitle;

  /// No description provided for @reportsNew.
  ///
  /// In en, this message translates to:
  /// **'New report'**
  String get reportsNew;

  /// No description provided for @reportsRowMeta.
  ///
  /// In en, this message translates to:
  /// **'{standard} • {year}'**
  String reportsRowMeta(Object standard, Object year);

  /// No description provided for @reportsUsedProgress.
  ///
  /// In en, this message translates to:
  /// **'{used}/{total} reports used'**
  String reportsUsedProgress(Object used, Object total);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @scope1.
  ///
  /// In en, this message translates to:
  /// **'Scope 1'**
  String get scope1;

  /// No description provided for @scope2.
  ///
  /// In en, this message translates to:
  /// **'Scope 2'**
  String get scope2;

  /// No description provided for @scope3.
  ///
  /// In en, this message translates to:
  /// **'Scope 3'**
  String get scope3;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search…'**
  String get searchHint;

  /// No description provided for @sectorManufacturing.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing'**
  String get sectorManufacturing;

  /// No description provided for @sectorOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get sectorOther;

  /// No description provided for @sectorRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail'**
  String get sectorRetail;

  /// No description provided for @sectorServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get sectorServices;

  /// No description provided for @settingsBilling.
  ///
  /// In en, this message translates to:
  /// **'Stripe billing'**
  String get settingsBilling;

  /// No description provided for @settingsCompany.
  ///
  /// In en, this message translates to:
  /// **'Company profile'**
  String get settingsCompany;

  /// No description provided for @settingsManualFull.
  ///
  /// In en, this message translates to:
  /// **'Manual entry (full page)'**
  String get settingsManualFull;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @severityAttention.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get severityAttention;

  /// No description provided for @severityCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get severityCritical;

  /// No description provided for @severityInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get severityInfo;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @size50to250.
  ///
  /// In en, this message translates to:
  /// **'50–250 employees'**
  String get size50to250;

  /// No description provided for @sizeOver250.
  ///
  /// In en, this message translates to:
  /// **'>250 employees'**
  String get sizeOver250;

  /// No description provided for @sizeUnder50.
  ///
  /// In en, this message translates to:
  /// **'<50 employees'**
  String get sizeUnder50;

  /// No description provided for @snackCalculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating… (demo)'**
  String get snackCalculating;

  /// No description provided for @snackDownloadSimulated.
  ///
  /// In en, this message translates to:
  /// **'Simulated download'**
  String get snackDownloadSimulated;

  /// No description provided for @snackPortalEdge.
  ///
  /// In en, this message translates to:
  /// **'Connect an Edge Function that returns a portal session URL.'**
  String get snackPortalEdge;

  /// No description provided for @socialMetricCompanies.
  ///
  /// In en, this message translates to:
  /// **'340+ companies'**
  String get socialMetricCompanies;

  /// No description provided for @socialMetricCompliance.
  ///
  /// In en, this message translates to:
  /// **'98% compliance rate'**
  String get socialMetricCompliance;

  /// No description provided for @socialMetricRating.
  ///
  /// In en, this message translates to:
  /// **'4.9★ rating'**
  String get socialMetricRating;

  /// No description provided for @socialMetricSavings.
  ///
  /// In en, this message translates to:
  /// **'€180k avg. consultant savings'**
  String get socialMetricSavings;

  /// No description provided for @socialTitle.
  ///
  /// In en, this message translates to:
  /// **'What SMEs say about Verdai'**
  String get socialTitle;

  /// No description provided for @solAlert1.
  ///
  /// In en, this message translates to:
  /// **'Customer ESG questionnaire due this month'**
  String get solAlert1;

  /// No description provided for @solAlert2.
  ///
  /// In en, this message translates to:
  /// **'Scope 3: request from automotive OEM'**
  String get solAlert2;

  /// No description provided for @solAlert3.
  ///
  /// In en, this message translates to:
  /// **'ISSB template update available'**
  String get solAlert3;

  /// No description provided for @solCo2Diesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel litres'**
  String get solCo2Diesel;

  /// No description provided for @solCo2DieselHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4200'**
  String get solCo2DieselHint;

  /// No description provided for @solCo2Estimate.
  ///
  /// In en, this message translates to:
  /// **'Scope 1: {tons} t CO₂ (demo estimate)'**
  String solCo2Estimate(Object tons);

  /// No description provided for @solCo2Km.
  ///
  /// In en, this message translates to:
  /// **'Transport km'**
  String get solCo2Km;

  /// No description provided for @solCo2KmHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 180000'**
  String get solCo2KmHint;

  /// No description provided for @solCo2Kwh.
  ///
  /// In en, this message translates to:
  /// **'kWh electricity'**
  String get solCo2Kwh;

  /// No description provided for @solCo2KwhHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 125000'**
  String get solCo2KwhHint;

  /// No description provided for @solReportExportDemo.
  ///
  /// In en, this message translates to:
  /// **'Export PDF (demo)'**
  String get solReportExportDemo;

  /// No description provided for @solReportPreviewBody.
  ///
  /// In en, this message translates to:
  /// **'VSME • Ready for buyers\nLogo • Traceable export'**
  String get solReportPreviewBody;

  /// No description provided for @solReportPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Report preview'**
  String get solReportPreviewTitle;

  /// No description provided for @solTabAlerts.
  ///
  /// In en, this message translates to:
  /// **'🔔 Regulatory alerts'**
  String get solTabAlerts;

  /// No description provided for @solTabCo2.
  ///
  /// In en, this message translates to:
  /// **'📊 Calculate CO₂'**
  String get solTabCo2;

  /// No description provided for @solTabIntegrate.
  ///
  /// In en, this message translates to:
  /// **'🔌 Integrate systems'**
  String get solTabIntegrate;

  /// No description provided for @solTabReport.
  ///
  /// In en, this message translates to:
  /// **'📄 Generate reports'**
  String get solTabReport;

  /// No description provided for @solutionTitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you need. Nothing you don’t.'**
  String get solutionTitle;

  /// No description provided for @standardsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Standards'**
  String get standardsSectionTitle;

  /// No description provided for @stateErrorSupabase.
  ///
  /// In en, this message translates to:
  /// **'Supabase not configured. Use --dart-define.'**
  String get stateErrorSupabase;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'draft'**
  String get statusDraft;

  /// No description provided for @statusInReview.
  ///
  /// In en, this message translates to:
  /// **'in_review'**
  String get statusInReview;

  /// No description provided for @statusPublished.
  ///
  /// In en, this message translates to:
  /// **'published'**
  String get statusPublished;

  /// No description provided for @stdCdp.
  ///
  /// In en, this message translates to:
  /// **'CDP'**
  String get stdCdp;

  /// No description provided for @stdCsrd.
  ///
  /// In en, this message translates to:
  /// **'CSRD (EU)'**
  String get stdCsrd;

  /// No description provided for @stdCsrdSub.
  ///
  /// In en, this message translates to:
  /// **'EU — Corporate Sustainability Reporting Directive'**
  String get stdCsrdSub;

  /// No description provided for @stdCsrdTitle.
  ///
  /// In en, this message translates to:
  /// **'CSRD'**
  String get stdCsrdTitle;

  /// No description provided for @stdEcovadis.
  ///
  /// In en, this message translates to:
  /// **'EcoVadis'**
  String get stdEcovadis;

  /// No description provided for @stdGri.
  ///
  /// In en, this message translates to:
  /// **'GRI'**
  String get stdGri;

  /// No description provided for @stdIssb.
  ///
  /// In en, this message translates to:
  /// **'ISSB (global)'**
  String get stdIssb;

  /// No description provided for @stdIssbSub.
  ///
  /// In en, this message translates to:
  /// **'Global — IFRS Sustainability Disclosure'**
  String get stdIssbSub;

  /// No description provided for @stdIssbTitle.
  ///
  /// In en, this message translates to:
  /// **'ISSB'**
  String get stdIssbTitle;

  /// No description provided for @stdSecSub.
  ///
  /// In en, this message translates to:
  /// **'US — climate disclosures (if applicable)'**
  String get stdSecSub;

  /// No description provided for @stdSecTitle.
  ///
  /// In en, this message translates to:
  /// **'SEC'**
  String get stdSecTitle;

  /// No description provided for @stdUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not sure yet'**
  String get stdUnknown;

  /// No description provided for @stepConfig.
  ///
  /// In en, this message translates to:
  /// **'1. Config'**
  String get stepConfig;

  /// No description provided for @stepOutput.
  ///
  /// In en, this message translates to:
  /// **'3. Output'**
  String get stepOutput;

  /// No description provided for @stepPreview.
  ///
  /// In en, this message translates to:
  /// **'2. Preview'**
  String get stepPreview;

  /// No description provided for @tabIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get tabIntegrations;

  /// No description provided for @tabManual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get tabManual;

  /// No description provided for @tabUploadExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel upload'**
  String get tabUploadExcel;

  /// No description provided for @testimonial1Name.
  ///
  /// In en, this message translates to:
  /// **'Mario R.'**
  String get testimonial1Name;

  /// No description provided for @testimonial1Quote.
  ///
  /// In en, this message translates to:
  /// **'We answered Stellantis’ EcoVadis questionnaire in 2 days. It used to take 3 weeks.'**
  String get testimonial1Quote;

  /// No description provided for @testimonial1Role.
  ///
  /// In en, this message translates to:
  /// **'CFO • Metaltech Srl'**
  String get testimonial1Role;

  /// No description provided for @testimonial2Name.
  ///
  /// In en, this message translates to:
  /// **'Laura M.'**
  String get testimonial2Name;

  /// No description provided for @testimonial2Quote.
  ///
  /// In en, this message translates to:
  /// **'Finally a tool built for SMEs. Not SAP, not Workiva. Verdai.'**
  String get testimonial2Quote;

  /// No description provided for @testimonial2Role.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Manager • SME'**
  String get testimonial2Role;

  /// No description provided for @testimonial3Name.
  ///
  /// In en, this message translates to:
  /// **'Giorgio B.'**
  String get testimonial3Name;

  /// No description provided for @testimonial3Quote.
  ///
  /// In en, this message translates to:
  /// **'I manage 12 SME clients in one account. Immediate ROI.'**
  String get testimonial3Quote;

  /// No description provided for @testimonial3Role.
  ///
  /// In en, this message translates to:
  /// **'Accountant • Firm'**
  String get testimonial3Role;

  /// No description provided for @toggleBenchmark.
  ///
  /// In en, this message translates to:
  /// **'Sector benchmark'**
  String get toggleBenchmark;

  /// No description provided for @toggleImprovement.
  ///
  /// In en, this message translates to:
  /// **'Improvement plan'**
  String get toggleImprovement;

  /// No description provided for @unitCo2eKg.
  ///
  /// In en, this message translates to:
  /// **'kg CO₂e'**
  String get unitCo2eKg;

  /// No description provided for @upgradeGrowth.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Growth'**
  String get upgradeGrowth;

  /// No description provided for @userFallback.
  ///
  /// In en, this message translates to:
  /// **'U'**
  String get userFallback;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get validatorEmailInvalid;

  /// No description provided for @validatorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get validatorEmailRequired;

  /// No description provided for @validatorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get validatorPasswordRequired;

  /// No description provided for @validatorPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get validatorPasswordShort;

  /// No description provided for @validatorRequiredWithLabel.
  ///
  /// In en, this message translates to:
  /// **'{label} is required'**
  String validatorRequiredWithLabel(Object label);

  /// No description provided for @stdEsrs.
  ///
  /// In en, this message translates to:
  /// **'ESRS'**
  String get stdEsrs;

  /// No description provided for @uploadScope3Imported.
  ///
  /// In en, this message translates to:
  /// **'Scope 3 imported: {value}'**
  String uploadScope3Imported(Object value);

  /// No description provided for @compChecklistTitle.
  ///
  /// In en, this message translates to:
  /// **'CSRD/GRI/ESRS Checklist'**
  String get compChecklistTitle;

  /// No description provided for @compTenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Public tender certification'**
  String get compTenderTitle;

  /// No description provided for @compChecklistDoubleMateriality.
  ///
  /// In en, this message translates to:
  /// **'Double materiality assessment'**
  String get compChecklistDoubleMateriality;

  /// No description provided for @compChecklistScopeDisclosure.
  ///
  /// In en, this message translates to:
  /// **'Scope 1/2/3 disclosure table'**
  String get compChecklistScopeDisclosure;

  /// No description provided for @compChecklistSupplierEvidence.
  ///
  /// In en, this message translates to:
  /// **'Supplier due diligence evidence'**
  String get compChecklistSupplierEvidence;

  /// No description provided for @compChecklistClimatePlan.
  ///
  /// In en, this message translates to:
  /// **'Climate risk mitigation plan'**
  String get compChecklistClimatePlan;

  /// No description provided for @compChecklistGovernance.
  ///
  /// In en, this message translates to:
  /// **'Board governance statement'**
  String get compChecklistGovernance;

  /// No description provided for @compAlertMissingSuppliersTitle.
  ///
  /// In en, this message translates to:
  /// **'Missing supplier declarations'**
  String get compAlertMissingSuppliersTitle;

  /// No description provided for @compAlertMissingSuppliersSub.
  ///
  /// In en, this message translates to:
  /// **'No supplier ESG attachments found for current year.'**
  String get compAlertMissingSuppliersSub;

  /// No description provided for @compAlertTenderExpiringTitle.
  ///
  /// In en, this message translates to:
  /// **'Public tender certificate expires soon'**
  String get compAlertTenderExpiringTitle;

  /// No description provided for @compAlertTenderExpiringSub.
  ///
  /// In en, this message translates to:
  /// **'Renew certification before upcoming tender submissions.'**
  String get compAlertTenderExpiringSub;

  /// No description provided for @compCertificateTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificate {reference}'**
  String compCertificateTitle(Object reference);

  /// No description provided for @compCertificateSub.
  ///
  /// In en, this message translates to:
  /// **'Footprint {tons} tCO2e • valid until {date}'**
  String compCertificateSub(Object tons, Object date);

  /// No description provided for @pdfFrameworkAlignment.
  ///
  /// In en, this message translates to:
  /// **'Framework alignment: CSRD / GRI / ESRS'**
  String get pdfFrameworkAlignment;

  /// No description provided for @yearlyWithDiscount.
  ///
  /// In en, this message translates to:
  /// **'Yearly (-20%)'**
  String get yearlyWithDiscount;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @pubLandingHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'The VSME report your large customers can actually ask you for. In 4 hours, not 4 months.'**
  String get pubLandingHeroHeadline;

  /// No description provided for @pubLandingHeroSub.
  ///
  /// In en, this message translates to:
  /// **'Omnibus took CSRD off most SMEs. Procurement, banks and investors still want the data. Verdai answers in the official VSME format.'**
  String get pubLandingHeroSub;

  /// No description provided for @pubLandingHeroCtaFree.
  ///
  /// In en, this message translates to:
  /// **'Start free — No card required'**
  String get pubLandingHeroCtaFree;

  /// No description provided for @pubLandingHeroCtaDemo.
  ///
  /// In en, this message translates to:
  /// **'Watch the demo (3 min)'**
  String get pubLandingHeroCtaDemo;

  /// No description provided for @pubLandingHeroWarning.
  ///
  /// In en, this message translates to:
  /// **'Directive (EU) 2026/470: CSRD now covers only companies with more than 1,000 employees and more than €450M turnover. For everyone else the urgency is the supply-chain cascade, not a Brussels fine.'**
  String get pubLandingHeroWarning;

  /// No description provided for @pubLandingSocialTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re in good company.'**
  String get pubLandingSocialTitle;

  /// No description provided for @pubLandingSocialSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Thousands of European SMEs are no longer in CSRD scope — and still get asked for ESG data.'**
  String get pubLandingSocialSubtitle;

  /// No description provided for @pubLandingSocial1Title.
  ///
  /// In en, this message translates to:
  /// **'I received an ESG request from a large customer'**
  String get pubLandingSocial1Title;

  /// No description provided for @pubLandingSocial1Body.
  ///
  /// In en, this message translates to:
  /// **'Long, complex ESG questionnaires — and no idea where to start.'**
  String get pubLandingSocial1Body;

  /// No description provided for @pubLandingSocial2Title.
  ///
  /// In en, this message translates to:
  /// **'My accountant doesn\'t know what to do'**
  String get pubLandingSocial2Title;

  /// No description provided for @pubLandingSocial2Body.
  ///
  /// In en, this message translates to:
  /// **'Typical answer: you need an external ESG expert costing thousands of euros.'**
  String get pubLandingSocial2Body;

  /// No description provided for @pubLandingSocial3Title.
  ///
  /// In en, this message translates to:
  /// **'I found Excel templates online'**
  String get pubLandingSocial3Title;

  /// No description provided for @pubLandingSocial3Body.
  ///
  /// In en, this message translates to:
  /// **'Messy files, not updated, and not audit-ready.'**
  String get pubLandingSocial3Body;

  /// No description provided for @pubLandingSocial4Title.
  ///
  /// In en, this message translates to:
  /// **'Omnibus took me out of CSRD'**
  String get pubLandingSocial4Title;

  /// No description provided for @pubLandingSocial4Body.
  ///
  /// In en, this message translates to:
  /// **'Yes — but large customers, banks and investors still ask. By law they generally cannot demand more than VSME from companies under 1,000 employees.'**
  String get pubLandingSocial4Body;

  /// No description provided for @pubLandingFaqQ1.
  ///
  /// In en, this message translates to:
  /// **'After Omnibus, who is still in CSRD?'**
  String get pubLandingFaqQ1;

  /// No description provided for @pubLandingFaqA1.
  ///
  /// In en, this message translates to:
  /// **'From financial years starting 1 January 2027: EU companies with more than 1,000 employees and more than €450M net turnover (Directive (EU) 2026/470). Almost all SMEs are out. What remains is the cascade: large reporters still collect value-chain data. This is not legal advice.'**
  String get pubLandingFaqA1;

  /// No description provided for @pubLandingFaqQ2.
  ///
  /// In en, this message translates to:
  /// **'What is VSME and why does it matter now?'**
  String get pubLandingFaqQ2;

  /// No description provided for @pubLandingFaqA2.
  ///
  /// In en, this message translates to:
  /// **'VSME is the EU voluntary SME sustainability standard. After Omnibus, in-scope CSRD companies generally must not request more than VSME from partners averaging under 1,000 employees (value-chain information cap). It is the official format for answering buyer requests.'**
  String get pubLandingFaqA2;

  /// No description provided for @pubLandingFaqQ3.
  ///
  /// In en, this message translates to:
  /// **'Can I send this to a customer or a bank?'**
  String get pubLandingFaqQ3;

  /// No description provided for @pubLandingFaqA3.
  ///
  /// In en, this message translates to:
  /// **'Yes. The export is structured for questionnaires, tenders and credit files: carbon data, VSME datapoints and a traceable trail.'**
  String get pubLandingFaqA3;

  /// No description provided for @pubLandingFaqQ4.
  ///
  /// In en, this message translates to:
  /// **'What if the rules change again?'**
  String get pubLandingFaqQ4;

  /// No description provided for @pubLandingFaqA4.
  ///
  /// In en, this message translates to:
  /// **'The platform tracks Omnibus, VSME and ESRS updates so you answer with the current ceiling — not last year’s Excel.'**
  String get pubLandingFaqA4;

  /// No description provided for @pubLandingFinalTitle.
  ///
  /// In en, this message translates to:
  /// **'Your customer will not wait for your spreadsheet.'**
  String get pubLandingFinalTitle;

  /// No description provided for @pubLandingFinalSub.
  ///
  /// In en, this message translates to:
  /// **'Every unanswered questionnaire is a commercial risk, not a Brussels penalty.'**
  String get pubLandingFinalSub;

  /// No description provided for @pubLandingFinalCta.
  ///
  /// In en, this message translates to:
  /// **'Start your 14-day free trial'**
  String get pubLandingFinalCta;

  /// No description provided for @pubLandingStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'From zero to a VSME pack you can send the buyer, in 3 steps'**
  String get pubLandingStepsTitle;

  /// No description provided for @pubLandingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Connect your data'**
  String get pubLandingStep1Title;

  /// No description provided for @pubLandingStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Import bills, HR and suppliers in minutes.'**
  String get pubLandingStep1Body;

  /// No description provided for @pubLandingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'AI does the math'**
  String get pubLandingStep2Title;

  /// No description provided for @pubLandingStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Scope 1, 2, 3 and ESG indicators automatically.'**
  String get pubLandingStep2Body;

  /// No description provided for @pubLandingStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Generate the VSME report'**
  String get pubLandingStep3Title;

  /// No description provided for @pubLandingStep3Body.
  ///
  /// In en, this message translates to:
  /// **'PDF ready for customers and banks, in one click.'**
  String get pubLandingStep3Body;

  /// No description provided for @pubCompareColFeature.
  ///
  /// In en, this message translates to:
  /// **'Feature'**
  String get pubCompareColFeature;

  /// No description provided for @pubCompareColConsultant.
  ///
  /// In en, this message translates to:
  /// **'ESG consultant'**
  String get pubCompareColConsultant;

  /// No description provided for @pubCompareColExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel'**
  String get pubCompareColExcel;

  /// No description provided for @pubCompareRowCost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get pubCompareRowCost;

  /// No description provided for @pubCompareRowTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get pubCompareRowTime;

  /// No description provided for @pubCompareRowAudit.
  ///
  /// In en, this message translates to:
  /// **'Buyer-ready'**
  String get pubCompareRowAudit;

  /// No description provided for @pubCompareCostConsultant.
  ///
  /// In en, this message translates to:
  /// **'€15k–30k/year'**
  String get pubCompareCostConsultant;

  /// No description provided for @pubCompareCostExcel.
  ///
  /// In en, this message translates to:
  /// **'€0 but 200 hours'**
  String get pubCompareCostExcel;

  /// No description provided for @pubCompareCostVerdant.
  ///
  /// In en, this message translates to:
  /// **'€149/month'**
  String get pubCompareCostVerdant;

  /// No description provided for @pubCompareTimeConsultant.
  ///
  /// In en, this message translates to:
  /// **'3–6 months'**
  String get pubCompareTimeConsultant;

  /// No description provided for @pubCompareTimeExcelNever.
  ///
  /// In en, this message translates to:
  /// **'Never finished'**
  String get pubCompareTimeExcelNever;

  /// No description provided for @pubCompareTimeVerdant.
  ///
  /// In en, this message translates to:
  /// **'4 hours'**
  String get pubCompareTimeVerdant;

  /// No description provided for @pubCompareAuditDepends.
  ///
  /// In en, this message translates to:
  /// **'Depends'**
  String get pubCompareAuditDepends;

  /// No description provided for @pubCompareAuditNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get pubCompareAuditNo;

  /// No description provided for @pubCompareAuditYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get pubCompareAuditYes;

  /// No description provided for @pubFeaturesGridTitle.
  ///
  /// In en, this message translates to:
  /// **'What you need to answer the supply-chain cascade'**
  String get pubFeaturesGridTitle;

  /// No description provided for @pubFeatureCarbon.
  ///
  /// In en, this message translates to:
  /// **'Carbon accounting (Scope 1, 2, 3)'**
  String get pubFeatureCarbon;

  /// No description provided for @pubFeatureStandards.
  ///
  /// In en, this message translates to:
  /// **'VSME report — the value-chain legal cap'**
  String get pubFeatureStandards;

  /// No description provided for @pubFeaturePdf.
  ///
  /// In en, this message translates to:
  /// **'Buyer-ready PDF, not a consultant deck'**
  String get pubFeaturePdf;

  /// No description provided for @pubFeatureBanking.
  ///
  /// In en, this message translates to:
  /// **'ESG bankability profile'**
  String get pubFeatureBanking;

  /// No description provided for @pubFeatureSupplyChain.
  ///
  /// In en, this message translates to:
  /// **'Buyer questionnaires and supplier data'**
  String get pubFeatureSupplyChain;

  /// No description provided for @pubFeatureAlerts.
  ///
  /// In en, this message translates to:
  /// **'Omnibus and VSME updates'**
  String get pubFeatureAlerts;

  /// No description provided for @pubTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'The legal duty shrank. Buyer requests did not.'**
  String get pubTimelineTitle;

  /// No description provided for @pubTimeline1Label.
  ///
  /// In en, this message translates to:
  /// **'March 2026'**
  String get pubTimeline1Label;

  /// No description provided for @pubTimeline1Body.
  ///
  /// In en, this message translates to:
  /// **'Omnibus I enters into force: CSRD thresholds rise to 1,000 employees and €450M turnover.'**
  String get pubTimeline1Body;

  /// No description provided for @pubTimeline2Label.
  ///
  /// In en, this message translates to:
  /// **'FY 2027'**
  String get pubTimeline2Label;

  /// No description provided for @pubTimeline2Body.
  ///
  /// In en, this message translates to:
  /// **'Mandatory CSRD stays only for the largest groups. SMEs leave the legal perimeter.'**
  String get pubTimeline2Body;

  /// No description provided for @pubTimeline3Label.
  ///
  /// In en, this message translates to:
  /// **'Value-chain cap'**
  String get pubTimeline3Label;

  /// No description provided for @pubTimeline3Body.
  ///
  /// In en, this message translates to:
  /// **'Large customers generally cannot ask you for more than VSME if you average under 1,000 employees.'**
  String get pubTimeline3Body;

  /// No description provided for @pubTimeline4Label.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get pubTimeline4Label;

  /// No description provided for @pubTimeline4Body.
  ///
  /// In en, this message translates to:
  /// **'Procurement, banks and investors already ask. Teams that answer in VSME keep the contract.'**
  String get pubTimeline4Body;

  /// No description provided for @pubTestimonial1Name.
  ///
  /// In en, this message translates to:
  /// **'Marco R.'**
  String get pubTestimonial1Name;

  /// No description provided for @pubTestimonial1Role.
  ///
  /// In en, this message translates to:
  /// **'COO'**
  String get pubTestimonial1Role;

  /// No description provided for @pubTestimonial1Quote.
  ///
  /// In en, this message translates to:
  /// **'ESG questionnaire completed in one afternoon.'**
  String get pubTestimonial1Quote;

  /// No description provided for @pubTestimonial2Name.
  ///
  /// In en, this message translates to:
  /// **'Giulia T.'**
  String get pubTestimonial2Name;

  /// No description provided for @pubTestimonial2Role.
  ///
  /// In en, this message translates to:
  /// **'CFO'**
  String get pubTestimonial2Role;

  /// No description provided for @pubTestimonial2Quote.
  ///
  /// In en, this message translates to:
  /// **'Report ready in 3 days for the bank.'**
  String get pubTestimonial2Quote;

  /// No description provided for @pubTestimonial3Name.
  ///
  /// In en, this message translates to:
  /// **'Andrea M.'**
  String get pubTestimonial3Name;

  /// No description provided for @pubTestimonial3Role.
  ///
  /// In en, this message translates to:
  /// **'CEO'**
  String get pubTestimonial3Role;

  /// No description provided for @pubTestimonial3Quote.
  ///
  /// In en, this message translates to:
  /// **'€149/month instead of €20k in consulting.'**
  String get pubTestimonial3Quote;

  /// No description provided for @pubLandingPlanStarterName.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get pubLandingPlanStarterName;

  /// No description provided for @pubLandingPlanBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get pubLandingPlanBusinessName;

  /// No description provided for @pubLandingPlanEnterpriseName.
  ///
  /// In en, this message translates to:
  /// **'Enterprise'**
  String get pubLandingPlanEnterpriseName;

  /// No description provided for @pubLandingPlanStarterB1.
  ///
  /// In en, this message translates to:
  /// **'VSME report'**
  String get pubLandingPlanStarterB1;

  /// No description provided for @pubLandingPlanStarterB2.
  ///
  /// In en, this message translates to:
  /// **'Basic carbon footprint'**
  String get pubLandingPlanStarterB2;

  /// No description provided for @pubLandingPlanStarterB3.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get pubLandingPlanStarterB3;

  /// No description provided for @pubLandingPlanBusinessB1.
  ///
  /// In en, this message translates to:
  /// **'ESRS report'**
  String get pubLandingPlanBusinessB1;

  /// No description provided for @pubLandingPlanBusinessB2.
  ///
  /// In en, this message translates to:
  /// **'Scope 1/2/3'**
  String get pubLandingPlanBusinessB2;

  /// No description provided for @pubLandingPlanBusinessB3.
  ///
  /// In en, this message translates to:
  /// **'Full audit trail'**
  String get pubLandingPlanBusinessB3;

  /// No description provided for @pubLandingPlanEnterpriseB1.
  ///
  /// In en, this message translates to:
  /// **'Group consolidation'**
  String get pubLandingPlanEnterpriseB1;

  /// No description provided for @pubLandingPlanEnterpriseB2.
  ///
  /// In en, this message translates to:
  /// **'ERP API'**
  String get pubLandingPlanEnterpriseB2;

  /// No description provided for @pubLandingPlanEnterpriseB3.
  ///
  /// In en, this message translates to:
  /// **'Account manager'**
  String get pubLandingPlanEnterpriseB3;

  /// No description provided for @pubLandingPricingPerMonthSuffix.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get pubLandingPricingPerMonthSuffix;

  /// No description provided for @salesMailSubject.
  ///
  /// In en, this message translates to:
  /// **'Enterprise plan inquiry'**
  String get salesMailSubject;

  /// No description provided for @authBulletEmojiLock.
  ///
  /// In en, this message translates to:
  /// **'🔒'**
  String get authBulletEmojiLock;

  /// No description provided for @authBulletEmojiChart.
  ///
  /// In en, this message translates to:
  /// **'📊'**
  String get authBulletEmojiChart;

  /// No description provided for @authBulletEmojiCheck.
  ///
  /// In en, this message translates to:
  /// **'✓'**
  String get authBulletEmojiCheck;

  /// No description provided for @contactPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get contactPageTitle;

  /// No description provided for @contactPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Questions on VSME, buyer questionnaires or Verdai? We reply within one business day.'**
  String get contactPageSubtitle;

  /// No description provided for @contactCardSalesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales & pilots'**
  String get contactCardSalesTitle;

  /// No description provided for @contactCardSalesBody.
  ///
  /// In en, this message translates to:
  /// **'Plans, demos, and enterprise procurement — we help you choose the right setup.'**
  String get contactCardSalesBody;

  /// No description provided for @contactCardSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Product support'**
  String get contactCardSupportTitle;

  /// No description provided for @contactCardSupportBody.
  ///
  /// In en, this message translates to:
  /// **'Help with data, reports, access, and integrations for active customers.'**
  String get contactCardSupportBody;

  /// No description provided for @contactCardOfficeTitle.
  ///
  /// In en, this message translates to:
  /// **'Office & hours'**
  String get contactCardOfficeTitle;

  /// No description provided for @contactCardOfficeBody.
  ///
  /// In en, this message translates to:
  /// **'EU-hosted data. Monday–Friday, 9:00–18:00 CET.'**
  String get contactCardOfficeBody;

  /// No description provided for @contactEmailSalesLabel.
  ///
  /// In en, this message translates to:
  /// **'sales@marconisoftware.com'**
  String get contactEmailSalesLabel;

  /// No description provided for @contactEmailSupportLabel.
  ///
  /// In en, this message translates to:
  /// **'sales@marconisoftware.com'**
  String get contactEmailSupportLabel;

  /// No description provided for @contactCtaWriteSales.
  ///
  /// In en, this message translates to:
  /// **'Email sales'**
  String get contactCtaWriteSales;

  /// No description provided for @contactCtaWriteSupport.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get contactCtaWriteSupport;

  /// No description provided for @contactMailSubjectSales.
  ///
  /// In en, this message translates to:
  /// **'Verdai — Sales inquiry'**
  String get contactMailSubjectSales;

  /// No description provided for @contactMailSubjectSupport.
  ///
  /// In en, this message translates to:
  /// **'Verdai — Support request'**
  String get contactMailSubjectSupport;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'el',
        'en',
        'es',
        'fa',
        'fr',
        'he',
        'hi',
        'it',
        'ja',
        'ko',
        'nl',
        'pl',
        'pt',
        'ru',
        'sv',
        'tr',
        'uk',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
