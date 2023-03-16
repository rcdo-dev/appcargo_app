import 'package:app_cargo/screens/app_user_settings/app_user_settings.dart';
import 'package:app_cargo/screens/attendance_channel/attendance_channel.dart';
import 'package:app_cargo/screens/cargo/cargo_menu.dart';
import 'package:app_cargo/screens/cargo/with_cargo/with_cargo.dart';
import 'package:app_cargo/screens/chat/chat_info_screen.dart';

import 'package:app_cargo/screens/chat/chat_list_screen.dart';
import 'package:app_cargo/screens/club/club_menu.dart';
import 'package:app_cargo/screens/club/club_partner_details.dart';
import 'package:app_cargo/screens/companies/companies_menu.dart';
import 'package:app_cargo/screens/companies/complaint/complaint_answer/complaint_answer.dart';
import 'package:app_cargo/screens/companies/complaint/complaint_details.dart';
import 'package:app_cargo/screens/companies/complaint/make_complaint/make_complaint.dart';
import 'package:app_cargo/screens/companies/complaint/settings_complaint.dart';
import 'package:app_cargo/screens/companies/evaluate_company.dart';
import 'package:app_cargo/screens/companies/freightco_search_result.dart';
import 'package:app_cargo/screens/companies/ranking_companies.dart';
import 'package:app_cargo/screens/companies/ten_best_companies.dart';
import 'package:app_cargo/screens/disabled_account.dart';
import 'package:app_cargo/screens/financing/financing_options/financing_options.dart';
import 'package:app_cargo/screens/financing/financing_selected_option_form/option_selected_form.dart';
import 'package:app_cargo/screens/financing/omni_menu_options/omni_menu_options.dart';
import 'package:app_cargo/screens/financing/request_new_refinancing/request_new_refinancing.dart';
import 'package:app_cargo/screens/financing/user_requests.dart';
import 'package:app_cargo/screens/financing/plate_request_history.dart';
import 'package:app_cargo/screens/financing/financing_options/financing_options_details.dart';
import 'package:app_cargo/screens/freight/carrier_info.dart';
import 'package:app_cargo/screens/freight/driver_and_freight_chat.dart';
import 'package:app_cargo/screens/freight/freight_accepted.dart';
import 'package:app_cargo/screens/freight/freight_history.dart';
import 'package:app_cargo/screens/freight/freight_info.dart';
import 'package:app_cargo/screens/freight/freight_current.dart';
import 'package:app_cargo/screens/freight/freight_proposal.dart';
import 'package:app_cargo/screens/freight/freight_proposals.dart';
import 'package:app_cargo/screens/freight/freight_refused.dart';
import 'package:app_cargo/screens/freight/freight_search/freight_result_search.dart';
import 'package:app_cargo/screens/freight/freight_search/freight_search/freight_search.dart';
import 'package:app_cargo/screens/freight_chat/freight_chat_screen.dart';
import 'package:app_cargo/screens/freight_chat/threads_details.dart';
import 'package:app_cargo/screens/freight_questionnaire/request_freight_questionnaire.dart';
import 'package:app_cargo/screens/intro.dart';
import 'package:app_cargo/screens/login/login_driver.dart';
import 'package:app_cargo/screens/login/recover_password/recover_password.dart';
import 'package:app_cargo/screens/login/recover_password/recover_password_2.dart';
import 'package:app_cargo/screens/login/recover_password/recover_password_3.dart';
import 'package:app_cargo/screens/login/recover_password/recover_password_4.dart';
import 'package:app_cargo/screens/lucky_number/lucky_number.dart';
import 'package:app_cargo/screens/menu_company.dart';
import 'package:app_cargo/screens/minimum_freight/minimum_freight_screen.dart';
import 'package:app_cargo/screens/old_app_version.dart';
import 'package:app_cargo/screens/settings/user_data/disable_account.dart';
import 'package:app_cargo/screens/signup/end_signup.dart';
import 'package:app_cargo/screens/signup/signup_screen.dart';
import 'package:app_cargo/screens/menu.dart';
import 'package:app_cargo/screens/settings/help/settings_about.dart';
import 'package:app_cargo/screens/settings/help/settings_doubts.dart';
import 'package:app_cargo/screens/settings/help/settings_help_menu.dart';
import 'package:app_cargo/screens/settings/notifications/settings_notifications.dart';
import 'package:app_cargo/screens/settings/user_data/settings_billing_details.dart';
import 'package:app_cargo/screens/settings/user_data/settings_change_password/settings_change_password.dart';
import 'package:app_cargo/screens/settings/user_data/settings_contact/settings_contact.dart';
import 'package:app_cargo/screens/settings/settings_menu.dart';
import 'package:app_cargo/screens/settings/user_data/settings_payment.dart';
import 'package:app_cargo/screens/settings/user_data/settings_personal_data.dart';
import 'package:app_cargo/screens/settings/user_data/settings_vehicle/settings_vehicle_data.dart';
import 'package:app_cargo/screens/settings/user_data/settings_your_data/settings_your_data.dart';
import 'package:app_cargo/screens/start_screen.dart';
import 'package:app_cargo/widgets/app_cnh_camera.dart';
import 'package:app_cargo/widgets/app_crlv_camera.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static const String index = '/';
  static const String intro = '/intro';
  static const String startScreen = '/startScreen';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String endSignUp = '/endSignUp';
  static const String disabledAccount = '/disabledAccount';
  static const String chatList = '/chatList';
  static const String chatInfo = '/chatInfo';
  static const String oldAppVersion = '/oldAppVersion';

  // =========== Recover Password ====================== \\
  static const String recoverPassword = '/recoverPassword';
  static const String recoverPassword2 = '/recoverPassword2';
  static const String recoverPassword3 = '/recoverPassword3';
  static const String recoverPassword4 = '/recoverPassword4';
  static const String menu = '/menu';
  static const String menuCompany = '/menuCompany';
  static const String luckyNumber = '/luckyNumber';

  // ================= Freight ==========================\\
  static const String freightProposal = '/freightProposal';
  static const String freightProposals = '/freightProposals';
  static const String freightAccepted = '/freightAccepted';
  static const String freightRefused = '/freightRefused';
  static const String freightCurrent = '/freightCurrent';
  static const String freightHistory = '/freightHistory';
  static const String freightInfo = '/freightInfo';
  static const String freightSearch = '/freightSearch';
  static const String freightResultSearch = '/freightResultSearch';

  // ================= Settings =========================\\

  static const String appUserSettings = '/appUserSettings';

  static const String settingsMenu = '/settingsMenu';
  static const String settingsPersonalData = '/settingsPersonalData';
  static const String settingsYourData = '/settingsYourData';
  static const String settingsVehicleData = '/settingsVehicleData';
  static const String settingsContactData = '/settingsContactData';
  static const String settingsChangePasswordData =
      '/settingsChangePasswordData';
  static const String settingsPayment = '/settingsPayment';
  static const String settingsBillingDetails = '/settingsBillingDetails';
  static const String settingsNotifications = '/settingsNotifications';
  static const String settingsComplaint = '/settingsComplaint';
  static const String makeComplaint = '/makeComplaint';
  static const String complaintDetails = '/complaintDetails';
  static const String complaintAnswer = '/complaintAnswer';
  static const String settingsHelpMenu = '/settingsHelpMenu';
  static const String settingsDoubts = '/settingsDoubts';
  static const String settingsAbout = '/settingsAbout';
  static const String disableAccount = '/disableAccount';

  // ================ Cargo =============================\\
  static const String cargoMenu = '/cargoMenu';
  static const String withCargo = '/withCargo';
  static const String withoutCargo = '/withoutCargo';
  static const String notReceiveFreight = '/notReceiveFreight';

  // ================ Carrier ===========================\\
  static const String carrierInfo = '/carrierInfo';

  // ================ Companies ===========================\\
  static const String companiesMenu = '/companiesMenu';
  static const String tenBestCompanies = '/tenBestCompanies';
  static const String rankingCompanies = '/rankingCompanies';
  static const String evaluateCompany = '/evaluateCompany';
  static const String freightCoSearchResults = '/freightCoSearchResults';

  // ================ Club ===========================\\
  static const String clubMenu = '/clubMenu';
  static const String clubPartnerDetails = '/clubPartnerDetails';
  static const String becomeVip = '/becomeVip';
  static const String sentInvites = '/sentInvites';
  static const String couponInfo = '/couponInfo';
  static const String myBenefits = '/myBenefits';

  // ================ Refinancing ========================== \\

  static const String omniMenuOptions = '/omniMenuOptions';

  static const String requestNewRefinancing = '/requestNewRefinancing';
  static const String userRequests = '/userRequests';
  static const String requestsHistory = '/requestsHistory';
  static const String financingOption = '/financingOption';
  static const String financingOptionDetails = '/financingOptionDetails';
  static const String optionSelectedForm = '/optionSelectedForm';

  // ================ Util ========================= \\
  static const String appCNHCamera = '/appCNHCamera';
  static const String appCRLVCamera = '/appCRLVCamera';
  static const String driverAndFreightChat = '/driverChat';
  static const String minimumFreight = '/minimumFreight';

  // ================ Request Freight ========================= \\
  static const String requestFreight = '/requestFreight';

  // ================ Freight Chat ========================= \\
  static const String freightChat = '/freightChat';
  static const String threadsDetails = '/threadsDetails';

  // ================ Attendance Channel ========================= \\
  static const String attendanceChannel = '/attendanceChannel';

  static final routes = <String, WidgetBuilder>{
    index: (_) => Menu(),
    // index: (_) => Menu(),
    intro: (_) => Intro(),
    menuCompany: (_) => MenuCompany(),
    disabledAccount: (_) => DisabledAccount(),
    chatList: (_) => ChatListScreen(),
    oldAppVersion: (_) => OldAppVersion(),
    minimumFreight: (_) => MinimumFreightScreen(),
    luckyNumber: (_) => LuckyNumber(),

    // ============= Login ===============\\
    // index: (_) => StartScreen(),
    startScreen: (_) => StartScreen(),
    // index: (_) => SignIn(),
    signIn: (_) => SignIn(),
    signUp: (_) => SignUpScreen(),
    endSignUp: (_) => EndSignUp(),
    recoverPassword: (_) => RecoverPassword(),
    recoverPassword2: (_) => RecoverPassword2(),
    recoverPassword3: (_) => RecoverPassword3(),
    recoverPassword4: (_) => RecoverPassword4(),

    // ============= Freight ============\\
    freightProposal: (_) => FreightProposal(),
    freightProposals: (_) => FreightProposals(),
    freightAccepted: (_) => FreightAccepted(),
    freightRefused: (_) => FreightRefused(),
    freightCurrent: (_) => FreightCurrent(),
    freightHistory: (_) => FreightHistory(),
    freightInfo: (_) => FreightInfo(),
    freightSearch: (_) => FreightSearch(),
    freightResultSearch: (_) => FreightResultSearch(),
    carrierInfo: (_) => CarrierInfo(),

    // ============ Settings ============ \\

    appUserSettings: (_) => AppUserSettings(),
    settingsMenu: (_) => SettingsMenu(),
    settingsPersonalData: (_) => SettingsPersonalData(),
    settingsYourData: (_) => SettingsYourData(),
    settingsVehicleData: (_) => SettingsVehicleData(),
    settingsContactData: (_) => SettingsContactData(),
    settingsChangePasswordData: (_) => SettingsChangePasswordData(),
    settingsPayment: (_) => SettingsPayment(),
    settingsBillingDetails: (_) => SettingsBillingDetails(),
    settingsNotifications: (_) => SettingsNotifications(),
    settingsComplaint: (_) => SettingsComplaint(),
    makeComplaint: (_) => MakeComplaint(),
    complaintDetails: (_) => ComplaintDetailsScreen(),
    complaintAnswer: (_) => ComplaintAnswer(),
    settingsHelpMenu: (_) => SettingsHelpMenu(),
    settingsDoubts: (_) => SettingsDoubts(),
    settingsAbout: (_) => SettingsAbout(),
    disableAccount: (_) => DisableAccount(),

    // =========== Cargo =================\\
    cargoMenu: (_) => CargoMenu(),
    withCargo: (_) => WithCargo(),

    // ================ Companies ===========================\\
    companiesMenu: (_) => CompaniesMenu(),
    tenBestCompanies: (_) => TenBestCompanies(),
    rankingCompanies: (_) => RankingCompanies(),
    evaluateCompany: (_) => EvaluateCompany(),
    freightCoSearchResults: (_) => FreightCoSearchResultScreen(),

    // ================ Club===========================\\
    clubMenu: (_) => ClubMenu(),
    clubPartnerDetails: (_) => ClubPartnerDetails(),

    // ================ Refinancing ========================== \\
    omniMenuOptions: (_) => OmniMenuOptions(),
    requestNewRefinancing: (_) => RequestNewRefinancing(),
    userRequests: (_) => UserRequests(),
    requestsHistory: (_) => PlateRequestHistory(),
    financingOption: (_) => FinancingOptions(),
    financingOptionDetails: (_) => FinancingOptionsDetails(),
    optionSelectedForm: (_) => OptionSelectedForm(),

    // ================ Util ========================== \\
    appCNHCamera: (_) => AppCNHCamera(),
    appCRLVCamera: (_) => AppCRLVCamera(),
    driverAndFreightChat: (_) => DriverAndFreightChat(),
    chatInfo: (_) => ChatInfoScreen(),

    // ================ Request Freight ========================== \\
    requestFreight: (_) => RequestFreightQuestionnaire(),

    // ================ Freight Chat ========================== \\
    freightChat: (_) => FreightChatScreen(),
    threadsDetails: (_) => ThreadsDetails(),

    // ================ Attendance Channel ========================== \\
    attendanceChannel: (_) => AttendanceChannel(),
  };
}
