import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constant.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    Key? key, required this.id, required this.month, required this.day, required this.posterPath, required this.movieName, required this.description,
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
            children: [
              Text(
                month,
                style: const TextStyle(
                  fontSize: 16,
                  color: kgrey,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
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
               VideoWidget(url: posterPath,),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Expanded(
                     child: Text(
                      movieName,
                      maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.bold,
                      ),
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
             Text('Coming on $day $month'),
              height10,
               Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 18,
                  //letterSpacing: -5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height10,
               Text(
                description,
                maxLines: 4,
                //overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kGrey,
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}
