import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/websites/cubit/website_cubit.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/action_dialog.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/custom_text_field.dart';
import 'package:pulse/widgets/icon_btn.dart';

import '../../../widgets/custom_button.dart';

class EditWebsiteScreen extends StatefulWidget {
  final Website web;
  const EditWebsiteScreen({super.key, required this.web});

  @override
  State<EditWebsiteScreen> createState() => _EditWebsiteScreenState();
}

class _EditWebsiteScreenState extends State<EditWebsiteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isAutoValidate = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: widget.web.name);
    TextEditingController domain =
        TextEditingController(text: widget.web.domain);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.web.name,
        actions: [
          IconBtn(
              icon: Icons.delete_rounded,
              click: () {
                showDialog(
                  context: context,
                  builder: (_) => ActionDialog(
                    fn: () async {
                      await context.read<WebsiteCubit>().deleteWebsite(
                          name: widget.web.name,
                          id: widget.web.id,
                          context: context);
                    },
                    title: 'Delete Website?',
                    des:
                        'Are you sure you want to delete this website and all it\'s analytics data',
                    color: kErrorColor,
                    icon: Icons.delete_rounded,
                  ),
                );
              },
              iconColor: kErrorColor),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: BlocConsumer<WebsiteCubit, WebsiteState>(
          listener: (context, state) {
            if (state is WebsiteError) {
              Toast.showToast(message: state.message, context: context);
            }
            if (state is WebsiteLoaded) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              autovalidateMode: isAutoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Toast.showToast(
                          message: 'Website ID copied to clipboard',
                          context: context);
                    },
                    child: CustomTextField(
                      hint: widget.web.id,
                      disabled: true,
                      title: 'ID',
                      suffIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.copy_rounded)),
                    ),
                  ),
                  CustomTextField(
                    title: 'Website Name',
                    hint: 'Website Name',
                    data: name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hint: 'Website Domain',
                    title: 'Website Domain',
                    data: domain,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      } else if (!val.contains('.')) {
                        return 'Enter a valid domain';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    btnText: 'Save Changes',
                    click: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      bool isValid = formKey.currentState!.validate();
                      if (isValid) {
                        context.read<WebsiteCubit>().editWebsite(
                            name: name.text,
                            domain: domain.text,
                            id: widget.web.id,
                            context: context);
                      } else {
                        setState(() => isAutoValidate = true);
                      }
                    },
                    isLoading: state is WebsiteAdding,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
