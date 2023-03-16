import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/city/city.dart';
import 'package:app_cargo/screens/financing/widgets/app_state_dropdown_button.dart';
import 'package:app_cargo/services/util/util_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_text.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppFormCityStateDropdown extends StatefulWidget {
  final Function onStateChanged;
  final Function onCityChanged;
  final String defaultState;
  final bool showCitySelect;
  final bool showCityAutocomplete;
  final Function cacheCities;
  City defaultCity;

  AppFormCityStateDropdown({
    Key key,
    this.onStateChanged,
    this.onCityChanged,
    this.defaultState,
    this.defaultCity,
    this.cacheCities,
    this.showCitySelect = false,
    this.showCityAutocomplete = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppFormCityStateDropdown();
}

class _AppFormCityStateDropdown extends State<AppFormCityStateDropdown> {
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
    _firstCity = widget.defaultCity.name;
    _buildStates();
  }

  @override
  Widget build(BuildContext context) {
    if (_firstCity != widget.defaultCity.name && !_reloadWidget) {
      statesWidget = Container();
      _buildStates();
      _reloadWidget = true;
    }

    cityWidget = Column(
      children: <Widget>[
        citiesWidget,
      ],
    );

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[statesWidget, Flexible(flex: 11, child: cityWidget)],
      ),
    );
  }

  void _buildStates() {
    if (widget.defaultState != null && widget.defaultState != "")
      _buildCities(widget.defaultState);
    _onStateChanged(widget.defaultState);
    setState(() {
      statesWidget = Flexible(
        flex: 3,
        child: Container(
          height: 43,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.light_grey,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: AppStateDropdownButton.addressState(
            onChanged: (String stateAcronym) {
              _onStateChanged(stateAcronym);
              if (stateAcronym != null && stateAcronym.isNotEmpty) {
                _buildCities(stateAcronym);
              }
            },
            currentItem: widget.defaultState,
          ),
        ),
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

      City selectedCity;
      if (widget.defaultCity != null) {
        for (City curCity in cities) {
          if (curCity.name == widget.defaultCity.name) {
            selectedCity = curCity;
          }
        }

        setState(() {

          print("get City: ${City.toJson(selectedCity)}");
          widget.onCityChanged(selectedCity);
        });
      }

      setState(() {
        if (widget.showCitySelect) {
          citiesWidget = AppDropdownButton<City>(
            items: cities,
            createFriendlyFirstItem: true,
            onChanged: (City city) {
              _onCityChanged(city);
            },
            resolver: (City city) => city.name,
            currentItem: selectedCity,
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
      citiesWidget = Container(
        height: 43,
        margin: EdgeInsets.only(left: 10, bottom: 5),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: AppColors.light_grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AutoCompleteTextField<City>(
          key: keyAutoSelect,
          suggestions: cities,
          style: new TextStyle(color: AppColors.black, fontSize: 16.5),
          decoration: new InputDecoration(
            // fillColor: AppColors.light_grey, filled: true,
            border: InputBorder.none,
            // contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                fontSize: 15,
                textAlign: TextAlign.start,
                textColor: AppColors.black,
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
        ),
      );
    });
  }
}
