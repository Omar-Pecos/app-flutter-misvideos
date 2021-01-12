import 'package:apm_pip/common/httpHandler.dart';
import 'package:apm_pip/components/create.dart';
import 'package:apm_pip/models/apmModel.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ListOfApms extends StatefulWidget {
  @override
  _ListOfApmsState createState() => _ListOfApmsState();
}

class _ListOfApmsState extends State<ListOfApms> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<Apm>> futureListApm$;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();

    futureListApm$ = HttpHandler().getAll();
    Timer t = setTimer();
  }

 //force the floatingactionBtn to appear 3 seconds later (when data has to be loaded)
  Timer setTimer(){
    return new Timer(Duration(seconds: 3), (){
      setState(() {
        dataLoaded = true;
      });
      
    });
    //timer.cancel();
  }

  void _openCreateForm() async{
    final CreationResult result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => 
                CreateAPM() 
              )
    );

    if (result?.result == true){
      setState(() {
        futureListApm$ = HttpHandler().getAll();
      });
       SnackBar snackbar = SnackBar(content: Text('"'+ result.apm.name + '" creado correctamente'),duration: Duration(seconds : 3));
       _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Lista de APMs'),
      ),
      body: FutureBuilder<List<Apm>>(
        future: futureListApm$,
        builder: (context,result){
          // WITH DATA
          if (result.hasData){
            
            return ListView.builder(
              itemCount : result.data.length,
              itemBuilder: (context,i) =>
                Column(
                children : [
                    i != 0 ?
                      Divider(height : 5) : Container(),

                    ListTile(
                      leading: Icon(
                        Icons.play_circle_fill
                      ),
                      title : Text(result.data[i].name),
                      subtitle: result.data[i].desc != '' ? Text(result.data[i].desc) : Text('Sin descripción'),
                      onTap: () => print(result.data[i].name + ' > ' + result.data[i].url),
                    )
                ]
              )
               
            );
          } else if(result.hasError){
            /*// ERROR
             var snackbar = SnackBar(content: Text(result.error));
            Scaffold.of(context).showSnackBar(snackbar);
             return Center(
               child: Container(child :  CircularProgressIndicator(),width: 50,height: 50)
             );*/
             return Text(result.error);
          }

          //DEFAULT
          return Center(
               child: Container(child :  CircularProgressIndicator(),width: 50,height: 50)
             );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
        dataLoaded ?
          FloatingActionButton(
            onPressed: () => _openCreateForm(),
            child : Icon(Icons.plus_one)
          )
        : Container()
    );
  }
}