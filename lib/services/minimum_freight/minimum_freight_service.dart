import 'package:app_cargo/domain/minimum_freight/minimum_freight_load_type.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_truck_axles.dart';
import 'package:app_cargo/domain/minimum_freight/minimum_freight_type.dart';

class MinimumFreightService {
  /* Map<loadType, Map<axles, cost> */

  // lotation (TRANSPORTE RODOVIÁRIO DE CARGA LOTAÇÃO)
  Map<MinimumFreightLoadType, Map<int, double>> lotationDisplacementCostMap = Map<MinimumFreightLoadType, Map<int, double>>();
  Map<MinimumFreightLoadType, Map<int, double>> lotationLoadAndUnloadCostMap = Map<MinimumFreightLoadType, Map<int, double>>();

  // just load vehicle (OPERAÇÕES EM QUE HAJA A CONTRATAÇÃO APENAS DO VEÍCULO AUTOMOTOR DE CARGAS)
  Map<MinimumFreightLoadType, Map<int, double>> loadVehicleDisplacementCostMap = Map<MinimumFreightLoadType, Map<int, double>>();
  Map<MinimumFreightLoadType, Map<int, double>> loadVehicleLoadAndUnloadCostMap = Map<MinimumFreightLoadType, Map<int, double>>();

  MinimumFreightService() {
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][2] =
        2.0591;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][3] =
        2.5746;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][4] =
        3.0295;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][5] =
        3.3706;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][6] =
        3.8548;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][7] =
        4.1427;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][9] =
        4.7354;

    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][2] =
        2.0953;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][3] =
        2.6209;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][4] =
        3.0531;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][5] =
        3.4479;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][6] =
        3.9320;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][7] =
        4.2594;
    lotationDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][9] =
        4.8514;

    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][2] =
        2.4572;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][3] =
        3.0543;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][4] =
        3.6106;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][5] =
        4.1140;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][6] =
        4.6621;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][7] =
        4.9349;
    lotationDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][9] =
        5.6236;

    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][2] =
        null;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][3] =
        2.5622;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][4] =
        3.0233;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][5] =
        3.3688;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][6] =
        3.8529;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][7] =
        4.1434;
    lotationDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][9] =
        4.7293;

    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][2] = 2.0524;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][3] = 2.5622;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][4] = 3.0233;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][5] = 3.3688;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][6] = 3.8529;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][7] = 4.1434;
    lotationDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][9] = 4.7293;

    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][2] = 1.8658;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][3] = 2.5622;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][4] = 3.0406;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][5] = 3.3688;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][6] = 3.8529;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][7] = 4.1434;
    lotationDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][9] = 4.7293;

    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO] =
        Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [2] = 2.6073;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [3] = 3.1228;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [4] = 3.6095;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [5] = 3.9507;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [6] = 4.4348;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [7] = 4.7316;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [9] = 5.3243;

    lotationDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [2] = 2.6628;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [3] = 3.1884;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [4] = 3.6376;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [5] = 4.0323;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [6] = 4.5164;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [7] = 4.8526;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [9] = 5.4447;

    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA] =
        Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [2] = 2.8846;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [3] = 3.4817;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [4] = 4.0650;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [5] = 4.5683;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [6] = 5.1164;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [7] = 5.4007;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [9] = 6.0894;

    lotationDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [2] = null;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [3] = 2.8218;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [4] = 3.3147;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [5] = 3.6602;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [6] = 4.1443;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [7] = 4.4436;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [9] = 5.0295;

    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL] = Map();
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [2] = 2.3119;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [3] = 2.8218;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [4] = 3.3147;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [5] = 3.6602;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [6] = 4.1443;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [7] = 4.4436;
    lotationDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [9] = 5.0295;

    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA] = Map();
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][2] = null;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][3] = null;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][4] = null;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][5] = 3.5334;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][6] = 4.0175;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][7] = null;
    lotationDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][9] = 4.9729;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][2] =
        220.10;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][3] =
        250.34;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][4] =
        285.45;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][5] =
        293.35;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][6] =
        333.21;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][7] =
        356.74;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][9] =
        391.57;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][2] =
        225.94;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][3] =
        258.97;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][4] =
        283.75;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][5] =
        306.39;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][6] =
        346.25;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][7] =
        380.62;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][9] =
        415.28;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][2] =
        257.99;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][3] =
        289.07;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][4] =
        336.91;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][5] =
        373.94;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][6] =
        413.79;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][7] =
        433.15;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][9] =
        472.89;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][2] =
        null;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][3] =
        246.93;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][4] =
        283.75;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][5] =
        292.84;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][6] =
        332.70;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][7] =
        356.91;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][9] =
        389.88;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][2] =
        218.24;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][3] =
        246.93;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][4] =
        283.75;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][5] =
        292.84;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][6] =
        332.70;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][7] =
        356.91;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][9] =
        389.88;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][2] = 224.32;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][3] = 246.93;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][4] = 288.49;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][5] = 292.84;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][6] = 332.70;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][7] = 356.91;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][9] = 389.88;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [2] = 327.32;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [3] = 357.55;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [4] = 399.12;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [5] = 407.03;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [6] = 446.89;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [7] = 472.85;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO]
        [9] = 507.68;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [2] = 342.57;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [3] = 375.60;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [4] = 406.84;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [5] = 429.48;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [6] = 469.34;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [7] = 506.14;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO]
        [9] = 540.80;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [2] = 335.25;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [3] = 366.34;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [4] = 422.57;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [5] = 459.59;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [6] = 499.45;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [7] = 521.97;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA]
        [9] = 561.70;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [2] = null;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [3] = 316.03;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [4] = 359.31;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [5] = 368.40;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [6] = 408.26;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [7] = 434.89;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA]
        [9] = 467.86;

    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL] = Map();
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][2] =
        287.33;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][3] =
        316.03;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][4] =
        359.31;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][5] =
        368.40;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][6] =
        408.26;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][7] =
        434.89;
    lotationLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL][9] =
        467.86;

    lotationLoadAndUnloadCostMap[
    MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA] = Map();
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][2] = null;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][3] = null;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][4] = null;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][5] = 338.12;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][6] = 377.98;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][7] = null;
    lotationLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][9] = 456.90;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][2] =
        2.0265;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][3] =
        2.5327;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][4] =
        2.7768;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][5] =
        3.0210;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][6] =
        3.5051;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][7] =
        3.6626;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][9] =
        4.0337;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][2] =
        2.0414;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][3] =
        2.5476;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][4] =
        2.8066;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][5] =
        3.0508;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][6] =
        3.5350;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][7] =
        3.6924;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][9] =
        4.0635;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][2] =
        2.3858;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][3] =
        2.9706;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][4] =
        3.2933;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][5] =
        3.5938;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][6] =
        4.1419;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][7] =
        4.3082;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.FRIGORIFICADA][9] =
        4.7575;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][2] =
        null;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][3] =
        2.5327;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][4] =
        2.7768;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][5] =
        3.0210;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][6] =
        3.5051;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][7] =
        3.6626;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CONTEINERIZADA][9] =
        4.0337;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][2] =
        2.0265;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][3] =
        2.5327;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][4] =
        2.7768;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][5] =
        3.0210;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][6] =
        3.5051;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][7] =
        3.6626;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.CARGA_GERAL][9] =
        4.0337;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][2] =
        1.8179;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][3] =
        2.5327;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][4] =
        2.7768;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][5] =
        3.0210;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][6] =
        3.5051;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][7] =
        3.6626;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.NEOGRANEL][9] =
        4.0337;

    loadVehicleDisplacementCostMap[
    MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO] = Map();
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][2] = 2.5747;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][3] = 3.0809;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][4] = 3.3568;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][5] = 3.6010;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][6] = 4.0852;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][7] = 4.2515;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][9] = 4.6226;

    loadVehicleDisplacementCostMap[
    MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO] = Map();
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][2] = 2.6089;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][3] = 3.1152;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][4] = 3.3911;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][5] = 3.6353;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][6] = 4.1194;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][7] = 4.2857;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][9] = 4.6568;

    loadVehicleDisplacementCostMap[
    MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA] = Map();
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][2] = 2.8131;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][3] = 3.3980;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][4] = 3.7476;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][5] = 4.0481;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][6] = 4.5963;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][7] = 4.7740;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][9] = 5.2233;

    loadVehicleDisplacementCostMap[
    MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA] = Map();
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][2] = null;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][3] = 2.7923;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][4] = 3.0682;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][5] = 3.3124;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][6] = 3.7965;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][7] = 3.9628;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][9] = 4.3339;

    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL] = Map();
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [2] = 2.2861;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [3] = 2.7923;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [4] = 3.0682;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [5] = 3.3124;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [6] = 3.7965;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [7] = 3.9628;
    loadVehicleDisplacementCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [9] = 4.3339;

    loadVehicleDisplacementCostMap[
    MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA] = Map();
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][2] = null;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][3] = null;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][4] = null;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][5] = 3.0210;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][6] = 3.5051;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][7] = null;
    loadVehicleDisplacementCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][9] = 4.0337;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][2] =
        211.13;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][3] =
        238.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][4] =
        258.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][5] =
        260.41;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][6] =
        300.27;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][7] =
        308.98;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_SOLIDO][9] =
        325.02;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][2] =
        211.13;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][3] =
        238.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][4] =
        258.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][5] =
        260.41;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][6] =
        300.27;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][7] =
        308.98;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.GRANEL_LIQUIDO][9] =
        325.02;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][2] =
        238.35;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][3] =
        266.05;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][4] =
        291.78;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][5] =
        294.10;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][6] =
        333.95;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][7] =
        345.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.FRIGORIFICADA][9] =
        361.13;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][2] =
        null;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][3] =
        238.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][4] =
        258.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][5] =
        260.41;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][6] =
        300.27;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][7] =
        308.98;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CONTEINERIZADA][9] =
        325.02;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][2] =
        211.13;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][3] =
        238.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][4] =
        258.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][5] =
        260.41;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][6] =
        300.27;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][7] =
        308.98;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.CARGA_GERAL][9] =
        325.02;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][2] =
        211.13;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][3] =
        238.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][4] =
        258.09;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][5] =
        260.41;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][6] =
        300.27;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][7] =
        308.98;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.NEOGRANEL][9] =
        325.02;

    loadVehicleLoadAndUnloadCostMap[
    MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO] = Map();
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][2] = 318.34;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][3] = 346.04;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][4] = 371.77;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][5] = 374.09;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][6] = 413.95;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][7] = 425.08;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_SOLIDO][9] = 441.12;

    loadVehicleLoadAndUnloadCostMap[
    MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO] = Map();
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][2] = 327.76;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][3] = 355.46;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][4] = 381.19;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][5] = 383.50;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][6] = 423.36;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][7] = 434.50;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_GRANEL_LIQUIDO][9] = 450.54;

    loadVehicleLoadAndUnloadCostMap[
    MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA] = Map();
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][2] = 315.601;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][3] = 343.31;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][4] = 377.44;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][5] = 379.75;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][6] = 419.61;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][7] = 433.91;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_FRIGORIFICADA][9] = 449.94;

    loadVehicleLoadAndUnloadCostMap[
    MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA] = Map();
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][2] = null;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][3] = 307.92;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][4] = 333.65;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][5] = 335.97;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][6] = 375.82;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][7] = 386.96;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.PERIGOSA_CONTEINERIZADA][9] = 403.00;

    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL] = Map();
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [2] = 280.22;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [3] = 307.92;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [4] = 333.65;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [5] = 335.97;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [6] = 375.82;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [7] = 386.96;
    loadVehicleLoadAndUnloadCostMap[MinimumFreightLoadType.PERIGOSA_CARGA_GERAL]
        [9] = 403.00;

    loadVehicleLoadAndUnloadCostMap[
    MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA] = Map();
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][2] = null;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][3] = null;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][4] = null;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][5] = 260.41;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][6] = 300.27;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][7] = null;
    loadVehicleLoadAndUnloadCostMap[
        MinimumFreightLoadType.CARGA_GRANEL_PRESSURIZADA][9] = 325.02;
  }

  double getDisplacementCost(MinimumFreightType type,
      MinimumFreightLoadType loadType, MinimumFreightTruckAxles truckAxles) {
    if (type == null || loadType == null || truckAxles == null) {
      return null;
    }
    if (type == MinimumFreightType.LOTATION) {
      return lotationDisplacementCostMap[loadType]
          [int.parse(truckAxles.name().trim())];
    } else if (type == MinimumFreightType.LOAD_VEHICLE) {
      return loadVehicleDisplacementCostMap[loadType]
          [int.parse(truckAxles.name().trim())];
    }
  }

  double getLoadAndUnloadCost(MinimumFreightType type,
      MinimumFreightLoadType loadType, MinimumFreightTruckAxles truckAxles) {
    if (type == null || loadType == null || truckAxles == null) {
      return null;
    }
    if (type == MinimumFreightType.LOTATION) {
      return lotationLoadAndUnloadCostMap[loadType]
          [int.parse(truckAxles.name().trim())];
    } else if (type == MinimumFreightType.LOAD_VEHICLE) {
      return loadVehicleLoadAndUnloadCostMap[loadType]
          [int.parse(truckAxles.name().trim())];
    }
  }
}
