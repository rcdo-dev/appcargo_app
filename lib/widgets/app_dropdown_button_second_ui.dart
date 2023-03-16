import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/enum.dart';
import 'package:app_cargo/widgets/app_sky_dropdown_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart' as sky;

class AppDropdownButtonSecondUI<T> extends StatelessWidget {
  final List<T> items;
  final Function onChanged;
  final OptionTitleResolver<T> resolver;
  final T currentItem;
  final bool createFriendlyFirstItem;
  final bool isExpanded;
  final bool isDense;
  final String friendlyFirstItemText;
  final bool enable;
  final double dropTextSize;
  final double dropIconSize;
  final double dropDownWidth;
  final double dropDownHeight;

  AppDropdownButtonSecondUI(
      {this.items = const [],
        this.resolver,
        this.onChanged,
        this.enable = true,
        this.currentItem,
        this.createFriendlyFirstItem = false,
        this.isExpanded = false,
        this.isDense = true,
        this.dropTextSize = 16,
        this.dropIconSize = 16,
        this.dropDownWidth,
        this.dropDownHeight,
        this.friendlyFirstItemText = "Escolha uma das opções..."})
      : assert(null != resolver);

  static AppDropdownButtonSecondUI<bool> yesOrNo({
    Function onChanged,
    bool currentItem,
    enable = true,
  }) {
    return AppDropdownButtonSecondUI<bool>(
      items: [true, false],
      resolver: (bool val) {
        if (val)
          return "Sim";
        else
          return "Não";
      },
      onChanged: onChanged,
      currentItem: currentItem,
      enable: enable,
    );
  }

  static AppDropdownButtonSecondUI<String> options(
      List<String> options, {
        Function onChanged,
        String currentItem,
        enable = true,
      }) {
    return AppDropdownButtonSecondUI<String>(
      items: options,
      resolver: (String val) {
        return val;
      },
      onChanged: onChanged,
      currentItem: currentItem,
    );
  }

  static AppDropdownButtonSecondUI<NamedEnum> enumerated(
      EnumHelper helper, {
        Function onChanged,
        NamedEnum currentItem,
        createFriendlyFirstItem = false,
        isExpanded = false,
        isDense = true,
        enable = true,
      }) {
    return AppDropdownButtonSecondUI<NamedEnum>(
      items: helper.values(),
      resolver: (NamedEnum en) => en.name(),
      onChanged: onChanged,
      currentItem: currentItem,
      isExpanded: isExpanded,
      isDense: isDense,
      createFriendlyFirstItem: createFriendlyFirstItem,
      enable: enable,
    );
  }

  static AppDropdownButtonSecondUI<String> addressState({
    Function onChanged,
    String currentItem,
    enable = true,
  }) {
    return AppDropdownButtonSecondUI<String>(
      items: [
        "",
        "AC",
        "AL",
        "AP",
        "AM",
        "BA",
        "CE",
        "DF",
        "ES",
        "GO",
        "MA",
        "MT",
        "MS",
        "MG",
        "PA",
        "PB",
        "PR",
        "PE",
        "PI",
        "RJ",
        "RN",
        "RS",
        "RO",
        "RR",
        "SC",
        "SP",
        "SE",
        "TO",
      ],
      resolver: (String stateAcronym) {
        return stateAcronym;
      },
      onChanged: onChanged,
      currentItem: currentItem,
    );
  }

  @override
  Widget build(BuildContext context) {

    if (enable) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.light_grey02,
            style: BorderStyle.solid,
            width: 1,
          ),
          color: AppColors.light_grey02,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.only(
          left: 12,
          top: 12,
          bottom: 12,
          right: 6,
        ),
        alignment: Alignment.centerLeft,
        child: AppSkyDropdownButtonSecondUI<T>(
          textColor: AppColors.dark_grey02,
          items: items,
          resolver: resolver,
          isExpanded: isExpanded,
          fontSize: dropTextSize,
          onChanged: onChanged,
          currentItem: currentItem,
          dropdownIconColor: AppColors.grey,
          friendlyFirstItemText: friendlyFirstItemText,
          createFriendlyFirstItem: createFriendlyFirstItem,
          dropDownWidth: MediaQuery.of(context).size.width,
          dropDownHeight: dropDownHeight ?? 30,
        ),
      );
    } else {
      T tempItem;
      for(T item in items){
        if(currentItem == item){
          tempItem = item;
          break;
        }
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.only(
          left: 12,
          top: 12,
          bottom: 12,
          right: 6,
        ),
        child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                sky.SkyText(
                  tempItem != null ? resolver(tempItem) : "Indisponivel",
                  textAlign: TextAlign.center,
                  textColor: AppColors.blue,
                  fontSize: 19,

                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.grey,
                  size: 25,
                ),
              ],
            )),
      );
    }
  }
}
