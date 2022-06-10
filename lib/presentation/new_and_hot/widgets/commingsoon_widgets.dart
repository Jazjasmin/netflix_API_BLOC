import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        height20,
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Feb',
                style: TextStyle(
                  fontSize: 16,
                  color: kgrey,
                ),
              ),
              Text(
                '11',
                style: TextStyle(
                  letterSpacing: 4,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 60,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TALL GIRL 2',
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: -3,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: const [
                      CustomeButtonWidget(
                        icon: Icons.all_out_sharp,
                        iconSize: 20,
                        textSize: 12,
                        title: 'Remind Me',
                      ),
                      Width10,
                      CustomeButtonWidget(
                        icon: Icons.info,
                        iconSize: 20,
                        textSize: 12,
                        title: 'Info',
                      ),
                    ],
                  ),
                ],
              ),
              height10,
              const Text('Coming on Friday'),
              height10,
              const Text(
                'Tail Girl 2',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height10,
              const Text(
                'Landing the lead in the school musical is a dream come true for jodi , until the pressure sends her confidence- and her relationship - into a tailspain',
                style: TextStyle(
                  color: kGrey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
