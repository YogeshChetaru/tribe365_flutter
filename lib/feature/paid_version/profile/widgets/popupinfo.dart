import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';

// ignore: must_be_immutable
class PopupInfo extends StatefulWidget {
  Function getImageDatasub;

  PopupInfo({super.key, required this.getImageDatasub});

  @override
  State<PopupInfo> createState() => _PopupInfoState();
}

class _PopupInfoState extends State<PopupInfo> {
  File? subFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _chooseGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedFile != null) {
      subFile = File(pickedFile.path);
      widget.getImageDatasub(subFile);
    }
  }

  void _chooseCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedFile != null) {
      subFile = File(pickedFile.path);
      widget.getImageDatasub(subFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(13),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: ColorResources.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  Images.cancelled,
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _chooseGallery();
                        },
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                Images.photoGreen,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                height: 5,
                              ), //SizedBox
                              Text(
                                getTranslated('gallery', context).toString(),
                                style: const TextStyle(
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ), //Textstyle
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              //Text
                              //SizedBox
                            ],
                          ),
                        ),
                      ), //SizedBox
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _chooseCamera();
                        },
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                Images.cameraGreen,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                height: 5,
                              ), //SizedBox
                              Text(
                                getTranslated('camera', context).toString(),
                                style: const TextStyle(
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ), //Text
                              const SizedBox(
                                height: 10,
                              ), //SizedBox
                              //Text
                              //SizedBox
                            ],
                          ),
                        ),
                      ), //SizedBox
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
