import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
}
