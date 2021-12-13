import 'package:elevenia_app/common/common.dart';
import 'package:elevenia_app/core/core.dart';
import 'package:elevenia_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, AppTab>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.transparent,
          extendBody: true,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.blackLighten1,
            selectedItemColor: Palette.eleveniaPrimaryOrange,
            unselectedItemColor: Palette.greyLighten1,
            selectedLabelStyle: FontHelper.h9Regular(
              color: Palette.eleveniaPrimaryOrange,
            ),
            unselectedLabelStyle: FontHelper.h9Regular(
              color: Palette.greyLighten1,
            ),
            showUnselectedLabels: true,
            onTap: (index) => context.read<TabCubit>().changeTab(
                  tab: AppTab.values[index],
                ),
            currentIndex: AppTab.values.indexOf(state),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: const Icon(
                        Icons.home_outlined,
                        color: Palette.greyLighten1,
                      ),
                    ),
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: const Icon(
                      Icons.home_filled,
                      color: Palette.eleveniaPrimaryOrange,
                    ),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Palette.greyLighten1,
                      ),
                    ),
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Palette.eleveniaPrimaryOrange,
                    ),
                  ),
                ),
                label: 'My Cart',
              ),
            ],
          ),
          body: _buildContent(state),
        );
      },
    );
  }

  Widget _buildContent(AppTab state) {
    if (state == AppTab.home) {
      return const SafeArea(
        child: HomeScreen(),
      );
    }
    if (state == AppTab.cart) {
      return const SafeArea(
        child: CartScreen(),
      );
    }

    return Container();
  }
}
