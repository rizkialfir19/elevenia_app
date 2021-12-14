import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ContainerProduct extends StatelessWidget {
  final ProductList productData;

  const ContainerProduct({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 15.0,
      ),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(
              0,
              3,
            ), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0),
              bottomLeft: Radius.circular(18.0),
            ),
            child: Image.asset(
              Images.noImagesPlaceholder,
              height: double.maxFinite,
              width: 120,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    productData.productName ?? "-",
                    style: FontHelper.h7Regular(
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    "Rp ${productData.price ?? '-'}",
                    style: FontHelper.h6Bold(
                      color: Palette.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    "Sisa Stock: ${productData.stock ?? '-'}",
                    style: FontHelper.h8Regular(
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint(
                        "---> Tambah keranjang: ${productData.productName}");
                    context.read<CartCubit>().addCartData(
                          data: productData,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Palette.eleveniaPrimaryGreen,
                    ),
                    child: Text(
                      "+ Tambah ke Keranjang",
                      style: FontHelper.h7Regular(
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
