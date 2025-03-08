import 'package:flutter/material.dart';
import 'package:supa_base_tester/feature/auth/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  final AuthServices authService = AuthServices();
  //logout Button Function
  void logout() async {
    await supabase.auth.signOut();
  }

  //get current user email

  @override
  Widget build(BuildContext context) {
    final currentEmail = authService.getCurrentUserEmail();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
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
          return Column(
            children: [
              Text(currentEmail!),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    //get individual note
                    final note = notes[index];

                    //get the column you want
                    final noteText = note['body'];

                    //return ui
                    return ListTile(title: Text(noteText));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
