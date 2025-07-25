import 'package:flutter/material.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/custom_button.dart';
import 'package:pulse/widgets/custom_text_field.dart';

class AddWebsiteScreen extends StatelessWidget {
  const AddWebsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Website',
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomTextField(hint: 'Website Name'),
            CustomTextField(hint: 'Website URL'),
            const Spacer(),
            CustomButton(btnText: 'Save', click: () {}),
          ],
        ),
      ),
    );
  }
}
