import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/custom_appbar.dart';

class NavBar extends StatefulWidget {
  final Website web;
  const NavBar({super.key, required this.web});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  TabController? tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.web.name,
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(child: Text('Hello World')),
          Center(child: Text('Hello World')),
          Center(child: Text('Hello World')),
          Center(child: Text('Hello World')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            tabController!.index = _currentIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        showUnselectedLabels: false,
        unselectedFontSize: 10,
        unselectedIconTheme: IconThemeData(color: kGreyColor.withOpacity(.35)),
        selectedLabelStyle:
            kBodyTextStyle.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: kBodyTextStyle.copyWith(color: kGreyColor),
        showSelectedLabels: true,
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart_rounded),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt_outlined),
            activeIcon: Icon(Icons.bolt_rounded),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user_outline),
            activeIcon: Icon(Iconsax.user_bold),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            activeIcon: Icon(Icons.pie_chart_rounded),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}
