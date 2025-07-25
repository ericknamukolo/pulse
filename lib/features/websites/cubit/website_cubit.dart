import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/utils/utils.dart';

import '../models/website.dart';
import '../repo/website_repo.dart';

part 'website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> {
  WebsiteCubit() : super(WebsiteInitial());

  Future<void> getWebsites() async {
    emit(WebsiteLoading(websites: state.websites));
    try {
      var websites = await WebsiteRepo().getWebsites();
      emit(WebsiteLoaded(websites: websites));
    } catch (e) {
      emit(WebsiteError(message: e.toString()));
    }
  }

  Future<void> addWebsite(
      {required String name, required String domain, context}) async {
    emit(WebsiteAdding(websites: state.websites));
    try {
      await WebsiteRepo().addWebsite(domain: domain, name: name);
      Toast.showToast(message: '$name added successfully', context: context);
      emit(WebsiteLoaded(websites: state.websites));
      getWebsites();
      Navigator.of(context).pop();
    } catch (e) {
      emit(WebsiteError(message: e.toString(), websites: state.websites));
    }
  }

  Future<void> editWebsite(
      {required String name,
      required String domain,
      required String id,
      context}) async {
    emit(WebsiteAdding(websites: state.websites));
    try {
      await WebsiteRepo().editWebsite(domain: domain, name: name, id: id);
      Toast.showToast(message: '$name edited successfully', context: context);
      emit(WebsiteLoaded(websites: state.websites));
      getWebsites();
      Navigator.of(context).pop();
    } catch (e) {
      emit(WebsiteError(message: e.toString(), websites: state.websites));
    }
  }
}
