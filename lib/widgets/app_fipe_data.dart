import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/fipe_brand/fipe_brand.dart';
import 'package:app_cargo/domain/fipe_model_summary/fipe_model_summary.dart';
import 'package:app_cargo/domain/fipe_model_year_summary/fipe_model_year_summary.dart';
import 'package:app_cargo/domain/make_type.dart';
import 'package:app_cargo/services/fipe/fipe_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button_second_ui.dart';
import 'package:flutter/material.dart';

import 'app_dropdown_button.dart';
import 'app_loading_text.dart';
import 'app_text.dart';
import 'show_message_dialog.dart';

typedef OnBrandChangedCallback = void Function(FipeBrand);
typedef OnModelChangedCallback = void Function(FipeModelSummary);
typedef OnModelYearChangedCallback = void Function(FipeModelYearSummary);

typedef OnBrandListFetched = void Function(List<FipeBrand>);
typedef OnModelListFetched = void Function(List<FipeModelSummary>);
typedef OnModelYearListFetched = void Function(List<FipeModelYearSummary>);

class AppFipeData extends StatefulWidget {
  final OnBrandChangedCallback onBrandChanged;
  final OnModelChangedCallback onModelChanged;
  final OnModelYearChangedCallback onModelYearChanged;

  final OnBrandListFetched onFetchBrands;
  final OnModelListFetched onFetchModels;
  final OnModelYearListFetched onFetchModelYears;

  final FipeBrand selectedBrand;
  final FipeModelSummary selectedModel;
  final FipeModelYearSummary selectedModelYear;

  final List<FipeBrand> brands;
  final List<FipeModelSummary> models;
  final List<FipeModelYearSummary> modelYears;
  
  final bool enable;

  MakeType selectedMakeType;

  AppFipeData({
    Key key,
    this.onBrandChanged,
    this.onModelChanged,
    this.onModelYearChanged,
    this.onFetchBrands,
    this.onFetchModels,
    this.onFetchModelYears,
    this.selectedBrand,
    this.selectedModel,
    this.selectedModelYear,
    this.brands,
    this.models,
    this.modelYears,
    this.selectedMakeType,
    this.enable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppFipeDataState(
        onBrandChanged,
        onModelChanged,
        onModelYearChanged,
        selectedBrand,
        selectedModel,
        selectedModelYear,
        onFetchBrands,
        onFetchModels,
        onFetchModelYears,
        brands,
        models,
        modelYears,
      );
}

class _AppFipeDataState extends State<AppFipeData> {
  final FIPEService _fipeService = DIContainer().get<FIPEService>();

  final OnBrandChangedCallback onBrandChanged;
  final OnModelChangedCallback onModelChanged;
  final OnModelYearChangedCallback onModelYearChanged;

  final OnBrandListFetched onFetchBrands;
  final OnModelListFetched onFetchModels;
  final OnModelYearListFetched onFetchModelYears;

  FipeBrand selectedBrand;
  FipeModelSummary selectedModel;
  FipeModelYearSummary selectedModelYear;

  List<FipeBrand> brands;
  List<FipeModelSummary> models;
  List<FipeModelYearSummary> modelYears;

  bool _fetchFailed = false;

  _AppFipeDataState(
    this.onBrandChanged,
    this.onModelChanged,
    this.onModelYearChanged,
    this.selectedBrand,
    this.selectedModel,
    this.selectedModelYear,
    this.onFetchBrands,
    this.onFetchModels,
    this.onFetchModelYears,
    this.brands,
    this.models,
    this.modelYears,
  );

  @override
  Widget build(BuildContext context) {
    Widget brandWidget = Container(
      child: AppText.defaultText("Selecione um tipo de veículo.", fontSize: 14, textColor: AppColors.dark_grey02),
    );
    Widget modelWidget = Container(
      child: AppText.defaultText("Selecione uma marca.", fontSize: 14, textColor: AppColors.dark_grey02),
    );
    Widget modelYearWidget = Container(
      child: AppText.defaultText("Selecione um modelo.", fontSize: 14, textColor: AppColors.dark_grey02,),
    );

    if (null != this.brands && this.brands.isNotEmpty) {
      brandWidget = _buildBrandDropdown(this.brands, this.selectedBrand);

      if (null != this.modelYears && this.modelYears.isNotEmpty) {
        modelYearWidget =
            _buildModelYearDropdown(this.modelYears, this.selectedModelYear);

        if (null != this.models && this.models.isNotEmpty) {
          modelWidget = _buildModelDropdown(this.models, this.selectedModel);
        }
      }
    } else if (_fetchFailed) {
      brandWidget = AppText.errorText("Sem conexão com a internet...");
      modelWidget = AppText.errorText("Sem conexão com a internet...");
      modelYearWidget = AppText.errorText("Sem conexão com a internet...");
    } else if (null != widget.selectedMakeType) {
      this._fetchBrands();
    }

    Widget content = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: Dimen.vertical_padding),
                alignment: Alignment.centerLeft,
                child: AppText.defaultText(
                  "Marca",
                  bold: true,
                  textColor: AppColors.grey,
                  fontSize: 15,
                ),
              ),
              brandWidget,
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: Dimen.vertical_padding),
                alignment: Alignment.centerLeft,
                child: AppText.defaultText(
                  "Ano do Veículo",
                  bold: true,
                  textColor: AppColors.grey,
                  fontSize: 15,
                ),
              ),
              modelYearWidget,
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: Dimen.vertical_padding),
                alignment: Alignment.centerLeft,
                child: AppText.defaultText(
                  "Modelo",
                  bold: true,
                  textColor: AppColors.grey,
                  fontSize: 15,
                ),
              ),
              modelWidget,
            ],
          ),
        ),
      ],
    );

    return content;
  }

  void _fetchBrands() {
    _fipeService.getBrands(widget.selectedMakeType).then((brands) {
      if (this.onFetchBrands != null) this.onFetchBrands(brands);

      setState(() {
        this.brands = brands;
        this.selectedBrand = null;

        this.models = null;
        this.selectedModel = null;

        this.modelYears = null;
        this.selectedModelYear = null;
      });
    });
  }

  void _fetchModelYears(FipeBrand brand) {
    if (null != brand) {
      _fipeService.getModelYears(brand).then((years) {
        years.sort((a, b) => a.name.compareTo(b.name));

        setState(() {
          this.modelYears = years;
          this.selectedModelYear = null;

          this.models = null;
          this.selectedModel = null;
        });

        if (this.onFetchModelYears != null) this.onFetchModelYears(years);
      }).catchError(_handleFetchError);
    }
  }

  void _fetchModels(FipeBrand brand, FipeModelYearSummary modelYear) {
    if (null != brand && null != modelYear) {
      _fipeService.getModels(brand, modelYear).then((models) {
        if (this.onFetchModels != null) this.onFetchModels(models);

        setState(() {
          this.models = models;
          this.selectedModel = null;
        });
      }).catchError(_handleFetchError);
    }
  }

  void onBrandSelected(FipeBrand brand) {
    if (onBrandChanged != null) onBrandChanged(brand);

    setState(() {
      this.selectedBrand = brand;
      this.models = null;
      this.selectedModel = null;
      this.modelYears = null;
      this.selectedModelYear = null;
    });

    _fetchModelYears(selectedBrand);
  }

  void onModelSelected(FipeModelSummary model) {
    if (onModelChanged != null) onModelChanged(model);

    setState(() {
      this.selectedModel = model;
    });
  }

  void onModelYearSelected(FipeModelYearSummary year) {
    if (onModelYearChanged != null) onModelYearChanged(year);

    setState(() {
      this.selectedModelYear = year;
      this.models = null;
      this.selectedModel = null;
    });

    _fetchModels(selectedBrand, year);
  }

  Widget _buildBrandDropdown(List<FipeBrand> brands, FipeBrand selectedBrand) =>
      AppDropdownButtonSecondUI<FipeBrand>(
        items: brands,
        resolver: (FipeBrand brand) => brand.name,
        createFriendlyFirstItem: true,
        currentItem: selectedBrand,
        onChanged: (FipeBrand brand) {
          onBrandSelected(brand);
        },
        enable: widget.enable,
        dropTextSize: 15,
        dropIconSize: 17,
        dropDownWidth: 20,
      );

  Widget _buildModelDropdown(
          List<FipeModelSummary> models, FipeModelSummary selectedModel) =>
      AppDropdownButtonSecondUI<FipeModelSummary>(
        items: models,
        resolver: (FipeModelSummary model) => model.name,
        createFriendlyFirstItem: true,
        currentItem: selectedModel,
        onChanged: (FipeModelSummary model) {
          onModelSelected(model);
        },
        enable: widget.enable,
      );

  Widget _buildModelYearDropdown(List<FipeModelYearSummary> years,
          FipeModelYearSummary selectedModelYear) =>
      AppDropdownButtonSecondUI<FipeModelYearSummary>(
        items: years,
        resolver: (FipeModelYearSummary year) => year.name,
        createFriendlyFirstItem: true,
        currentItem: selectedModelYear,
        onChanged: (FipeModelYearSummary year) {
          onModelYearSelected(year);
        },
        enable: widget.enable,
      );

  void _handleFetchError(error) {
    print(error);
    setState(() {
      this._fetchFailed = true;
    });

    showMessageDialog(
      context,
      message: "É preciso estar conectado à internet para continuar.",
    );
  }
}
