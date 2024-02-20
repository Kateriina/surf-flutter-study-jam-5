import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  _MemeGeneratorScreenState createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  String imageUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  //String memeText = 'Для начала улыбнись';
  String memeText = 'Здесь мог бы быть ваш мем';

  void _pickImageFromGallery() async {
    final _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  void _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String url = '';
        return AlertDialog(
          title: Text('Выбрать картинку'),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    url = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Введите URL',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.attach_file),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  imageUrl = url;
                });
                Navigator.of(context).pop();
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  // Метод для обмена полученным мемом
  void _shareMeme() {
    Share.share(imageUrl);
  }

  // Метод для редактирования текста мема
  void _editText() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Изменить текст'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                memeText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Введите текст',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Генератор мемов'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editText,
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareMeme,
          ),
          IconButton(
            icon: Icon(Icons.question_mark),
            onPressed: _info_about,
          ),
        ],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth * 0.8;

            return ColoredBox(
              color: Colors.black,
              child: DecoratedBox(
                decoration: decoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _pickImage,
                        child: SizedBox(
                          width: imageSize,
                          height: imageSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: imageUrl.startsWith('http')
                                  ? CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editText,
                        child: Text(
                          memeText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Impact',
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _info_about() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String url = '';
        return AlertDialog(
          title: Text('Информация о MemGen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Это конструктор для генерации картинок, позволяющий оперировать картинками и текстом.\n"
                  "Для изменения текста нажмите на него или на соответствующую кнопку.\n"
                  "Для изменения картинки нажмите на нее или на соответствующую кнопку.\n"
                  "Картинку можно загрузить по ссылке из источника или из галереи."),
              SizedBox(height: 10),
              Text("© kateriina 2024"),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}
