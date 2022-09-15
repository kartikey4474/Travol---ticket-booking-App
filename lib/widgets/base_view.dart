import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/user.dart';
import 'package:spaced_trip_scheduler/widgets/user_avatar.dart';

class BaseView extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? subTitle;
  const BaseView({
    Key? key,
    required this.body,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title ?? 'Spaced',
            style: const TextStyle(fontSize: 40, fontFamily: 'SFProDisplay'),
          ),
        ),
        bottom: subTitle != null
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width / 2, 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Text(
                      subTitle!,
                      style: const TextStyle(color: kNoteTextColor, height: 1),
                    ),
                  ),
                ))
            : null,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.sort,
                size: 30,
              )),
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: UserAvatar(
              user: User.getCurrentUser(),
            ),
          )
        ],
      ),
      body: body,
    );
  }
}
