import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/provider/upload_story_screen_module_provider.dart';
import 'package:zul_story_app/routes/page_manager.dart';

class UploadStory extends StatelessWidget {
  final Function() onUploadSuccess;
  TextEditingController storyDescription = TextEditingController();
  UploadStory({Key? key, required this.onUploadSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadStoryScreenModuleProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: cardColor,
          title: Row(
            children: [
              const Text('Upload Story'),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    if (storyDescription.text.length <= 0) {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text("Description required!"),
                        ),
                      );
                      return;
                    }

                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text("Uploading..."),
                      ),
                    );
                    provider.setStoryDescription(storyDescription.text);
                    await provider.uploadStory();

                    if (provider.state == ResultState.uploadSuccess) {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text("Upload Success"),
                        ),
                      );
                      onUploadSuccess();
                      context.read<PageManager>().setUploadSuccess(true);
                      return;
                    }
                    return context.read<PageManager>().setUploadSuccess(false);
                  },
                  icon: const Icon(Icons.check))
            ],
          ),
        ),
        body: SafeArea(
            child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  if (provider.getSelectedPhoto != null) ...[
                    Image.file(
                      File(provider.getSelectedPhoto!.path),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ],
                  if (provider.getSelectedPhoto == null) ...[
                    Image.asset(
                      'assets/image/image_gallery.png',
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      color: blueColor,
                    ),
                  ],
                  if (provider.getSelectedPhoto != null) ...[
                    Positioned(
                        bottom: 10,
                        right: 20,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: blueColor),
                            onPressed: () {
                              provider.setSelectedPhoto(null);
                            },
                            child: const Text('Ganti Foto')))
                  ]
                ],
              ),
            ),
            if (provider.getSelectedPhoto == null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        provider.getImageFromCamera();
                      },
                      child: const Text('Camera')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        provider.getImageFromGallery();
                      },
                      child: const Text('Galeri'))
                ],
              )
            ],
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextField(
                controller: storyDescription,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blueColor, width: 1),
                    ),
                    border: OutlineInputBorder(),
                    hintText: "Write something",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: blueColor))),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }
}
