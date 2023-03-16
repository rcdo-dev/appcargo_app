import 'package:app_cargo/http/api_error.dart';

final ApiError UNDEFINED_FREIGHT_COMPANY_SEARCH_ERROR = new ApiError("UNDEFINED_FREIGHT_COMPANY_SEARCH_ERROR", details: "Ocorreu um erro efetuar a busca por companhias, tente novamente mais tarde");
final ApiError ALREADY_UPDATED_TRUCK_STATUS_TODAY = new ApiError("ALREADY_UPDATED_TRUCK_STATUS_TODAY", details: "Você só pode atualizar a situação da carga uma vez por dia");
final ApiError CANNOT_GET_CURRENT_LOCATION_FOR_FREIGHT_SEARCH = new ApiError("CANNOT_GET_CURRENT_LOCATION_FOR_FREIGHT_SEARCH", details: "Não foi possível identificar a sua localização atual, por favor verifique se seu GPS está ligado");
final ApiError UNABLE_TO_FIND_FREIGHTS_NEAR_YOU = new ApiError("UNABLE_TO_FIND_FREIGHTS_NEAR_YOU", details: "Não foi possível encontrar fretes próximos a você, tente novamente mais tarde.");
final ApiError UNABLE_TO_FIND_FREIGHTS_YOUR_ORIGIN = new ApiError("UNABLE_TO_FIND_FREIGHTS_YOUR_ORIGIN", details: "Não foi possível encontrar fretes próximos ao destino selecionado, tente outro local.");