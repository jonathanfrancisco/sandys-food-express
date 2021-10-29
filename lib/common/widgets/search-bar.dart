import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchFieldController;
  final Function _onSearchChanged;

  SearchBar({
    required TextEditingController searchFieldController,
    required Function onSearchChanged,
  })  : _searchFieldController = searchFieldController,
        _onSearchChanged = onSearchChanged;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: TextField(
        style: TextStyle(),
        controller: _searchFieldController,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(10),
          suffixIconConstraints: BoxConstraints(
            minHeight: 35,
            minWidth: 40,
          ),
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
        onChanged: (String value) => _onSearchChanged,
      ),
    );
  }
}
