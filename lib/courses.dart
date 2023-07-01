import 'package:edenberry/utils/constants/images.dart';
import 'package:edenberry/utils/reusable_widget/title_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/constants/colors.dart';
import '../utils/models/courses_model.dart';
import '../utils/reusable_widget/components.dart';

class CourseScreen extends StatefulWidget {
  final List<Lessons>? lessons;
  final String? title;
  final String? description;
  const CourseScreen({super.key, this.title, this.description,this.lessons, });
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int _selectedIndex = 0;

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  List<Lessons>? _lessons;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();

    _lessons = widget.lessons;

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    _controller = YoutubePlayerController(

      initialVideoId: YoutubePlayer.convertUrlToId((_lessons?[0].videoUrl).toString()).toString(),

      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _lessons;

    return YoutubePlayerBuilder(
        onEnterFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          _controller.play();
          },
        onExitFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent
            ),
          );
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            // _controller.load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
            // GlobalComponents.showSnackBar(context: context, message: 'Next Video Started');
            // setState(() {
            //   selectedIndex<=lessons.length ? selectedIndex++ : selectedIndex = 0;
            // });
          },
        ),
        builder: (context, player) => Scaffold(
          backgroundColor: AppColors.colorWhiteHighEmp,
          appBar: AppBar(
            title: Text(widget.title.toString()),
            elevation: 0,
            backgroundColor: AppColors.colorWhiteHighEmp,
            iconTheme: const IconThemeData(
              color: AppColors.colorBlackHighEmp,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
              statusBarColor: AppColors.colorWhiteHighEmp,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                height: 251.h,
                width: 360.w,
                child: player,
              ),
              Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 11.77.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.colorWhiteHighEmp,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  offset: const Offset(4.0, 4.0),
                                  spreadRadius: 5.sp,                      // Spread radius
                                  blurRadius: 10.sp,
                                ),
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedIndex < 0 ?"Intro" :(lessons?[_selectedIndex].title).toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: AppColors.colorBlackHighEmp,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      _selectedIndex < 0 ?"Intro" :"Lesson ${(_selectedIndex + 1).toString().padLeft(2, '0')} | ${_controller.metadata.duration.inMinutes} min",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: AppColors.colorBlackLowEmp,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(height: 20.h,),
                                    Text(
                                      "Related Lesson's",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: AppColors.colorBlackHighEmp,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Container(
                                  height: 95.h,
                                  width: 1.sw - 32.w,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: lessons?.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context,index){
                                        final lesson = lessons?[index];
                                        return _buildLessons(
                                            imagePath: lesson?.imageUrl,
                                            index: index,
                                            videoUrl: lesson?.videoUrl
                                        );
                                      }
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.colorBlackHighEmp
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      widget.description.toString(),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.colorBlackMidEmp
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 29.34.h),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }

  Widget _buildLessons ({required String? imagePath,required int index,required String? videoUrl}){
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedIndex = index;
        });
        _controller.load(YoutubePlayer.convertUrlToId(videoUrl.toString()).toString(),startAt:0);
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Image.network(
                imagePath.toString(),
                height: 70.662.h,
                width: 90.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.h,),
            Text(
              "Lesson ${(index + 1).toString().padLeft(2, '0')}",
              style: TextStyle(
                color: _selectedIndex == index ?AppColors.colorSecondary: AppColors.colorBlackMidEmp,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp
              ),
            )
          ],
        ),
      ),
    );
  }
}
