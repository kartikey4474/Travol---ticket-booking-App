import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/category.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/pages/location_page.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';
import 'package:spaced_trip_scheduler/widgets/category_card.dart';
import 'package:spaced_trip_scheduler/widgets/location_slider_card.dart';

class Discovery extends StatefulWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
  double _parallaxOffset = 0;
  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Discover',
      subTitle: 'Trending Places today',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 140.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              _buildImageSlider(context),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Text(
                  'Feeling Adventurous?',
                  style: kHeadingStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 20),
                child: Text(
                  'Get Inspiration from these trending categories',
                  style: TextStyle(
                    color: kNoteTextColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: _buildCategories(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildImageSlider(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<Location> sliderLocations = Location.getLocations().take(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: height < 700 ? 1.6 : 1.1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction:
                (MediaQuery.of(context).size.width - 3 * kDefaultPadding) /
                    MediaQuery.of(context).size.width,
            disableCenter: true,
            onScrolled: (val) {
              setState(() {
                _parallaxOffset = (val ?? 0) * 100;
              });
            }),
        items: sliderLocations
            .map((location) => LocationSliderCard(
                  offset: _parallaxOffset,
                  location: location,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LocationPage(
                              location: location,
                            )));
                  },
                ))
            .toList(),
      ),
    );
  }

  _buildCategories() {
    const categriesPath = '$kImagesPath/categories';
    List<Category> categories = [
      Category(name: 'Nature', imageUrl: '$categriesPath/nature.png'),
      Category(name: 'Futuristic', imageUrl: '$categriesPath/futuristic.png'),
      Category(name: 'Party', imageUrl: '$categriesPath/party.png'),
      Category(name: 'Green', imageUrl: '$categriesPath/green.png'),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          category: categories[index],
        );
      },
    );
  }
}
