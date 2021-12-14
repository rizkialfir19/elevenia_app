import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DetailProductScreen extends StatelessWidget {
  DetailProductScreen({Key? key}) : super(key: key);

  ProductList? argsData;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments is ProductList) {
      argsData = ModalRoute.of(context)!.settings.arguments as ProductList;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDataCubit(
            productRepository: context.read<BaseProductRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          )..getDetail(
              productNo: argsData?.productNo ?? "0",
            ),
        ),
      ],
      child: const DetailProductView(),
    );
  }
}

class DetailProductView extends StatelessWidget {
  const DetailProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blackLighten1,
      ),
      body: BlocBuilder<ProductDataCubit, BaseState>(
        builder: (context, state) {
          ProductDetail? _detail;

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.eleveniaPrimaryRed,
              ),
            );
          }

          if (state is ErrorState) {
            return const Center(
              child: Text("Terjadi kesalahan. Silahkan coba lagi."),
            );
          }

          if (state is LoadedState) {
            _detail = state.data;
          }

          return ListView(
            children: [
              Image.asset(
                Images.noImagesPlaceholder,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Rp ${_detail?.price ?? '0'}",
                  style: FontHelper.h5Bold(
                    color: Palette.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _detail?.productName ?? "-",
                  style: FontHelper.h6Regular(
                    color: Palette.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      _detail?.sellerProductCd ?? "-",
                      style: FontHelper.h7Regular(
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.withOpacity(0.2)),
                    child: RichText(
                      text: TextSpan(
                        text: "Terjual : ",
                        style: FontHelper.h7Bold(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _detail?.productSellQty ?? "-",
                            style: FontHelper.h7Regular(
                              color: Palette.greyLighten1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.grey.withOpacity(0.2),
                height: 8.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Detail Product",
                  style: FontHelper.h6Bold(
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _detail?.productDetail ?? "-",
                  style: FontHelper.h6Regular(
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          );
        },
      ),
    );
  }
}
