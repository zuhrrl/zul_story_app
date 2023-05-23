import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zul_story_app/constant/app_constant.dart';
import 'package:zul_story_app/constant/result_state.dart';
import 'package:zul_story_app/main.dart';
import 'package:zul_story_app/provider/home_screen_module_provider.dart';
import 'package:zul_story_app/routes/page_manager.dart';
import 'package:zul_story_app/utils/date_helper.dart';
import 'package:zul_story_app/widget/card_story.dart';
import 'package:zul_story_app/widget/circle_image.dart';

class HomeScreen extends StatelessWidget {
  final Function() onErrorAuth;
  final Function() uploadStoryPage;
  final Function() onLoggedOut;
  final Function(dynamic) detailStoryPage;
  DateHelper dateHelper = DateHelper();
  HomeScreen(
      {Key? key,
      required this.onErrorAuth,
      required this.uploadStoryPage,
      required this.detailStoryPage,
      required this.onLoggedOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgScaffold,
      body: SafeArea(child: Consumer<HomeScreenModuleProvider>(
        builder: (context, provider, child) {
          print(provider.getErrorMessage);

          if (provider.state == ResultState.errorAuth) {
            return onErrorAuth();
          }
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.state == ResultState.error) {
            var errorMessage = provider.getErrorMessage;
            if (errorMessage.contains('Network is unreachable')) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Error tidak dapat terhubung dengan internet!'),
                    ElevatedButton(
                        onPressed: () {
                          provider.fetchStories();
                          return;
                        },
                        child: const Text('Coba Lagi'))
                  ],
                ),
              );
            }

            if (errorMessage.contains('Failed host lookup')) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Error tidak dapat terhubung dengan internet!'),
                    ElevatedButton(
                        onPressed: () {
                          provider.fetchStories();
                        },
                        child: const Text('Coba Lagi'))
                  ],
                ),
              );
            }
          }

          if (provider.state == ResultState.hasData) {
            print('disni has data');
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'ZULSTORY',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            preferenceHelper.saveAccessToken('');
                            onLoggedOut();
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: provider.getListStory.length,
                    itemBuilder: (context, index) {
                      final pageManager = context.read<PageManager>();

                      var story = provider.getListStory[index];

                      if (index == 0) {
                        return CircleImage(
                          imageHeigth: 80,
                          imageWidth: 80,
                          strokeWidth: 3,
                          imageName: pageManager.userName.isEmpty
                              ? provider.userName
                              : pageManager.userName,
                          callbackAddStory: () async {
                            uploadStoryPage();

                            final uploadSuccess =
                                await pageManager.waitForUploadSuccess();
                            print(uploadSuccess);
                            provider.fetchStories();
                          },
                          isAddStory: true,
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          detailStoryPage(story.id);
                        },
                        child: CircleImage(
                          imageHeigth: 80,
                          imageWidth: 80,
                          strokeWidth: 3,
                          imageName: story.name,
                        ),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: provider.getListStory.length,
                  itemBuilder: (context, index) {
                    var story = provider.getListStory[index];

                    if (index == 0) {
                      return GestureDetector(
                          onTap: () {
                            detailStoryPage(story.id);
                          },
                          child: CardStory(
                              userName: story.name,
                              storyImageUrl: story.photoUrl,
                              storyDescription: story.description,
                              createdAt: story.createdAt,
                              paddingTop: 0));
                    }
                    return GestureDetector(
                      onTap: () {
                        detailStoryPage(story.id);
                      },
                      child: CardStory(
                        storyImageUrl: story.photoUrl,
                        userName: story.name,
                        storyDescription: story.description,
                        createdAt: story.createdAt,
                        paddingTop: 15,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
