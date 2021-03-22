import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Slide extends StatefulWidget {
  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  // ignore: non_constant_identifier_names
  int _current = 0;
  List<String> imgList = ['assets/item1.jpg','assets/item2.jpg','assets/item3.jpg','assets/item4.jpg'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(item,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width/1.25),
            ],
          ),
        ),
      ),
    ))
        .toList();
    return
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey,
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.5,
                onPageChanged: (index, reason) {
                  _current = index;
                  setState(() {
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.black
                      : Colors.white,
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}
