import 'package:flutter/material.dart';
import 'package:notetake/inherited widget/note_inheretedwidget.dart';
import 'package:notetake/helper/database.helper.dart';

enum MakeNoteMode{
  Editing,
  Adding
}
class MakeNote extends StatefulWidget {

  final MakeNoteMode makeNoteMode;
  final Map<String, dynamic> note;

  MakeNote(this.makeNoteMode, this.note);

  @override
  MakeNoteState createState()=> new MakeNoteState();

}
class MakeNoteState extends State<MakeNote>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  var makeNoteMode;

  List<Map<String, String>> get notes => NoteInheritedWidget.of(context).notes;
  @override
  void didChangeDependencies() {
    if (widget.makeNoteMode == MakeNoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
            widget.makeNoteMode == MakeNoteMode.Adding ? 'New Note' : 'Edit Note'),
      ),
      body: Padding(
       padding: const EdgeInsets.all(30.0),
        child: Column(

        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
                hintText: 'Note title'
            ),
          ),
          Container(height: 3,),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                hintText: 'Note text'
            ),
          ),
          Container(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              widget.makeNoteMode == MakeNoteMode.Editing?
              _Notebutton('delete', Colors.redAccent, () async {
                await DatabaseHelper.deleteNote(widget.note['id']);
                Navigator.pop(context);
              }) :Container(),
              _Notebutton('discard', Colors.blueAccent, () {
                Navigator.pop(context);
              }),
              _Notebutton('save', Colors.greenAccent, () {
                if(widget?.makeNoteMode == MakeNoteMode.Adding){
                  final title = _titleController.text;
                  final text = _textController.text;

                  DatabaseHelper.insertNote({
                    'title' : title,
                    'text' : text
                  });
                } else if (widget?.makeNoteMode == MakeNoteMode.Editing){
                  final title = _titleController.text;
                  final text = _textController.text;
                  DatabaseHelper.updateNote({
                    'id': widget.note['id'],
                    'title' : title,
                    'text' : text
                  });
                }
                Navigator.pop(context);
              }),

            ],
          )
        ],
      ),
    )
    );
  }
}

class _Notebutton extends StatelessWidget{

  final String _text;
  final Color _color;
  final Function _onPressed;

  _Notebutton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color:Colors.white),
      ),
      height: 40,
      minWidth: 100,
      color: _color,
    );
  }
}
