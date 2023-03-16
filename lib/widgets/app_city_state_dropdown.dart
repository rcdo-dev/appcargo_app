import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/services/util/util_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import 'app_loading_text.dart';

class AppCityStateDropdown extends StatefulWidget {
  final Function onStateChanged;
  final Function onCityChanged;
  final Function(City) checkText;
  final String defaultState;
  final bool showCitySelect;
  final bool showCityAutocomplete;
  final Function cacheCities;
  City defaultCity;

  AppCityStateDropdown({
    Key key,
    this.onStateChanged,
    this.onCityChanged,
    this.checkText,
    this.defaultState,
    this.defaultCity,
    this.cacheCities,
    this.showCitySelect = false,
    this.showCityAutocomplete = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppCityStateDropdown();
}

class _AppCityStateDropdown extends State<AppCityStateDropdown> {
  final GlobalKey<AutoCompleteTextFieldState<City>> keyAutoSelect =
      new GlobalKey();
  final UtilService _utilService = DIContainer().get<UtilService>();
  final TextEditingController autoCompleteController =
      new TextEditingController();
  List<City> cities = new List<City>();

  Widget citiesWidget;
  Widget statesWidget;
  Widget cityWidget = Container();
  String _firstCity;
  bool _reloadWidget = false;

  @override
  void initState() {
    super.initState();
    if (widget.showCitySelect) {
      citiesWidget = Container(
        child: AppDropdownButton<City>(
          items: [],
          createFriendlyFirstItem: true,
          friendlyFirstItemText: "Selecione um estado...",
          resolver: (city) => city.name,
        ),
      );
    }

    if (widget.showCityAutocomplete) {
      _buildCitiesAutoComplete();
    }

    if (widget.defaultCity != null) {
      _firstCity = widget.defaultCity.name;
    }
    _buildStates();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.defaultCity != null) {
      if (_firstCity != widget.defaultCity.name && !_reloadWidget) {
        statesWidget = Container();
        _buildStates();
        _reloadWidget = true;
      }
    }

    cityWidget = Expanded(
      flex: 11,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimen.vertical_padding,
              ),
              child: SkyText(
                "Cidade",
                fontSize: 16,
                textColor: AppColors.blue,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              child: citiesWidget,
            ),
          ],
        ),
      ),
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(
                right: Dimen.horizontal_padding - 5,
              ),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding,
                    ),
                    child: SkyText(
                      "Estado",
                      fontSize: 16,
                      textColor: AppColors.blue,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    child: statesWidget,
                  ),
                ],
              ),
            ),
          ),
          cityWidget,
        ],
      ),
    );
  }

  void _buildStates() {
    if (widget.defaultState != null && widget.defaultState != "")
      _buildCities(widget.defaultState);
    _onStateChanged(widget.defaultState);
    setState(() {
      statesWidget = AppDropdownButton.addressState(
        onChanged: (String stateAcronym) {
          _onStateChanged(stateAcronym);
          if (stateAcronym != null && stateAcronym.isNotEmpty) {
            _buildCities(stateAcronym);
          }
        },
        //TODO: CHANGE THIS DROPDOWNBUTTON WIDGET STATE
        currentItem: widget.defaultState,
      );
    });
  }

  void _buildCities(String stateAcronym) {
    setState(() {
      citiesWidget = AppLoadingText();
    });
    _utilService.getCities(stateAcronym).then((List<City> cities) {
      if (widget.cacheCities != null) widget.cacheCities(cities);
      this.cities = cities;

      // City selectedCity = this.cities.first;

      // setState(() {
      // widget.defaultCity = selectedCity;
      // widget.onCityChanged(selectedCity);
      // });

      // if (widget.defaultCity != null) {
      //   for (City curCity in cities) {
      //     if (curCity.name == widget.defaultCity.name) {
      //       selectedCity = curCity;
      //     }
      //   }
      //   setState(() {
      //     widget.onCityChanged(selectedCity);
      //   });
      // }

      setState(() {
        if (widget.showCitySelect) {
          citiesWidget = AppDropdownButton<City>(
            items: cities,
            createFriendlyFirstItem: true,
            onChanged: (City city) {
              _onCityChanged(city);
            },
            resolver: (City city) => city.name,
            // currentItem: selectedCity,
          );
        } else {
          _buildCitiesAutoComplete();
        }
      });
    });
  }

  void _onCityChanged(City city) {
    if (null != widget.onCityChanged) {
      if (city != null) {
        widget.onCityChanged(city.hash == "" ? null : city);
      }
    }
  }

  void _onStateChanged(String stateAcronym) {
    if (null != widget.onStateChanged) {
      widget.onStateChanged(stateAcronym == "" ? null : stateAcronym);
    }
  }

  void _buildCitiesAutoComplete() {
    setState(() {
      citiesWidget = AutoCompleteTextField<City>(
        key: keyAutoSelect,
        suggestions: cities,
        style: new TextStyle(color: AppColors.blue, fontSize: 17.0),
        decoration: new InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          hintText: widget.defaultCity != null
              ? widget.defaultCity.name
              : 'Procurar por cidade',
          hintStyle: TextStyle(color: AppColors.dark_grey),
        ),
        itemBuilder: (context, item) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimen.horizontal_padding,
                vertical: Dimen.vertical_padding),
            child: SkyText(
              item.name,
              fontSize: 17,
              textAlign: TextAlign.start,
              textColor: AppColors.blue,
            ),
          );
        },
        itemFilter: (item, query) {
          return item.name.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.name.compareTo(b.name);
        },
        itemSubmitted: (item) {
          setState(() {
            widget.defaultCity = item;
            widget.onCityChanged(item);
            citiesWidget = Container();
            Future.delayed(Duration(milliseconds: 100), () {
              _buildCitiesAutoComplete();
            });
          });
        },
        controller: autoCompleteController,

        /// Chamada do método a cada mudança no texto.
        textChanged: (_) => _checkCityByText(),
      );
    });
  }

  /// Este método verifica se a cidade digitada pelo usuário
  /// existe na lista de cidades da aplicação. Se existir,
  /// o elemento é passado como parâmetro para a classe pai.
  void _checkCityByText() {
    cities.forEach((element) {
      if (element.name.toUpperCase() ==
          autoCompleteController.text.toUpperCase()) {
        widget.checkText(element);
      }
    });
  }
}
