import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/loading-dialog.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu-food-table-info.dart';
import 'package:sandys_food_express/common/widgets/response-modal.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';
import 'package:sandys_food_express/screens/menu/screens/view_menu/view-menu.dart';

import 'package:sandys_food_express/screens/menu/widgets/menu-food-table.dart';
import 'package:sandys_food_express/screens/menu/widgets/add-food-modal.dart';

import 'package:sandys_food_express/constants.dart';

class Menu extends StatefulWidget {
  static final String routeName = '/menu';

  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  DateTime _scheduledDate = DateTime.now();
  TimeOfDay _scheduledTime = TimeOfDay.now();

  _selectScheduledDate(BuildContext context) async {
    final selectedScheduledDate = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: _scheduledDate,
      lastDate: DateTime(2100),
    );

    setState(() => _scheduledDate = selectedScheduledDate!);
  }

  _selectScheduleTime(BuildContext context) async {
    final selectedScheduledTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() => _scheduledTime = selectedScheduledTime!);
  }

  @override
  Widget build(BuildContext context) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
      ),
      width: double.maxFinite,
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: accentColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewMenu()));
                  },
                  child: Text(
                    'View Menu',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: accentColor,
                    padding: EdgeInsets.all(11),
                  ),
                  onPressed: () async {
                    showAnimatedDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) =>
                            ChangeNotifierProvider<MenuViewModel>.value(
                              value: menuViewModel,
                              child: AddFoodModal(),
                            ));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            MenuFoodTableInfo(),
            MenuFoodTable(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Date / Time',
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectScheduledDate(context),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd').format(_scheduledDate),
                        style: TextStyle(
                          color: subTextColor,
                        ),
                      ),
                      SizedBox(width: 14),
                      Icon(
                        Icons.event,
                        size: 16,
                        color: subTextColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => _selectScheduleTime(context),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: borderColor, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _scheduledTime.format(context),
                        style: TextStyle(
                          color: subTextColor,
                        ),
                      ),
                      SizedBox(width: 14),
                      Icon(
                        Icons.av_timer,
                        size: 16,
                        color: subTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              ),
              child: Text(
                'Add to Menu',
                style: TextStyle(
                  fontSize: 16,
                  color: accentColor,
                ),
              ),
              onPressed: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return LoadingDialog();
                  },
                );

                if (menuViewModel.selectedFoodIds.isEmpty) {
                  await showAnimatedDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return ResponseModal(
                        type: 'ERROR',
                        message: 'Please select atleast one food to scheduled',
                        onContinueOrCancel: () {
                          Navigator.of(context).pop(); // pop success add modal
                          Navigator.of(context).pop(); // pop add food modal
                        },
                      );
                    },
                  );
                  return;
                }

                DateTime completeScheduledDateTime = DateTime(
                  _scheduledDate.year,
                  _scheduledDate.month,
                  _scheduledDate.day,
                  _scheduledDate.hour,
                  _scheduledDate.minute,
                );

                await menuViewModel.createScheduledMenu(
                  menuViewModel.selectedFoodIds,
                  completeScheduledDateTime,
                );

                await showAnimatedDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return ResponseModal(
                      type: 'SUCCESS',
                      message: 'You have successfully created a scheduled menu',
                      onContinueOrCancel: () {
                        Navigator.of(context).pop(); // pop success add modal
                        Navigator.of(context).pop(); // pop add food modal
                      },
                    );
                  },
                );
                await menuViewModel.loadFoods();
              },
            ),
          ],
        ),
      ),
    );
  }
}
