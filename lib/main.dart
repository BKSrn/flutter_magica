import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final stateuses = [
      Permission.storage,
    ].request();

    SystemChrome.setEnabledSystemUIMode([] as SystemUiMode);

    return MaterialApp(
      title: 'Flutter Magic',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => new _MyHomePageState();

}


class _MyHomePageState extends State<MyHomePage> {

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  final PageController _controller = PageController(
      initialPage: 0
  );

  @override
  Widget build(BuildContext context) {

    final pages = new PageView(
      controller: _controller,
      children: [
        new HomeWidget(),
        new PhotosWidget()
      ],
    );

    return pages;
  }

}

class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final children = new Scaffold(
      body: new Image.asset(
        "images/home1.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity
      ),
    );

    return new GestureDetector(
      onTapDown: (TapDownDetails details) => _onTapDown(details),
      child: children,
    );

  }

  void _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);

    int dx = (x / 80).floor();
    int dy = ((y - 180) / 100).floor();
    int posicao = dy * 5 + dx;
    print("results: x=$x y=$y $dx $dy $posicao");

    _save(posicao);
  }

  void _save(int posicao) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = "${appDocDir.path}/efeito-$posicao.jpg";
    print(savePath);
    await new Dio().download(
        "",
        savePath);
    print("saved!");
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
  }

}

class PhotosWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final children = new Scaffold(
      body: new Image.asset(
          "images/home2.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity
      ),
    );
    return new GestureDetector(
      onTap: _openGallery,
      child: children
    );

  }

  void _openGallery() {
    print("abrindo a galeria");

  }

}
