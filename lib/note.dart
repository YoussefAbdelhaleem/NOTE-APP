import 'hive_helper.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  var MyNotes = HiveHelper.MyNotes;
  @override
  Widget build(BuildContext context) {
    final _textEditingController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add a new Note'),
                  content: TextField(
                    controller: _textEditingController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Enter the text of note",
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                        _textEditingController.text = "";
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        Navigator.pop(context);
                        HiveHelper.AddNote(_textEditingController.text);
                        _textEditingController.text = "";
                        setState(() {});
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),

        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "NoteApp",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                HiveHelper.RemoveAllNote();
                setState(() {});
              },
              child: Icon(Icons.delete_forever, color: Colors.red, size: 30),
            ),
            SizedBox(width: 15),
          ],
        ),
        body: ListView.builder(
          itemCount: MyNotes.length,
          itemBuilder: (context, index) => NoteItem(index),
        ),
      ),
    );
  }

  Widget NoteItem(int i) {
    var _textEditingController = TextEditingController();
    return InkWell(
      onTap: () async {
        _textEditingController.text = MyNotes[i];
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('update a Note'),
              content: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Enter the text of note",
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                    _textEditingController.text = "";
                  },
                ),
                TextButton(
                  child: Text('Update'),
                  onPressed: () {
                    Navigator.pop(context);

                    HiveHelper.EditNote(i, _textEditingController.text);
                    setState(() {});
                  },
                ),
              ],
            );
          },
        );
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white38,
            ),
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Center(
              child: Text(
                MyNotes[i],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: InkWell(
              onTap: () {
                HiveHelper.RemoveNote(i);
                setState(() {});
              },
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
