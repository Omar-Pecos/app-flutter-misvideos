import 'package:flutter/material.dart';
import 'package:apm_pip/models/apmModel.dart';
import 'package:apm_pip/common/httpHandler.dart';

class CreateAPM extends StatefulWidget {
  @override
  _CreateAPMState createState() => _CreateAPMState();
}

class _CreateAPMState extends State<CreateAPM> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

   Apm apm = new Apm(
      id: 0,
      name: '',
      command: '',
      desc: '',
      url : '',
      createdAt: new DateTime.now(),
      updatedAt: new DateTime.now()
    );

    TextEditingController _nameController = new TextEditingController();
    TextEditingController _descController = new TextEditingController();
    TextEditingController _commandController = new TextEditingController();
    TextEditingController _urlController = new TextEditingController();
  
  void _sendPost(Apm apm) async{
   Apm apmCreated;
    try{
      apmCreated = await HttpHandler().create(apm);
      //pop con data de vuelta - para hacer el reload
      Navigator.of(context).pop(CreationResult(result : true, apm : apmCreated));
    } catch(error){    
        //print(error);
      SnackBar snackbar = SnackBar(content: Text(error, style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[300], duration: Duration(seconds : 3));
     _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(
        title: Text('Crear'),
      ),
      body : Center(
        child : ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical : 30, horizontal: 50),
          children: [
             Column(
                 children: [
                   CircleAvatar(
                     radius: 30,
                     child : Icon(Icons.plus_one_rounded, size: 40),
                     backgroundColor: Colors.grey,
                   ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Nombre *'),
                      controller : _nameController,
                      onChanged : (String value) => setState((){ apm.name = value; }),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Nombre corto *'),
                      controller : _commandController,
                      onChanged : (String value)=> setState((){apm.command = value;}),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Descripción'),
                      controller : _descController,
                      onChanged : (String value)=> setState((){apm.desc = value;}),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'URL *'),
                      controller : _urlController,
                      onChanged : (String value)=> setState((){apm.url = value;}),
                    ),
                    Padding(padding: EdgeInsets.only(bottom : 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            disabledColor : Colors.white70,
                            color : Colors.black26,
                            onPressed: () => Navigator.of(context).pop(CreationResult(result : false, apm : apm)), child: Text('Cancelar')),
                         RaisedButton(
                            disabledColor : Colors.white70,
                            color : Colors.black26,
                            onPressed: () => _sendPost(apm),
                            child: Text('Crear'))
                      ],
                    )
                 ],
               ), 
          ],
      ),
      )
    );
  }
}