import 'package:flutter/material.dart';
import 'package:pulse/features/websites/screens/add_website_screen.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/widgets/custom_appbar.dart';

import '../../../utils/navigation.dart';
import '../widgets/web_card.dart';

class WebsitesScreen extends StatelessWidget {
  const WebsitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        tooltip: 'Add Website',
        backgroundColor: kPrimaryColor,
        onPressed: () => Navigation.go(
          screen: AddWebsiteScreen(),
          context: context,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(
        title: 'Websites',
        showLeading: false,
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: kGreyColor.withOpacity(.2),
                height: 20,
                endIndent: 20,
                indent: 20,
              ),
          padding: EdgeInsets.all(15.0),
          itemBuilder: (_, i) => WebCard(),
          itemCount: 20),
    );
  }
}
