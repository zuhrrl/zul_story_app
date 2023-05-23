import 'package:flutter/material.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/utils/date_helper.dart';
import 'package:zul_story_app/widget/circle_image.dart';

class CardStory extends StatelessWidget {
  DateHelper dateHelper = DateHelper();
  final double paddingTop;
  final String userName;
  final String storyImageUrl;
  final String storyDescription;
  final String createdAt;
  CardStory(
      {Key? key,
      required this.paddingTop,
      required this.userName,
      required this.storyImageUrl,
      required this.storyDescription,
      required this.createdAt})
      : super(key: key);

  getUploadTime(timeCreated) {
    var diffTime = dateHelper.getDiffTimeInMinutes(timeCreated);
    var diffInHours = dateHelper.getDiffTimeInHours(timeCreated);

    print('diff minute $diffTime');
    if (diffTime > 0 && diffTime < 60) {
      return '$diffTime menit yang lalu';
    }

    if (diffTime > 60) {
      if (diffInHours > 24) {
        return '${dateHelper.getDiffTimeInDays(timeCreated)} hari yang lalu';
      }
      return '${dateHelper.getDiffTimeInHours(timeCreated)} jam yang lalu';
    }

    return 'Baru saja';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: paddingTop),
      decoration: const BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const CircleImage(
                isStoryCard: true,
                imageHeigth: 40,
                imageWidth: 40,
                strokeWidth: 2,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    getUploadTime(createdAt),
                    style: const TextStyle(color: textColor),
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ))
            ],
          ),
          Container(
            width: double.maxFinite,
            height: 200,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(storyImageUrl), fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
