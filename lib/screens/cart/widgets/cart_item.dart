import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Item item;
  final String storeName;

  const CartItem({Key? key, required this.item, required this.storeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<CartViewModel>();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item.imgs!.first,
                      fit: BoxFit.cover,
                      height: 105,
                      width: 80,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.currencyCode ?? ""} ${item.price ?? ""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Text(
                          storeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF717171)),
                        ),
                        Text(
                          item.name ?? "Product Name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Consumer<CartViewModel>(
                            builder: (context, provider, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Qty",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF717171)),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartViewModel>()
                                          .updateQuantity(
                                              item: item, increase: false),
                                      child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Josefin_Slab"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        "${item.qty.toString().length == 1 ? "0${item.qty}" : item.qty}",
                                        style: const TextStyle(
                                            color: Color(0xFF717171),
                                            fontFamily: "Josefin_Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartViewModel>()
                                          .updateQuantity(
                                              item: item, increase: true),
                                      child: const CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Josefin_Slab"),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<CartViewModel>()
                                          .removeProduct(item);
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 28,
                                      color: AppColors.appColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (item.isLoading)
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: const LoadingIndicator(),
              alignment: Alignment.center,
            )
        ],
      ),
    );
  }

// String getColorAndSizeText(Item item) {
//   if (item.selectedSize!=null&&item.selectedColor!=null) {
//     if(item.selectedSize!.isNotEmpty&&item.selectedColor!.isNotEmpty){
//       return "Size:- ${item.selectedSize!.first.optionName??""} Color:- ${item.selectedColor!.first.optionName??""}";
//     }
//     else if(){}else{
//
//   }
//   } else if () {} else if () {} else {}
// }
}
