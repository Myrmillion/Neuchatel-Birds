import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:la_cuisine_dathena/constants.dart';
import 'package:la_cuisine_dathena/models/carousel_image.dart';
import 'package:la_cuisine_dathena/models/make_it_responsive.dart';
import 'package:la_cuisine_dathena/widgets/title_text.dart';

class CarouselSection extends StatefulWidget {
  @override
  createState() => CarouselState();
}

class CarouselState extends State<CarouselSection> {
  int index = 0;

  CarouselController _carouselController = CarouselController();
  List<CarouselImage> images = [
    CarouselImage(name: "Brownies", path: brownieImage),
    CarouselImage(name: "Cheesecake", path: cheesecakeImage),
    CarouselImage(name: "Gateau au choco", path: chocoImage),
    CarouselImage(name: "Cupcake", path: cupcakeImage),
    CarouselImage(name: "Donuts", path: donutsImage),
    CarouselImage(name: "Tiramisu", path: tiramisuImage),
    CarouselImage(name: "wedding", path: weddingImage),
  ];

  Widget _card(CarouselImage image) {
    return Container(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            image.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(image.path, fit: BoxFit.cover).image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = images.map((e) => _card(e)).toList();
    ScreenSize screenSize = MakeItResponsive().getScreenSize(context);
    CarouselOptions options = CarouselOptions(
        autoPlay: true,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
        onPageChanged: (newIndex, _) => setState(() => index = newIndex));
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TitleText(string: "Le Carousel de gateaux:"),
          ),
          const SizedBox(height: 7.5),
          CarouselSlider(
            items: items,
            options: options,
            carouselController: _carouselController,
          ),
          Card(
            color: pinkColor,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < images.length; i++) ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 5.0,
                            ),
                            child: Text(
                              (screenSize != ScreenSize.small)
                                  ? images[i].name
                                  : i.toString(),
                            ),
                          ),
                          onTap: () => _carouselController.animateToPage(i),
                        ),
                        Visibility(
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          visible: (index == i),
                          child: AnimatedOpacity(
                            opacity: 1,
                            duration: Duration(milliseconds: 500),
                            child: Container(
                              height: 5,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}