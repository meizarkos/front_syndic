import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_syndic/core_value.dart';

import '../../../text/fr.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    super.key,
    required this.camera
  });

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  List<Image> images = [];
  Image? imageStore;
  int takePicture = 1;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Return to previous screen
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Define behavior for skipping
            },
            child: Text(
              AppText.takePictureSkip,
              style: TextStyle(
                color: takePicture == 1 ? Colors.white : Colors.transparent,
                fontSize: 18,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (takePicture == 0) {
                setState(() {
                  imageStore = null;
                  takePicture = 1;
                });
              }
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  takePicture = 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: AppUIValue.spaceScreenToAny),
                child: SvgPicture.asset(
                  'assets/close.svg',
                  color: takePicture == 0 ? Colors.white : Colors.transparent,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true, // Extend the body to the top of the screen
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller.takePicture();
                          setState(() {
                            takePicture = 0;
                            imageStore = Image.file(File(image.path));
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: takePicture == 1 ? Colors.white : Colors.transparent, // Outline color
                            width: 7, // Outline width
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                Positioned(
                  bottom: 20, left: 0, right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Define behavior for saving and leaving
                          },
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              AppText.takePictureSave,
                              style: TextStyle(
                                color: takePicture == 1 ? Colors.white : Colors.transparent,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              images = [];
                              takePicture = 1;
                            });
                          },
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              '${AppText.takePictureEraseAll} ${images.length}/3',
                              style: TextStyle(
                                color: takePicture == 1 ? Colors.white : Colors.transparent,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (takePicture == 0) {
                      setState(() {
                        if(imageStore != null){
                          images.add(imageStore!);
                        }
                        if(images.length == 3){
                          //push to next screen
                        }
                        takePicture = 1;
                      });
                    }
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0), // Optional: Add padding to lift the text slightly
                      child: Text(
                        '${AppText.takePictureApprove} ${images.length}/3',
                        style: TextStyle(
                          color: takePicture == 0 ? Colors.white : Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}