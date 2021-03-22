import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest/models/api_response.dart';
import 'package:rest/models/note_for__listing.dart';
import 'package:rest/services/notes_service.dart';
import 'package:rest/views/note_delete.dart';
import 'package:rest/views/note_modify.dart';
import 'package:get_it/get_it.dart';



class NoteList extends StatefulWidget {
 
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();
 
  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';//
  }
  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;
  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }
  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("NotePad"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteModify()))
          .then((_){
            _fetchNotes();
          });
        },
     child: Icon(Icons.add)),
    body: Builder(
      builder: (context){
        if(_isLoading){
            return CircularProgressIndicator();
          }

          if(_apiResponse.error){
            return Center(child: Text(_apiResponse.errorMessage));
          }

          
        return  ListView.separated(
      separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green,),
      itemBuilder: (_, index){
        
        return Dismissible(
          key: ValueKey(_apiResponse.data[index].noteID),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){

          },
          confirmDismiss: (direction)  async {
            
            final result =await showDialog(
              context: context, 
              builder: (_)=>NoteDelete()
              );
                var message;
              if(result){
                final deleteResult = await service.deleteNote(_apiResponse.data[index].noteID);
                if(deleteResult!= null && deleteResult.data ==true){
                  message = 'This note was deleted succesfully';
                } else{
                  message  = deleteResult?.errorMessage ?? 'An error occurred';
                }
               showDialog(context: context, builder: (_) =>AlertDialog(
                 title: Text('Done'),
                 content: Text(message),
                 actions: <Widget>[
                   FlatButton(child: Text('OK'), onPressed: (){
                     Navigator.of(context).pop();
                   })
                 ],
               ));
                return deleteResult?.data ?? 'false';
              }
              return result;
          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(left: 16),
            child: Align(child: Icon(Icons.delete, color: Colors.white), alignment: Alignment.centerLeft)
          ),
            child: ListTile(
            title: Text(_apiResponse.data[index].noteTitle,
            style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text("Last edited on ${formatDateTime(_apiResponse.data[index].lastestEditDateTime ??
            _apiResponse.data[index].createDateTime)}"),
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) => NoteModify(noteID: _apiResponse.data[index].noteID)))
            .then((_){
              _fetchNotes();
            });
            },
          ),
        );
      },
      itemCount: _apiResponse.data.length,
      );
      }
    ),
      
    );
  }
} 