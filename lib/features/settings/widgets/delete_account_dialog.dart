import 'package:flutter/material.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showDeleteAccountSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                width: 40,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Delete Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Deleting your account will permanently remove your Umami Cloud account "
              "and all associated data. This action cannot be undone.",
              style: kBodyTextStyle,
            ),
            const SizedBox(height: 24),
            CustomButton(
                btnText: 'Manage & Delete via Umami Cloud',
                click: () async {
                  final uri = Uri.parse("https://cloud.umami.is");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                }),
            const SizedBox(height: 12),
            CustomButton(
                btnText: 'Request Deletion via Email',
                click: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'privacy@umami.is',
                    query: Uri.encodeFull(
                      'subject=Request to Delete My Umami Account'
                      '&body=Hello, Please delete my Umami Cloud account and all associated data.'
                      'Account email: ${prefs.getString(LocalStorage.email) ?? ''}Thank you.',
                    ),
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  }
                }),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
