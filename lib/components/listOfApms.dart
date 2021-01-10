import 'package:apm_pip/common/httpHandler.dart';
import 'package:apm_pip/models/apmModel.dart';
import 'package:flutter/material.dart';

class ListOfApms extends StatefulWidget {
  @override
  _ListOfApmsState createState() => _ListOfApmsState();
}

class _ListOfApmsState extends State<ListOfApms> {
  Future<List<Apm>> futureListApm$;

  @override
  void initState() {
    super.initState();

    futureListApm$ = HttpHandler().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      subtitle: result.data[i].desc != null ? Text(result.data[i].desc) : Text(''),
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
      )
    );
  }
}