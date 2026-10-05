import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/auth/repo/auth_repo.dart';
import 'package:pulse/features/settings/screens/settings_screen.dart';
import 'package:pulse/features/websites/cubit/website_cubit.dart';
import 'package:pulse/features/websites/screens/add_website_screen.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:pulse/widgets/drop_down.dart';
import 'package:pulse/widgets/empty_state.dart';
import 'package:pulse/widgets/icon_btn.dart';
import 'package:pulse/widgets/loading_indicator.dart';
import 'package:pulse/widgets/mordern_btn.dart';

import '../../../utils/navigation.dart';
import '../models/website.dart';
import '../widgets/web_card.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {
  @override
  void initState() {
    context.read<WebsiteCubit>().getWebsites();
    super.initState();
  }

  List<Website> _filterWebsites(WebsiteState state) {
    if (state.selectedTeam == 'Personal') {
      return state.websites.where((w) => w.teamId == null).toList();
    }
    if (state.selectedTeam != 'All') {
      final team = state.teams
          .where((t) => t.name == state.selectedTeam)
          .firstOrNull;
      if (team != null) {
        return state.websites.where((w) => w.teamId == team.id).toList();
      }
    }
    return state.websites;
  }

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
        actions: [
          IconBtn(
              icon: Icons.settings_rounded,
              click: () => Navigation.go(
                  screen: SettingsScreen(fromWebsitesScreen: true),
                  context: context)),
          SizedBox(width: 15),
        ],
      ),
      body: BlocConsumer<WebsiteCubit, WebsiteState>(
        listener: (context, state) {
          if (state is WebsiteError) {
            Toast.showToast(message: state.message, context: context);
          }
        },
        builder: (context, state) {
          final websites = _filterWebsites(state);
          final hasTeams = state.teams.isNotEmpty;
          return Column(
            children: [
              if (hasTeams)
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: CustomDropDown(
                    selectedItem: state.selectedTeam,
                    items: [
                      'All',
                      'Personal',
                      ...state.teams.map((t) => t.name),
                    ],
                    hint: 'All',
                    preIcon: Icons.groups_rounded,
                    onChanged: context.read<WebsiteCubit>().selectTeam,
                    removePadding: true,
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: context.read<WebsiteCubit>().getWebsites,
                  child: (state is WebsiteLoading)
                      ? LoadingIndicator()
                      : websites.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(height: 80),
                                EmptyState(),
                                MordernBtn(
                                  icon: Icons.replay_outlined,
                                  title: 'Refresh',
                                  click:
                                      context.read<WebsiteCubit>().getWebsites,
                                ),
                                MordernBtn(
                                  icon: Icons.logout_rounded,
                                  title: 'Logout',
                                  click: () => AuthRepo().signOut(context),
                                ),
                              ],
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                color: kGreyColor.withOpacity(.2),
                                height: 20,
                                endIndent: 20,
                                indent: 20,
                              ),
                              padding: EdgeInsets.all(15.0),
                              itemBuilder: (_, i) => WebCard(website: websites[i]),
                              itemCount: websites.length,
                            ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
