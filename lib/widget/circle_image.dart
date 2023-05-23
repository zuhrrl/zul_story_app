import 'package:flutter/material.dart';
import 'package:zul_story_app/constant/app_constant.dart';

class CircleImage extends StatelessWidget {
  final String imageName;
  final bool isStoryCard;
  final double imageHeigth;
  final double imageWidth;
  final double strokeWidth;
  final bool isAddStory;
  final callbackAddStory;
  const CircleImage(
      {Key? key,
      this.imageName = '',
      required this.imageHeigth,
      required this.imageWidth,
      required this.strokeWidth,
      this.isAddStory = false,
      this.isStoryCard = false,
      this.callbackAddStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: imageWidth,
              height: imageHeigth,
              margin: const EdgeInsets.only(left: 13, right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage('assets/image/user.png'),
                    fit: BoxFit.cover),
                border: Border.all(color: blueColor, width: strokeWidth),
                // borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            if (isAddStory) ...[
              Positioned(
                  top: 40,
                  left: 70,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: FloatingActionButton(
                      onPressed: callbackAddStory,
                      backgroundColor: blueColor,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ]
          ],
        ),
        if (!isStoryCard) ...[
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 5),
            child: Text(
              imageName,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ]
      ],
    );
  }
}
