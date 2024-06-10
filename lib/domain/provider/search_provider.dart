import 'package:flutter/material.dart';
import 'package:todo_list/domain/database/hive_box.dart';
import 'package:todo_list/domain/database/notes_data.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider() {
    filtredNotes = allNotes;
    searchcontroller.addListener(search);
  }
  final searchcontroller = TextEditingController();
  var filtredNotes = <NotesData>[];
  final allNotes = HiveBox.notes.values.toList();
  void search() {
    final query = searchcontroller.text;
    if (query.isNotEmpty) {
      filtredNotes = allNotes
          .where(
            (value) =>
                value.title!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                value.text!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      notifyListeners();
    } else {
      filtredNotes = allNotes;
      notifyListeners();
    }
  }
}
