import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/commingsoon_widgets.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyone_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: kwhite,
                size: 30,
              ),
              width5,
              Container(
                width: 30,
                height: 20,
                color: Colors.blue,
              ),
              width5,
            ],
            bottom: TabBar(
                labelColor: kblack,
                unselectedLabelColor: kwhite,
                isScrollable: true,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                    color: kwhite, borderRadius: BorderRadius.circular(20)),
                tabs: const [
                  Tab(
                    text: '🍿 Coming Soon',
                  ),
                  Tab(
                    text: "👀 Everyone's Watching",
                  )
                ]),
          ),
        ),
        body: TabBarView(children: [
          _buildComingSoon(),
          _buildEveryOne(),
        ]),
      ),
    );
  }

  Widget _buildComingSoon() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const ComingSoonWidget(),
    );
  }

  Widget _buildEveryOne() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const EveryOneWatchingWidget(),
    );
  }
}
