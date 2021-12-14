import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(
            localStorageClient: context.read<BaseLocalStorageClient>(),
          )..getCartData(),
        ),
      ],
      child: const CartView(),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Elevenia App",
          style: FontHelper.h6Bold(
            color: Palette.eleveniaPrimaryOrange,
          ),
        ),
        backgroundColor: Palette.blackLighten1,
      ),
      body: BlocBuilder<CartCubit, BaseState>(
        builder: (context, state) {
          List<ProductList>? _resultsData;

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.eleveniaPrimaryRed,
              ),
            );
          }

          if (state is EmptyState) {
            return const Center(
              child: Text("Data tidak ditemukan."),
            );
          }

          if (state is ErrorState) {
            return const Center(
              child: Text("Terjadi kesalahan. Silahkan coba lagi."),
            );
          }

          if (state is LoadedState) {
            _resultsData = state.data;
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _resultsData?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (_resultsData != null) {
                      ProductList productData = _resultsData[index];

                      return GestureDetector(
                        onTap: () {
                          //Navigate to detail
                          Navigator.pushNamed(
                            context,
                            RouteName.detailProductScreen,
                            arguments: ScreenArgument(
                              data: productData,
                            ),
                          );
                        },
                        child: ContainerProduct(
                          productData: productData,
                          isCart: true,
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
