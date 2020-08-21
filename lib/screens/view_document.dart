import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scanner_cropper/flutter_scanner_cropper.dart';
import 'package:openscan/Utilities/DatabaseHelper.dart';
import 'package:openscan/Utilities/constants.dart';
import 'package:openscan/Utilities/file_operations.dart';
import 'package:openscan/Utilities/moor_db.dart';
import 'package:openscan/Widgets/Image_Card.dart';
import 'package:openscan/screens/home_screen.dart';
import 'package:openscan/screens/pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class ViewDocument extends StatefulWidget {
  static String route = "ViewDocument";
  final String dirPath;
  final bool quickScan;

  ViewDocument({this.dirPath, this.quickScan});

  @override
  _ViewDocumentState createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> imageFilesWithDate = [];
  List<String> imageFilesPath = [];
  List<Widget> imageCards = [];
  String imageFilePath;

  FileOperations fileOperations;
  String dirPath;
  String fileName;
  bool _statusSuccess;

  void imageEditCallback() {
    getImages();
  }

  Future<void> displayDialog(BuildContext context) async {
    String displayText;
    (_statusSuccess)
        ? displayText = "Success. File stored in the OpenScan folder."
        : displayText = "Failed to generate pdf. Try Again.";
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(displayText)),
    );
  }

  Future<void> createDirectoryName() async {
    Directory appDir = await getExternalStorageDirectory();
    dirPath = "${appDir.path}/OpenScan ${DateTime.now()}";
    fileName = dirPath.substring(dirPath.lastIndexOf("/") + 1);
  }

  Future<dynamic> createImage() async {
    File image = await fileOperations.openCamera();
    if (image != null) {
      if (!widget.quickScan) {
        imageFilePath = await FlutterScannerCropper.openCrop({
          'src': image.path,
          'dest': '/data/user/0/com.ethereal.openscan/cache/'
        });
      }
      File imageFile = File(imageFilePath ?? image.path);
      setState(() {});
      await fileOperations.saveImage(
        image: imageFile,
        i: imageFilesWithDate.length + 1,
        dirPath: dirPath,
      );

      AppDatabase().insert(MasterData(
        directoryName: fileName,
        directoryPath: dirPath,
        created: '  ',
        lastModified: DateTime.now().toString(),
        imagePath: imageFile.path,
      ));

      await fileOperations.deleteTemporaryFiles();
      if (widget.quickScan) createImage();
      getImages();
    }
  }

  void getImages() {
    imageFilesPath = [];
    imageFilesWithDate = [];

    Directory(dirPath)
        .list(recursive: false, followLinks: false)
        .listen((FileSystemEntity entity) {
      List<String> temp = entity.path.split(" ");
      //TODO: Fix delete bug
      if (!imageFilesWithDate.contains({
        "file": entity,
        "creationDate": DateTime.parse("${temp[3]} ${temp[4]}")
      })) {
        imageFilesWithDate.add({
          "file": entity,
          "creationDate": DateTime.parse("${temp[3]} ${temp[4]}")
        });
      }

      imageFilesWithDate
          .sort((a, b) => a["creationDate"].compareTo(b["creationDate"]));
      for (var image in imageFilesWithDate) {
        if (!imageFilesPath.contains(image['file'].path))
          imageFilesPath.add(image["file"].path);
      }
      setState(() {
        print(imageFilesWithDate);
      });
    });
  }

  getImageCards() {
    imageCards = [];
//    print(imageFilesWithDate);
    for (var i in imageFilesWithDate) {
      if (!imageCards.contains(
        ImageCard(
          imageFile: i['file'],
          fileName: fileName,
          dirPath: dirPath,
          imageFileEditCallback: imageEditCallback,
        ),
      )) {
        imageCards.add(ImageCard(
          imageFile: i['file'],
          fileName: fileName,
          dirPath: dirPath,
          imageFileEditCallback: imageEditCallback,
        ));
      }
    }
    return imageCards;
  }

  @override
  void initState() {
    super.initState();
    fileOperations = FileOperations();
    if (widget.dirPath != null) {
      dirPath = widget.dirPath;
      getImages();
    } else {
      createDirectoryName();
      createImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: RichText(
            text: TextSpan(
              text: 'View ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: 'Document',
                  style: TextStyle(color: secondaryColor),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () async {
//                DatabaseHelper()..queryAll();

                _statusSuccess = await fileOperations.saveToAppDirectory(
                  context: context,
                  fileName: fileName,
                  images: imageFilesWithDate,
                );
                Directory storedDirectory =
                    await getApplicationDocumentsDirectory();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFScreen(
                      path: '${storedDirectory.path}/$fileName.pdf',
                    ),
                  ),
                );
              },
            ),
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: _buildBottomSheet);
                },
              );
            }),
          ],
        ),
        body: RefreshIndicator(
          backgroundColor: primaryColor,
          color: secondaryColor,
          onRefresh: () async {
            getImages();
          },
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: primaryColor),
              child: ListView(
                children: [
                  Wrap(
                    spacing: size.width * 0.013,
                    runSpacing: size.width * 0.013,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: getImageCards(),
                  ),
                ],
              ),
            ),
          ),
        ),
        // TODO: Add photos from gallery
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: createImage,
          child: Icon(
            Icons.camera_alt,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    FileOperations fileOperations = FileOperations();
    Size size = MediaQuery.of(context).size;
    String folderName =
        dirPath.substring(dirPath.lastIndexOf('/') + 1, dirPath.length - 1);
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: Text(
              folderName,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(
            thickness: 0.2,
            indent: 8,
            endIndent: 8,
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Save to device'),
            onTap: () async {
              String savedDirectory;
              Navigator.pop(context);
              savedDirectory = await fileOperations.saveToDevice(
                context: context,
                fileName: fileName,
                images: imageFilesWithDate,
              );
              String displayText;
              (savedDirectory != null)
                  ? displayText = "Saved at $savedDirectory"
                  : displayText = "Failed to generate pdf. Try Again.";
              scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: primaryColor,
                  duration: Duration(seconds: 1),
                  content: Container(
                    decoration: BoxDecoration(),
                    alignment: Alignment.center,
                    height: 20,
                    width: size.width * 0.3,
                    child: Text(
                      displayText,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Share as PDF'),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      title: Text('Share as PDF'),
                      content: TextField(
                        onChanged: (value) {
                          fileName = '$value OpenScan';
                        },
                        controller: TextEditingController(
                            text: fileName.substring(8, fileName.length)),
                        cursorColor: secondaryColor,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Colors.white),
                          suffixText: ' OpenScan.pdf',
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor)),
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            _statusSuccess =
                                await fileOperations.saveToAppDirectory(
                              context: context,
                              fileName: fileName,
                              images: imageFilesWithDate,
                            );
                            Directory storedDirectory =
                                await getApplicationDocumentsDirectory();
                            ShareExtend.share(
                                '${storedDirectory.path}/$fileName.pdf',
                                'file');
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Share',
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Share as image'),
            onTap: () {
              ShareExtend.shareMultiple(imageFilesPath, 'file');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            title: Text(
              'Delete All',
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    title: Text('Delete'),
                    content: Text('Do you really want to delete file?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Directory(dirPath).deleteSync(recursive: true);
//                          DatabaseHelper()..deleteDirectory(dirPath: dirPath);
                          Navigator.popUntil(
                              context, ModalRoute.withName(HomeScreen.route));
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
