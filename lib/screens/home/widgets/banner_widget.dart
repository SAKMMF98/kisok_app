import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecitykiosk/models/banner_model.dart';
import 'package:flutter/material.dart';

class BannerShow extends StatefulWidget {
  final List<BannerModel> allBanner;

  const BannerShow({Key? key, required this.allBanner}) : super(key: key);

  @override
  State<BannerShow> createState() => _BannerShowState();
}

class _BannerShowState extends State<BannerShow> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: widget.allBanner
                .map((e) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        e.banner ?? "",
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        errorBuilder: (a, s, sa) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                            child: Text(
                              "Banner Not Found",
                              style: TextStyle(
                                  fontFamily: "Josefin Sans Regular",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: 150,
                autoPlay: true,
                onPageChanged: (index, controller) {
                  _current = index;
                  if (mounted) setState(() {});
                },
                viewportFraction: 0.9,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                scrollPhysics: const NeverScrollableScrollPhysics())),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.allBanner.asMap().entries.map((entry) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFB800).withOpacity(
                      _current == widget.allBanner.length - 1 && entry.key == 0
                          ? 0.5
                          : _current == entry.key
                              ? 1.0
                              : _current + 1 == entry.key
                                  ? 0.5
                                  : 0.2)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
