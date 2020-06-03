import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROOTINE',
      home: Rootine(),
    );
  }
}

class Rootine extends StatefulWidget {
  @override
  RootineState createState() => RootineState();
}

class RootineState extends State<Rootine> {
  final items = List<String>.generate(10, (i) => "Item ${i + 1}");
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final dateTextController = TextEditingController();
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO: TODAY'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: showList),
        ]
      ),
      body: _buildOverdueList(),
    );
  }

  // #docregion _buildSuggestions
  Widget _buildOverdueList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      itemBuilder: (context, int i) {
        final item = items[i];
        return Dismissible(
          key: Key(items[i]),

          /*スワイプ時の背景の設定*/
          background: _buildBackGround(Colors.green, Icons.check, Alignment.centerLeft, 30.0, 0.0),
          secondaryBackground: _buildBackGround(Colors.yellow, Icons.timer, Alignment.centerRight, 0.0, 30.0),
          
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd){
              return true;
            } else {
              await _showSuspendDialog();
              return _result != 'Cancel';
            }
          },

          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart){
              debugPrint("test: $_result");
              setState(() {
                items.removeAt(i);
              });
               Scaffold.of(context)
               .showSnackBar(SnackBar(content: Text('$item suspended')));
            } else {
              setState(() {
                items.removeAt(i);
              });
              Scaffold.of(context)
              .showSnackBar(SnackBar(
                content: Text('$item dismissed'),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: (){
                    /*Undoのときの処理*/
                  }
                )
              ));
            }
          },
          child: _buildRow(item),
        );
      }
    );
  }

  Future _showSuspendDialog() async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("タスクを延長しますか？"),
          children: <Widget>[
            _buildDialogOption('明日', ' Tomorrow'),            
            _buildDialogOption('キャンセル', 'Cancel'),
          ],
        );
      },
    );
    if (result != ""){
      _result = result;
    }
  }

  Widget _buildDialogOption (String t, String rt){
    return SimpleDialogOption(
      child: ListTile(
        title: Text(t),
      ),
      onPressed: (){
        Navigator.pop(
          context,
          rt
        );
      },
    );
  }

  Widget _buildBackGround(Color c, IconData icn, Alignment aln, double lft , double rght){
    return Container(
      color: c,
      padding: EdgeInsets.only(left: lft, right: rght),
      child: Align(
        alignment: aln,
        child: Icon(icn)  
      )
    );
  }

  Widget _buildRow(String itm) {
    return ListTile(
      title: Text(
        itm,
        style: _biggerFont,
      ),
    );
  }

  void showList (){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('ROUTINES'),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: items.length,
              itemBuilder: (context, int i) {
                final item = items[i];
                return _buildRow(item);
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add_box),
              label: const  Text('ROOTINEを追加'),
              onPressed: () {
                _showNewRootineDialog(context);
              },
            ),
          );
        }
      )
    );
  }

  void _addList(bool result, String txt){
    Navigator.pop(context);
    if (result == true){
      setState((){
        items.add(txt);
      });
    }
  }



  Future _showNewRootineDialog(BuildContext context) async {
    final titleTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (buildContext){
        return AlertDialog(
          title: Text("新しいROOTINEを追加"),
          content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: titleTextController,
                  enabled: true,
                  maxLength: 20,
                  maxLengthEnforced: false,
                  obscureText: false,
                  autovalidate: false,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: '新しいROOTINEを入力',
                    labelText: 'タイトル'
                  ),
                  validator: (String value) {
                    return value.isEmpty ? '必須入力です' : null;
                  },
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('キャンセル')
                ),
                FlatButton(
                  onPressed: (){
                    if (_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      _addList(true, titleTextController.text);
                    }
                  },
                  child: Text('作成'),
                ),
              ],
            ),
          )
        );
      },
    );
  }
} 