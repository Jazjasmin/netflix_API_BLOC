import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/widgets/app_bar_widget.dart';

class ScreenDownload extends StatelessWidget {
  ScreenDownload({Key? key}) : super(key: key);

  final _widgetList = [
    const _SmartDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        child: AppBarWidget(title: 'Downloads'),
        preferredSize: Size.fromHeight(50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (ctx, index) => _widgetList[index],
          separatorBuilder: (ctx, index) => SizedBox(
            height: 25,
          ),
          itemCount: _widgetList.length,
        ),
      ),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kwhite,
        ),
        Width10,
        Text('Smart Downloads'),
      ],
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImages());
    });
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Indroducing Downloads for you',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
          textAlign: TextAlign.center,
        ),
        height10,
        const Text(
          "We will download a persinalised selection of\nmovies and shows afor you, so there's \nalways somthing to watch on your \ndevice ",
          textAlign: TextAlign.center,
          style: TextStyle(color: kgrey, fontSize: 14),
        ),
        height10,
        BlocBuilder<DownloadsBloc, DownloadsState>(builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.width,
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: kgrey.withOpacity(0.5),
                        radius: size.width * 0.38,
                      ),
                      DownloadImagesWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads[0].posterPath}',
                        margin: const EdgeInsets.only(left: 150, top: 35),
                        size: Size(size.width * 0.35, size.width * 0.55),
                        angle: 25,
                      ),
                      DownloadImagesWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads[1].posterPath}',
                        margin: const EdgeInsets.only(
                          right: 150,
                          top: 35,
                        ),
                        size: Size(size.width * 0.35, size.width * 0.55),
                        angle: -20,
                      ),
                      DownloadImagesWidget(
                        imageList:
                            '$imageAppendUrl${state.downloads[2].posterPath}',
                        margin: const EdgeInsets.only(bottom: 5, top: 20),
                        size: Size(size.width * 0.4, size.width * 0.6),
                        radius: 8,
                      ),
                    ],
                  ),
          );
        }),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: buttonColorBlue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'setup',
                style: TextStyle(
                  fontSize: 20,
                  color: kwhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        height10,
        MaterialButton(
          color: buttonColorwhite,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                fontSize: 20,
                color: kblack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DownloadImagesWidget extends StatelessWidget {
  DownloadImagesWidget({
    Key? key,
    required this.imageList,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.radius = 10,
  }) : super(key: key);

  final double angle;
  final Size size;
  final double radius;
  final String imageList;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            // margin: margin,
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageList,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
