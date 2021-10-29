import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/response-modal.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';

import 'package:sandys_food_express/screens/menu/widgets/menu-food-table-header-loading.dart';
import 'package:sandys_food_express/screens/menu/widgets/search-bar.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu-food-table-loading.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu-food-table-row.dart';
import 'package:sandys_food_express/constants.dart';

class MenuFoodTable extends StatefulWidget {
  @override
  MenuFoodTableState createState() => MenuFoodTableState();
}

class MenuFoodTableState extends State<MenuFoodTable> {
  final _searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onSearchChanged(String query) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);
    EasyDebounce.debounce(
      'search-field-debouncer',
      Duration(milliseconds: 500),
      () async => await menuViewModel.loadFoods(
        query: _searchFieldController.text,
      ),
    );
  }

  _onMenuFoodTableRowDelete(int foodId) async {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);
    bool isDeleted = await menuViewModel.deleteFood(foodId);
    if (!isDeleted) {
      showAnimatedDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return ResponseModal(
            type: 'ERROR',
            message: menuViewModel.errorMessage,
            onContinueOrCancel: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
    await menuViewModel.loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);
    menuViewModel.loadFoods();

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 23,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            child: Consumer<MenuViewModel>(
              builder: (context, menuViewModel, child) {
                if (menuViewModel.isMenuTableLoading) {
                  return MenuFoodTableHeaderLoading();
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value: menuViewModel.selectedFoodIds.length ==
                          menuViewModel.foods.length,
                      onChanged: (bool? value) {
                        List<int> availableFoodIds =
                            menuViewModel.foods.map((food) {
                          return food.id;
                        }).toList();
                        menuViewModel.onMenuFoodTableRowSelectAllToggle(
                            availableFoodIds);
                      },
                    ),
                    Text(
                      '${menuViewModel.foods.length} items',
                      style: TextStyle(),
                    )
                  ],
                );
              },
            ),
          ),
          SearchBar(
            searchFieldController: _searchFieldController,
            onSearchChanged: _onSearchChanged,
          ),
          Consumer<MenuViewModel>(
            builder: (context, menuViewModel, child) {
              if (menuViewModel.isMenuTableLoading) {
                return MenuFoodTableLoading();
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await menuViewModel.loadFoods();
                    },
                    child: ListView.builder(
                      itemCount: menuViewModel.foods.length,
                      itemBuilder: (context, index) {
                        var food = menuViewModel.foods[index];
                        bool isSelected =
                            menuViewModel.selectedFoodIds.indexOf(food.id) > -1;

                        return MenuFoodTableRow(
                          food: food,
                          onMenuFoodTableRowSelect:
                              menuViewModel.onMenuFoodTableRowSelectToggle,
                          onMenuFoodTableRowDelete: () =>
                              _onMenuFoodTableRowDelete(food.id),
                          hasActions: true,
                          isSelected: isSelected,
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
