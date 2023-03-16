// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => AppCargoClient(c<Dio>()));
    container.registerSingleton((c) => FreightChatClient(c<Dio>()));
    container.registerSingleton((c) => FIPEClient(c<Dio>()));
    container.registerSingleton(
        (c) => UserService(c<AppCargoClient>(), c<NotificationService>()));
    container.registerSingleton((c) => DriverService(c<AppCargoClient>()));
    container
        .registerSingleton((c) => ConfigurationService(c<AppCargoClient>()));
    container.registerSingleton((c) => FreightService(c<AppCargoClient>()));
    container.registerSingleton((c) => MeService(c<AppCargoClient>()));
    container.registerSingleton((c) => ComplaintService(c<AppCargoClient>()));
    container.registerSingleton((c) => VouchersService(c<AppCargoClient>()));
    container
        .registerSingleton((c) => FreightCompanyService(c<AppCargoClient>()));
    container.registerSingleton((c) => FIPEService(c<FIPEClient>()));
    container.registerSingleton(
        (c) => UtilService(c<FIPEClient>(), c<AppCargoClient>()));
    container.registerSingleton((c) => ClubService(c<AppCargoClient>()));
    container.registerSingleton((c) => NotificationService());
    container.registerSingleton((c) => NavigationService());
    container.registerSingleton((c) => ClubBannerService(c<AppCargoClient>()));
    container.registerSingleton((c) => FacebookAppEvents());
    container.registerSingleton((c) => FirebaseAnalytics());
    container.registerSingleton((c) => DailyQuoteService(c<AppCargoClient>()));
    container.registerSingleton((c) => UserMockService());
    container.registerSingleton((c) => FreightMockService());
    container.registerSingleton((c) => ComplaintMockService());
    container.registerSingleton((c) => VouchersMockService());
    container
        .registerSingleton((c) => RecoverPasswordService(c<AppCargoClient>()));
    container.registerSingleton((c) => FreightCompanyMockService());
    container.registerSingleton((c) => UtilMockService());
    container.registerSingleton((c) => ClubMockService());
    container.registerSingleton((c) => DatabaseProvider());
    container
        .registerSingleton((c) => CurrentFreightDAO(c<DatabaseProvider>()));
    container.registerSingleton(
        (c) => FreightProposalDeclineReasonDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => FreightHistoryDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => FreightProposalsDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => VoucherDetailsDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => DriverContactDataDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => DriverPersonalDataDAO(c<DatabaseProvider>()));
    container.registerSingleton(
        (c) => DriverEmergencyDataDAO(c<DatabaseProvider>()));
    container
        .registerSingleton((c) => DriverSocialDataDAO(c<DatabaseProvider>()));
    container.registerSingleton((c) => SyncDAO(c<DatabaseProvider>()));
    container.registerSingleton(
        (c) => VehicleDataDAO(c<DatabaseProvider>(), c<TrailerDAO>()));
    container.registerSingleton((c) => TrailerDAO(c<DatabaseProvider>()));
    container.registerSingleton((c) => TruckPhotoTypeHelper());
    container.registerSingleton((c) => DriverLicenseCategoryHelper());
    container.registerSingleton((c) => TruckTypeHelper());
    container.registerSingleton((c) => TruckWeightHelper(c<TruckTypeHelper>()));
    container.registerSingleton((c) => TrailerTypeHelper());
    container.registerSingleton((c) => TrackerTypeHelper());
    container.registerSingleton((c) => TruckAxlesHelper());
    container.registerSingleton((c) => MinimumFreightLoadTypeHelper());
    container.registerSingleton((c) => MinimumFreightTruckAxlesHelper());
    container.registerSingleton((c) => MinimumFreightTypeHelper());
    container.registerSingleton((c) => MinimumFreightService());
    container.registerSingleton((c) => GenderTypeHelper());
    container.registerSingleton((c) => LocationService(c<AppCargoClient>()));
    container.registerSingleton((c) => ErrorService());
    container.registerSingleton((c) => ChatService());
    container.registerSingleton((c) => GeoService(c<AppCargoClient>()));
    container.registerSingleton((c) => OmniService(c<AppCargoClient>()));
    container.registerSingleton(
        (c) => RequestFreightQuestionnaireService(c<AppCargoClient>()));
    container.registerSingleton(
        (c) => FreightChatService(c<FreightChatClient>(), c<AppCargoClient>()));
  }
}
