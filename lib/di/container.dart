import 'package:app_cargo/db/current_freight_dao.dart';
import 'package:app_cargo/db/database_provider.dart';
import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/driver_contact_data_dao.dart';
import 'package:app_cargo/db/driver_emergency_data_dao.dart';
import 'package:app_cargo/db/driver_personal_data_dao.dart';
import 'package:app_cargo/db/driver_social_data_dao.dart';
import 'package:app_cargo/db/freight_history_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/db/sync_dao.dart';
import 'package:app_cargo/db/trailer_dao.dart';
import 'package:app_cargo/db/vehicle_data_dao.dart';
import 'package:app_cargo/db/voucher_details_dao.dart';
import 'package:app_cargo/domain/driver_license/driver_license.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles_helper.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type_helper.dart';
import 'package:app_cargo/domain/truck/truck.dart';
import 'package:app_cargo/domain/truck_photo/truck_photo.dart';
import 'package:app_cargo/http/access_token_interceptor.dart';
import 'package:app_cargo/http/app_cargo_client.dart';
import 'package:app_cargo/http/chat_security_header_interceptor.dart';
import 'package:app_cargo/http/fipe_client.dart';
import 'package:app_cargo/http/freight_chat_client.dart';
import 'package:app_cargo/services/chat/chat_service.dart';
import 'package:app_cargo/services/club/club_mock_service.dart';
import 'package:app_cargo/services/club/club_service.dart';
import 'package:app_cargo/services/club_banner/club_banner_service.dart';
import 'package:app_cargo/services/complaint/complaint_mock_service.dart';
import 'package:app_cargo/services/complaint/complaint_service.dart';
import 'package:app_cargo/services/config/config_service.dart';
import 'package:app_cargo/services/daily_quote/daily_quote_service.dart';
import 'package:app_cargo/services/driver/driver_service.dart';
import 'package:app_cargo/services/error/error_service.dart';
import 'package:app_cargo/services/fipe/fipe_service.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/services/freight_chat/freight_chat_service.dart';
import 'package:app_cargo/services/freight_company/freight_company_mock_service.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/services/geo_service/geo_service.dart';
import 'package:app_cargo/services/location/location_service.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/services/minimum_freight/minimum_freight_service.dart';
import 'package:app_cargo/services/navigation/navigation_service.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/services/recover_password/recover_password_service.dart';
import 'package:app_cargo/services/request_freight_questionnaire_service/request_freight_questionnaire_service.dart';
import 'package:app_cargo/services/user/user_mock_service.dart';
import 'package:app_cargo/services/user/user_service.dart';
import 'package:app_cargo/services/util/util_mock_serivce.dart';
import 'package:app_cargo/services/util/util_service.dart';
import 'package:app_cargo/services/vouchers_service/vouchers_mock_service.dart';
import 'package:app_cargo/services/vouchers_service/vouchers_service.dart';
import 'package:dio/dio.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kiwi/kiwi.dart';

import '../domain/driver_personal_data/driver_personal_data.dart';
import '../services/notification/notification_service.dart';

part 'container.g.dart';

abstract class Injector {

  // Dio Client
  @Register.singleton(AppCargoClient)
  @Register.singleton(FIPEClient)

  // Services
  @Register.singleton(UserService)
  @Register.singleton(DriverService)
  @Register.singleton(ConfigurationService)
  @Register.singleton(FreightService)
  @Register.singleton(MeService)
  @Register.singleton(ComplaintService)
  @Register.singleton(VouchersService)
  @Register.singleton(FreightCompanyService)
  @Register.singleton(FIPEService)
  @Register.singleton(UtilService)
  @Register.singleton(ClubService)
  @Register.singleton(NotificationService)
  @Register.singleton(NavigationService)
  @Register.singleton(ClubBannerService)
  @Register.singleton(FacebookAppEvents)
  @Register.singleton(FirebaseAnalytics)
  @Register.singleton(DailyQuoteService)

  // Mock
  @Register.singleton(UserMockService)

  // @Register.singleton(DriverMockService)
  @Register.singleton(FreightMockService)
  @Register.singleton(ComplaintMockService)
  @Register.singleton(VouchersMockService)
  @Register.singleton(RecoverPasswordService)
  @Register.singleton(FreightCompanyMockService)
  @Register.singleton(UtilMockService)
  @Register.singleton(ClubMockService)
  @Register.singleton(LocationService)
  @Register.singleton(ErrorService)
  @Register.singleton(ChatService)
  @Register.singleton(GeoService)

  // DAOs
  @Register.singleton(DatabaseProvider)
  @Register.singleton(CurrentFreightDAO)
  @Register.singleton(FreightProposalDeclineReasonDAO)
  @Register.singleton(FreightHistoryDAO)
  @Register.singleton(FreightProposalsDAO)
  @Register.singleton(VoucherDetailsDAO)
  @Register.singleton(DriverContactDataDAO)
  @Register.singleton(DriverPersonalDataDAO)
  @Register.singleton(DriverEmergencyDataDAO)
  @Register.singleton(DriverSocialDataDAO)
  @Register.singleton(SyncDAO)
  @Register.singleton(VehicleDataDAO)
  @Register.singleton(TrailerDAO)

  // Helpers
  @Register.singleton(TruckPhotoTypeHelper)
  @Register.singleton(DriverLicenseCategoryHelper)
  @Register.singleton(TruckTypeHelper)
  @Register.singleton(TruckWeightHelper)
  @Register.singleton(TrailerTypeHelper)
  @Register.singleton(TrackerTypeHelper)
  @Register.singleton(TruckAxlesHelper)
  @Register.singleton(MinimumFreightLoadTypeHelper)
  @Register.singleton(MinimumFreightTruckAxlesHelper)
  @Register.singleton(MinimumFreightTypeHelper)
  @Register.singleton(MinimumFreightService)
  @Register.singleton(GenderTypeHelper)

  //OMNI INTEGRATION
  @Register.singleton(OmniService)

  //Freight Questionnaire
  @Register.singleton(RequestFreightQuestionnaireService)

  //Freight Chat
  @Register.singleton(FreightChatService)


  void configure();
}

void initContainer() {
  final Container container = Container();

  Dio dio = Dio()
    ..options.connectTimeout = 1000*60*3
    ..options.receiveTimeout = 1000*60*3
    ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
    ..options.responseType = ResponseType.plain
    //..interceptors.add(JsonInterceptor())
    ..interceptors.add(AccessTokenInterceptor())
    ..interceptors.add(LogInterceptor(responseBody: true));

  container.registerSingleton<Dio, Dio>((c) => dio);

  _$Injector().configure();
}

class DIContainer {
  T get<T>({String name}) {
    return Container().resolve<T>(name);
  }
}
