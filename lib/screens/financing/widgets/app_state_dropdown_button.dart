import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/widgets/app_sky_dropdown_button_second_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppStateDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final Function onChanged;
  final T currentItem;
  final bool createFriendlyFirstItem;
  final bool isExpanded;
  final bool isDense;
  final String friendlyFirstItemText;
  final bool enable;
  final Color textColor;

  const AppStateDropdownButton(
      {this.items = const [],
      // this.resolver,
      this.onChanged,
      this.enable = true,
      this.currentItem,
      this.createFriendlyFirstItem = false,
      this.isExpanded = false,
      this.isDense = true,
      this.friendlyFirstItemText = "Selecione...",
      this.textColor = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.only(
        left: 12,
        top: 12,
        bottom: 12,
        right: 6,
      ),
      child: SkyDropdownButton<T>(
        textColor: textColor,
        dropdownIconColor: AppColors.black,
        items: items,
        isExpanded: isExpanded,
        fontSize: 16,
        onChanged: onChanged,
        currentItem: currentItem,
        friendlyFirstItemText: friendlyFirstItemText,
        createFriendlyFirstItem: createFriendlyFirstItem,
      ),
    );
  }

  static AppStateDropdownButton addressState({
    Function onChanged,
    String currentItem,
    enable = true,
    isExpanded = false,
  }) {
    return AppStateDropdownButton(
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
      onChanged: onChanged,
      currentItem: currentItem,
      isExpanded: isExpanded,
    );
  }
}
