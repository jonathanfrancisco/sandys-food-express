import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu-food-table-row.dart';

import '../../../constants.dart';

class MenuFoodTable extends StatefulWidget {
  final List<int> _selectedFoodIds;
  final Function _onMenuFoodTableRowSelectAllTogle;
  final Function _onMenuFoodTableRowSelectToggle;

  @override
  MenuFoodTableState createState() => MenuFoodTableState();

  MenuFoodTable({
    required List<int> selectedFoodIds,
    required Function onMenuFoodTableRowSelectAllToggle,
    required Function onMenuFoodTableRowSelectToggle,
  })   : _selectedFoodIds = selectedFoodIds,
        _onMenuFoodTableRowSelectAllTogle = onMenuFoodTableRowSelectAllToggle,
        _onMenuFoodTableRowSelectToggle = onMenuFoodTableRowSelectToggle;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: accentColor,
                            highlightColor: secondaryColor,
                            enabled: true,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  height: 16.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value: this.widget._selectedFoodIds.length ==
                          menuViewModel.foods.length,
                      onChanged: (bool? value) {
                        List<int> availableFoodIds =
                            menuViewModel.foods.map((food) {
                          return food['id'] as int;
                        }).toList();
                        this.widget._onMenuFoodTableRowSelectAllTogle(
                              availableFoodIds,
                            );
                      },
                    ),
                    Text(
                      '${menuViewModel.foods.length} items',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: TextField(
              controller: _searchFieldController,
              decoration: new InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.grey),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 1.0),
                ),
                hintText: 'Search here',
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Consumer<MenuViewModel>(
            builder: (context, menuViewModel, child) {
              if (menuViewModel.isMenuTableLoading) {
                return Expanded(
                  child: Shimmer.fromColors(
                    baseColor: accentColor,
                    highlightColor: secondaryColor,
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 48.0,
                              height: 48.0,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: 6,
                    ),
                  ),
                );
              }
              // not loading anymore
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
                          this.widget._selectedFoodIds.indexOf(food['id']) > -1;

                      return MenuFoodTableRow(
                        id: food['id'],
                        name: food['name'],
                        price: double.parse(food['price']),
                        picture: food['picture'],
                        onMenuFoodTableRowSelect:
                            this.widget._onMenuFoodTableRowSelectToggle,
                        isSelected: isSelected,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}