import 'package:hive/hive.dart';

class HiveHelper {
  static const notebox = "Note_box";
  static const notekey = "Note_key";

  static List<String> MyNotes = [];

  static Future<void> AddNote(String note) async {
    MyNotes.add(note);
    var box = Hive.box(notebox);
    await box.put(notekey, MyNotes);
  }

  static Future<void> GetMyNote() async {
    var box = Hive.box(notebox);
    MyNotes = List<String>.from(box.get(notekey, defaultValue: []));
  }

  static Future<void> RemoveNote(int i) async {
    MyNotes.removeAt(i);
    var box = Hive.box(notebox);
    await box.put(notekey, MyNotes);
  }

  static Future<void> RemoveAllNote() async {
    MyNotes.clear();
    var box = Hive.box(notebox);
    await box.put(notekey, MyNotes);
  }

  static Future<void> EditNote(int i, String t) async {
    MyNotes[i] = t;
    var box = Hive.box(notebox);
    await box.put(notekey, MyNotes);
  }
}
