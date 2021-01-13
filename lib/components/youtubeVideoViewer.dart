import 'package:flutter/material.dart';
import 'package:ext_video_player/ext_video_player.dart';

class YoutubeVideoViewer extends StatefulWidget {
  final url;
  YoutubeVideoViewer({@required this.url});

  @override
  _YoutubeVideoViewerState createState() => _YoutubeVideoViewerState(url : url);
}

class _YoutubeVideoViewerState extends State<YoutubeVideoViewer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  VideoPlayerController _controller;
  String url;

  _YoutubeVideoViewerState({@required this.url});

 
  @override
  void initState() {
    super.initState();
          _controller = VideoPlayerController.network(
            url
          );
          print(url);
          _controller.addListener(() {
            setState(() {});
          });
          _controller.setLooping(true);
          _controller.initialize().catchError((e) => onError(e));
    
  }

  void onError(error){
    //print(error.code);
      //show error
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.code, style: TextStyle(color: Colors.white),),backgroundColor: Colors.red[300]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _changeUrl(String videoUrl){
    setState(() {
        _controller.pause();

        url = videoUrl;
        
        _controller = VideoPlayerController.network(
            url
        );

        _controller.addListener(() {
          setState(() {});
        });
        _controller.setLooping(true);
        _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      key : _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child  : ListView(
                 children : [
                   ListTile(
                     title : Text('Po mu bien'),
                     onTap: () => _changeUrl('https://www.youtube.com/watch?v=24N7XmXf3kc'),
                   ),
                    ListTile(
                     title : Text('Machista'),
                      onTap: () => _changeUrl('https://www.youtube.com/watch?v=UKU8_iTtB3Y'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                    ListTile(
                     title : Text('fila 3'),
                   ),
                 ]
               ),
          )
         
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}