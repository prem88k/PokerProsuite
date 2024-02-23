import 'package:flutter/material.dart';
import '../Model/GetAllPlayerData.dart';

class MultiSelect extends StatefulWidget {
  final List<PlayerList> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];
  final List<String> _selectedIds = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected, String ids) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
        _selectedIds.add(ids.toString());

      } else {
        _selectedItems.remove(itemValue);
        _selectedIds.remove(ids.toString());

      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item.name!),
            checkColor: Colors.black,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item.name.toString(), isChecked!,item.id.toString()),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}