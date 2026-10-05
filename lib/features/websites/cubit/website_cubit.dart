import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/websites/models/team.dart';
import 'package:pulse/utils/utils.dart';

import '../models/website.dart';
import '../repo/website_repo.dart';

part 'website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> {
  WebsiteCubit() : super(WebsiteInitial());

  Future<void> getWebsites() async {
    emit(WebsiteLoading(
        websites: state.websites,
        teams: state.teams,
        selectedTeam: state.selectedTeam));
    try {
      final repo = WebsiteRepo();
      List<Team> teams = [];
      try {
        teams = await repo.getTeams();
      } catch (e) {
        logger.w('Teams unavailable: $e');
      }
      var websites = await repo.getWebsites();
      emit(WebsiteLoaded(
          websites: websites,
          teams: teams,
          selectedTeam:
              _validSelection(state.selectedTeam, teams) ?? 'All'));
    } catch (e) {
      emit(WebsiteError(
          message: e.toString(),
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
    }
  }

  /// Keeps the current selection if it still exists after a refresh.
  String? _validSelection(String selected, List<Team> teams) {
    if (selected == 'All' || selected == 'Personal') return selected;
    return teams.any((t) => t.name == selected) ? selected : null;
  }

  void selectTeam(String? team) {
    if (team == null) return;
    emit(WebsiteLoaded(
        websites: state.websites,
        teams: state.teams,
        selectedTeam: team));
  }

  Future<void> addWebsite(
      {required String name, required String domain, context}) async {
    emit(WebsiteAdding(
        websites: state.websites,
        teams: state.teams,
        selectedTeam: state.selectedTeam));
    try {
      await WebsiteRepo().addWebsite(domain: domain, name: name);
      Toast.showToast(message: '$name added successfully', context: context);
      emit(WebsiteLoaded(
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
      getWebsites();
      Navigator.of(context).pop();
    } catch (e) {
      emit(WebsiteError(
          message: e.toString(),
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
    }
  }

  Future<void> editWebsite(
      {required String name,
      required String domain,
      required String id,
      context}) async {
    emit(WebsiteAdding(
        websites: state.websites,
        teams: state.teams,
        selectedTeam: state.selectedTeam));
    try {
      await WebsiteRepo().editWebsite(domain: domain, name: name, id: id);
      Toast.showToast(message: '$name updated successfully', context: context);
      emit(WebsiteLoaded(
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
      getWebsites();
    } catch (e) {
      emit(WebsiteError(
          message: e.toString(),
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
    }
  }

  Future<void> deleteWebsite(
      {required String name, required String id, context}) async {
    emit(WebsiteAdding(
        websites: state.websites,
        teams: state.teams,
        selectedTeam: state.selectedTeam));
    try {
      await WebsiteRepo().deleteWebsite(id: id);
      Toast.showToast(message: '$name deleted successfully', context: context);
      emit(WebsiteLoaded(
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
      getWebsites();
      Navigator.of(context).pop();
    } catch (e) {
      emit(WebsiteError(
          message: e.toString(),
          websites: state.websites,
          teams: state.teams,
          selectedTeam: state.selectedTeam));
    }
  }
}
