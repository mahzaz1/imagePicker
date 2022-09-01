import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? image;

  List<File?> myList = [];

  Future pickImage () async{
      try{
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);

        if(image == null) return;

        final tempImage = File(image.path);

        setState(() {
          this.image = tempImage;
          myList.add(this.image);
        });
      }
      on PlatformException catch (error){
        print ("Failed To GEt Image: $error");
      }
  }

  Future pickImageC () async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final tempImage = File(image.path);

      setState(() {
        this.image = tempImage;
        myList.add(this.image);
      });
    }
    on PlatformException catch (error){
      print ("Failed To GEt Image: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Image Picker'),centerTitle: true,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  pickImage();
                },
                color: Colors.blue,
                child: Text("Image From Gallery",
                  style: TextStyle(
                    color: Colors.white
                ),),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  pickImageC();
                },
                color: Colors.blue,
                child: Text("Image From Camera",
                  style: TextStyle(
                    color: Colors.white
                ),),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: 300,
                child: GridView.count(
                    crossAxisCount: 2,
                        children: List.generate(myList.length + 1, (index){
                          if(index < myList.length ){
                            return Container(
                              width: 50,
                              height: 50,
                              child: Image.file(
                                myList[index]!,
                              )
                            );
                          }else{
                            return Image.asset("images/Ahzaz.png");
                          }

                },
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}