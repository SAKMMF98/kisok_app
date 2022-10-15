import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecitykiosk/screens/products/product_details/product_details_viewmodel.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackdropImage extends StatelessWidget {
  final List<String> productsImages;
  const BackdropImage({Key? key,required this.productsImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CarouselSlider(
            items: productsImages
                .map((e) => Image.network(
                      e,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 1.0,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (d, CarouselPageChangedReason changedReason) {
                  context.read<ProductDetailsViewModel>().updateIndex = d;
                }),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: backButtonCircle(context),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.32,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: productsImages.asMap().entries.map((entry) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(
                            context.watch<ProductDetailsViewModel>().index ==
                                    entry.key
                                ? 1.0
                                : context
                                                .read<ProductDetailsViewModel>()
                                                .index +
                                            1 ==
                                        entry.key
                                    ? 0.5
                                    : 0.2)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
