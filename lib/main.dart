import 'package:flutter/material.dart';
import 'package:rest/services/notes_service.dart';
import 'package:rest/views/note_list.dart';
import 'package:get_it/get_it.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(() => NotesService());
  
}
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotePad',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
    );
  }
}
