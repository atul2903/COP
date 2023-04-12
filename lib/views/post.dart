import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

class _postState extends State<post> {
  @override
  final TextEditingController _description=TextEditingController(); 
 Uint8List? _file;
  _selectImage(BuildContext context) async{
  return showDialog(context: context, builder: (context){
    return SimpleDialog(
      title: const Text('Report a Problem'),
      children: [ 
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text('Take a Photo'),
          onPressed: () async{
            Navigator.of(context).pop();
          Uint8List file=await pickImage(ImageSource.camera);
            setState(() {
              _file=file;

            });
          }
        ),
         SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          child: const Text('Cancel'),
          onPressed: () async{
            Navigator.of(context).pop();
         
          }
        )
      ],
    );
  });
}

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker=ImagePicker();
  XFile? _file=await _imagePicker.pickImage(source: source);
  if(_file !=null){
    return await _file.readAsBytes();
  }
  print('no image selected');
}


  Widget build(BuildContext context) {


    return _file==null? Card(
      child: Center(
        child: IconButton(onPressed: () => _selectImage(context), icon: const Icon(Icons.add)),
      ),
    ):
    

      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey ,
        leading: IconButton(onPressed: () {
          
        }, icon: const Icon(Icons.arrow_back)),
      title: const Text('Post To'),
      centerTitle: false,
      actions: [
        TextButton(onPressed: () {
          
        }, child: const Text('Post',style: TextStyle(
          color:  Colors.white,
          fontWeight: FontWeight.bold,
        ),))
      ],
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: TextField(decoration: const InputDecoration(
             hintText: 'Report your Problem.....',
             border: InputBorder.none,
             
              ),
controller: _description,
              maxLines:10 ,),
            ),
            SizedBox(
              height: 45,
              width:45,
              child: AspectRatio(aspectRatio: 500/450,
            child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: MemoryImage(_file!)
                ,
                fit: BoxFit.fill,
                alignment: FractionalOffset.topCenter)
                ,
                
                
                
              ),
            ),
              )
            ),
          const Divider(),],
        )
      ]),
    );
  }
}



// showing the dialog box (take a photo , cancel)


