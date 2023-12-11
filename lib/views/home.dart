import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:my_note/models/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Note _note = Note();
  List<Note> notes = <Note>[];

  void _showDialogInsert() {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _contentController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Create a new note',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: "content",
                                  border: UnderlineInputBorder(),
                                ),
                                controller: _titleController,
                                minLines: null,
                                maxLines: null,
                                onChanged: (text) {
                                  setState(() {
                                    _note.title = text;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: "content",
                                      border: InputBorder.none),
                                  controller: _contentController,
                                  maxLines: 14,
                                  scrollPhysics: ScrollPhysics(),
                                  onChanged: (text) => {
                                    setState(() {
                                      _note.content = text;
                                    })
                                  },
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        String title = _titleController.text;
                                        String content =
                                            _contentController.text;
                                        Note data = Note(
                                            title: title,
                                            content: content,
                                            createAt: DateTime.now(),
                                            updateAt: DateTime.now());
                                        print(data);
                                        _addNoteToList(data);
                                        print(notes);
                                        _titleController.clear();
                                        _contentController.clear();
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _confirmDeleteNote(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Do you want delete this note?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    notes.removeAt(index);
                    _updateNotesList();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ))
            ],
          );
        });
  }

  void _updateNote(int index) {
    final TextEditingController _updateTitleController =
        TextEditingController();
    final TextEditingController _updateContentController =
        TextEditingController();

    Note noteToUpdate = notes[index];

    _updateTitleController.text = noteToUpdate.title ?? '';
    _updateContentController.text = noteToUpdate.content ?? '';

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Update a new note',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(children: <Widget>[
                              TextField(
                                decoration: const InputDecoration(
                                  hintText: "content",
                                  border: UnderlineInputBorder(),
                                ),
                                controller: _updateTitleController,
                                minLines: null,
                                maxLines: null,
                                onChanged: (text) {
                                  setState(() {
                                    _note.title = text;
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: "content",
                                      border: InputBorder.none),
                                  controller: _updateContentController,
                                  maxLines: 14,
                                  scrollPhysics: ScrollPhysics(),
                                  onChanged: (text) => {
                                    setState(() {
                                      _note.content = text;
                                    })
                                  },
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        String title =
                                            _updateTitleController.text;
                                        String content =
                                            _updateContentController.text;
                                        notes[index].title = title;
                                        notes[index].content = content;
                                        notes[index].updateAt = DateTime.now();
                                        _updateTitleController.clear();
                                        _updateContentController.clear();
                                        Navigator.of(context).pop();
                                        _updateNotesList();
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: notes.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () => _confirmDeleteNote(index),
            onTap: () {
              _updateNote(index);
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Text(
                    notes[index].title ?? "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(notes[index].content ?? ""),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            DateFormat.yMd().format(notes[index].createAt!)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          notes[index].createAt == notes[index].updateAt
                              ? ""
                              : DateFormat.yMd().format(notes[index].updateAt!),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogInsert,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _updateNotesList() {
    setState(() {});
  }

  void _addNoteToList(Note data) {
    notes.add(data);
    _updateNotesList();
  }
}
