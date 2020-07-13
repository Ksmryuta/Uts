import 'package:flutter/material.dart';
import 'package:notetake/screens/note_list.dart';
import 'package:notetake/screens/makenote_screen.dart';
import 'package:notetake/screens/profile_screen.dart';

class DrawerNavigaton extends StatefulWidget {
  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  List<Widget> _categoryList = List<Widget>();





  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars3.githubusercontent.com/u/58258426?s=460&u=94379cc86faa40064904069ad6799d4f59f32d74&v=4'),

              ),
              accountName: Text('Ryuuta'),
              accountEmail: Text('admin@ryuuta'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('profile'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Profile())),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NoteList())),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Tambah Catatan'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MakeNote(MakeNoteMode.Adding, null))),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}