import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> {
  WebsiteCubit() : super(WebsiteInitial());
}
