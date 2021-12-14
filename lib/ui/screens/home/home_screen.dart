import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDataCubit(
            productRepository: context.read<BaseProductRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          )..getData(
              page: "1",
            ),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            localStorageClient: context.read<BaseLocalStorageClient>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductActionCubit(
            productRepository: context.read<BaseProductRepository>(),
            localStorageClient: context.read<BaseLocalStorageClient>(),
          ),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  int _page = 1;

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
      body: BlocBuilder<ProductDataCubit, BaseState>(
        builder: (context, state) {
          List<ProductList>? _resultsData;
          bool _isLoadMore = false;

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
            _resultsData = state.data;
          }

          return BlocConsumer<ProductActionCubit, BaseState>(
            listener: (context, actionState) {
              if (actionState is ErrorState) {
                _isLoadMore = false;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Gagal memuat data",
                    ),
                  ),
                );
              }

              if (actionState is LoadedState) {
                _isLoadMore = false;
                List<ProductList> _dumpData = actionState.data;

                if (_dumpData.isNotEmpty) {
                  context.read<ProductDataCubit>().dumpData(
                        data: _dumpData,
                      );
                }
              }

              if (actionState is LoadingState) {
                _isLoadMore = true;
              }
            },
            builder: (context, state) {
              return NotificationListener(
                onNotification: (ScrollNotification scrollNotification) {
                  if (scrollNotification is UserScrollNotification) {
                    if (scrollNotification.direction ==
                            ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels ==
                            scrollNotification.metrics.maxScrollExtent) {
                      if (_resultsData != null) {
                        _page++;
                        context.read<ProductActionCubit>().loadMore(
                              lastResult: _resultsData,
                              page: _page.toString(),
                            );
                      }
                    }
                  }

                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async => context.read<ProductDataCubit>()
                    ..getData(
                      page: "1",
                    ),
                  child: Padding(
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
                                ),
                              );
                            }

                            return Container();
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        if (_isLoadMore) ...[
                          const Center(
                            child: CircularProgressIndicator(
                              color: Palette.eleveniaPrimaryRed,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
