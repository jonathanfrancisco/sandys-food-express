import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/menu-food-table-header-loading.dart';
import 'package:sandys_food_express/common/widgets/menu-food-table-loading.dart';
import 'package:sandys_food_express/common/widgets/menu-food-table-row.dart';
import 'package:sandys_food_express/common/widgets/search-bar.dart';

import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/models/Food.dart';
import 'package:sandys_food_express/screens/orders/orders-tab-add-order-view-model.dart';

class OrderMenuTable extends StatefulWidget {
  @override
  OrderMenuTableState createState() => OrderMenuTableState();
}

class OrderMenuTableState extends State<OrderMenuTable> {
  final _searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _onSearchChanged(String query) {
    OrdersTabAddOrderViewModel ordersTabAddOrderViewModel =
        Provider.of<OrdersTabAddOrderViewModel>(context, listen: false);
    EasyDebounce.debounce(
      'search-field-debouncer',
      Duration(milliseconds: 500),
      () async => await ordersTabAddOrderViewModel.loadFoods(
        query: _searchFieldController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    OrdersTabAddOrderViewModel ordersTabAddOrderViewModel =
        Provider.of<OrdersTabAddOrderViewModel>(context, listen: false);
    ordersTabAddOrderViewModel.loadFoods();

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
            child: Consumer<OrdersTabAddOrderViewModel>(
              builder: (context, ordersTabAddOrderViewModel, child) {
                if (ordersTabAddOrderViewModel.isOrderMenuTableLoading) {
                  return MenuFoodTableHeaderLoading();
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value:
                          ordersTabAddOrderViewModel.selectedFoodIds.length ==
                              ordersTabAddOrderViewModel.availableFoodsCount,
                      onChanged: (bool? value) {
                        List<int> availableFoodIds = ordersTabAddOrderViewModel
                            .foods
                            .where((food) => food.isAvailableToday == true)
                            .map((food) {
                          return food.id;
                        }).toList();
                        ordersTabAddOrderViewModel
                            .onMenuFoodTableRowSelectAllToggle(
                                availableFoodIds);
                      },
                    ),
                    Text(
                      '${ordersTabAddOrderViewModel.availableFoodsCount} items',
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
          Consumer<OrdersTabAddOrderViewModel>(
            builder: (context, ordersTabAddOrderViewModel, child) {
              if (ordersTabAddOrderViewModel.isOrderMenuTableLoading) {
                return MenuFoodTableLoading();
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await ordersTabAddOrderViewModel.loadFoods();
                    },
                    child: ListView.builder(
                      itemCount: ordersTabAddOrderViewModel.foods.length,
                      itemBuilder: (context, index) {
                        Food food = ordersTabAddOrderViewModel.foods[index];
                        bool isSelected = ordersTabAddOrderViewModel
                                .selectedFoodIds
                                .indexOf(food.id) >
                            -1;
                        return MenuFoodTableRow(
                          food: food,
                          onMenuFoodTableRowSelect: ordersTabAddOrderViewModel
                              .onMenuFoodTableRowSelectToggle,
                          onMenuFoodTableRowDelete: () => {},
                          hasActions: false,
                          isSelected: isSelected,
                          isDisabled: food.isAvailableToday ? false : true,
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
