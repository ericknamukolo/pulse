import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/websites/cubit/website_cubit.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/custom_button.dart';
import 'package:pulse/widgets/custom_text_field.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController domain = TextEditingController();
  bool isAutoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Website',
      ),
      body: BlocConsumer<WebsiteCubit, WebsiteState>(
        listener: (context, state) {
          if (state is WebsiteError) {
            Toast.showToast(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              autovalidateMode: isAutoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  CustomTextField(
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
                    btnText: 'Save',
                    click: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      bool isValid = formKey.currentState!.validate();
                      if (isValid) {
                        context.read<WebsiteCubit>().addWebsite(
                            name: name.text,
                            domain: domain.text,
                            context: context);
                      } else {
                        setState(() => isAutoValidate = true);
                      }
                    },
                    isLoading: state is WebsiteAdding,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
