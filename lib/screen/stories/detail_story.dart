import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/data/api/api_service.dart';
import 'package:zul_story_app/provider/detail_story_screen_module_provider.dart';
import 'package:zul_story_app/utils/date_helper.dart';
import 'package:zul_story_app/widget/circle_image.dart';

class DetailStory extends StatelessWidget {
  DateHelper dateHelper = DateHelper();
  ApiService apiService = ApiService();
  final String storyId;

  DetailStory({Key? key, required this.storyId}) : super(key: key);

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
    return ChangeNotifierProvider<DetailStoryScreenModuleProvider>(
      create: (context) => DetailStoryScreenModuleProvider(
          apiService: apiService, storyId: storyId),
      child: Consumer<DetailStoryScreenModuleProvider>(
          builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: bgScaffold,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10),
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
                          provider.story!.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          getUploadTime(provider.story!.createdAt),
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
                          image: NetworkImage(provider.story!.photoUrl),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    provider.story!.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
        );
      }),
    );
  }
}
