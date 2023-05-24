import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocare/controllers/video_controller.dart';
import 'package:grocare/utils/constants.dart';
import 'package:grocare/utils/videocard.dart';
import 'package:grocare/views/video_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final videoController = Get.put(VideoController());
  final listController = ScrollController();
  @override
  void initState() {
    videoController.getData();
    listController.addListener(() {
      if (listController.position.maxScrollExtent == listController.offset) {
        videoController.getData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Gro.care', style: kSubHeadingTextStyle),
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Jim',
                        style: kMainHeadingTextStyle,
                      ),
                      Text(
                        'Create,Earn,Grow',
                        style: kSubHeadingTextStyle,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('images/jim.jpg'),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'For You',
                style: kSubHeadingTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {
                  return GridView.builder(
                    controller: listController,
                    scrollDirection: Axis.vertical,
                    itemCount: videoController.videoList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < videoController.videoList.length) {
                        return GestureDetector(
                          child: VideoCard(
                            model: videoController.videoList[index],
                          ),
                          onTap: () {
                            Get.to(VideoPage(index: index));
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                  );
                }),
              ),
              Obx(() => Container(
                    child: videoController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    listController.dispose();
    videoController.dispose();
    super.dispose();
  }
}
