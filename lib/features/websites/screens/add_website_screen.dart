import 'package:flutter/material.dart';
import 'package:pulse/widgets/custom_appbar.dart';

class AddWebsiteScreen extends StatelessWidget {
  const AddWebsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Add Website',
      ),
    );
  }
}
