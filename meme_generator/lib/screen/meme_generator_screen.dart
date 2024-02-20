import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  _MemeGeneratorScreenState createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  String imageUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';

  String memeText = 'Здесь мог бы быть ваш мем';

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
          title: const Text('Выбрать картинку'),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    url = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Введите URL',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
                child: const Row(
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
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  // Метод для обмена полученным мемом
  void _shareMeme() async {
    /*
    final screenshot = await screenshotController.capture();

    Share.shareFiles([screenshot], text: 'Проверьте этот мем!');*/
  }

  // Метод для редактирования текста мема
  void _editText() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Изменить текст'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                memeText = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Введите текст',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  // Метод для просмотра информации о приложении
  void _infoAbout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Информация о MEMGEN'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("MemGen - то конструктор для генерации демотивирующих картинок.\n"
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
              child: const Text('Закрыть'),
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
        title: const Text('MEMGEN'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editText,
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareMeme,
          ),
          IconButton(
            icon: const Icon(Icons.question_mark),
            onPressed: _infoAbout,
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
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: SizedBox(
                            width: imageSize,
                            height: imageSize,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return DecoratedBox(
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
                                            fit: BoxFit.contain,
                                            width: constraints
                                                .maxWidth, // Используем ширину родительского виджета
                                            height: constraints
                                                .maxHeight, // Используем высоту родительского виджета
                                          )
                                        : Image.file(
                                            File(imageUrl),
                                            fit: BoxFit.contain,
                                            width: constraints
                                                .minWidth, // Используем ширину родительского виджета
                                            height: constraints
                                                .minHeight, // Используем высоту родительского виджета
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editText,
                        child: Text(
                          memeText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Impact',
                            fontSize: 30,
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
}
