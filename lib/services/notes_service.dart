import 'dart:convert';

import 'package:rest/models/note.dart';
import 'package:rest/models/note_for__listing.dart';
import 'package:rest/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:rest/models/note_insert.dart';

class NotesService{
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apikey' : '1a4544b8-9c3b-43ae-a9ba-610d460b4fb3',
    'Content-Type' : 'application/json',
  };
  Future<APIResponse<List<NoteForListing>>> getNotesList(){
    return http.get(API+'/notes',headers: headers)
      .then((data){
          if(data.statusCode == 200){
            final jsonData= json.decode(data.body);
            final notes = <NoteForListing>[];
            for(var item in jsonData){
                
                notes.add(NoteForListing.fromJson(item));
            }
            return APIResponse<List<NoteForListing>>(
              data: notes
            );
          }
          return APIResponse<List<NoteForListing>>(
              error: true,errorMessage: 'An error occured'
            );
      })
      .catchError((_) =>APIResponse<List<NoteForListing>>(
              error: true,errorMessage: 'An error occured'
            ));
  }

  Future<APIResponse<Note>> getNote(String noteID)
  {
    return http.get(API+'/notes/'+ noteID,headers: headers)
      .then((data)
      {
          if(data.statusCode == 200)
          {
            final jsonData= json.decode(data.body);
            return APIResponse<Note>
            (
              data: Note.fromJson(jsonData)
            );
          }
          return APIResponse<Note>
            (
              error: true,errorMessage: 'An error occured'
            );
      })
      .catchError((_) =>APIResponse<Note>
            (
              error: true,errorMessage: 'An error occured'
            ));
  }
  Future<APIResponse<bool>> createNote(NoteManipulation item)
  {
    return http.post(API+'/notes',headers: headers,body: json.encode(item.toJson()))
      .then((data)
      {
          if(data.statusCode == 201)
          {
            return APIResponse<bool>
            (
              data: true
            );
          }
          return APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            );
      })
      .catchError((_) =>APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            ));
  }
  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item)
  {
    return http.put(API+'/notes/'+noteID,headers: headers,body: json.encode(item.toJson()))
      .then((data)
      {
          if(data.statusCode == 204)
          {
            return APIResponse<bool>
            (
              data: true
            );
          }
          return APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            );
      })
      .catchError((_) =>APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            ));
  }
  Future<APIResponse<bool>> deleteNote(String noteID, )
  {
    return http.delete(API+'/notes/'+noteID,headers: headers)
      .then((data)
      {
          if(data.statusCode == 204)
          {
            return APIResponse<bool>
            (
              data: true
            );
          }
          return APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            );
      })
      .catchError((_) =>APIResponse<bool>
            (
              error: true,errorMessage: 'An error occured'
            ));
  }

}