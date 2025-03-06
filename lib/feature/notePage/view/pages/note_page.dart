import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final supabase = Supabase.instance.client;

  //create a note and save it to the supabse
  final textController = TextEditingController();

  void addNewNote() async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Enter your note'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  saveNote();
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }

  void saveNote() async {
    await supabase.from('notes').insert({'body': textController.text});
    textController.clear();
  }

  //read note from supabase

  final notesStream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: notesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          //loaded
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              //get individual note
              final note = notes[index];

              //get the column you want
              final noteText = note['body'];

              //return ui
              return ListTile(
                title: Text(noteText),
              );
            },
          );
        },
      ),
    );
  }
}
