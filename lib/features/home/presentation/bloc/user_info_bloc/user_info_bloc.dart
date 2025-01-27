import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/core/utils/helpers/app_functions.dart';
import 'package:weather_app/features/home/data/models/user_info_model.dart';
import 'package:weather_app/features/home/domain/usecases/fetch_user_info_usecase.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final FetchUserInfoUsecase userInfoRepository;
  UserInfoBloc({required this.userInfoRepository}) : super(UserInfoInitial()) {
    on<UserInfoEvent>((event, emit) async {
      if (event is FetchUserInfoEvent) {
        emit(LoadingUserInfoState());
        final userProfile = await userInfoRepository.call();
        userProfile.fold(
          (failure) {
            final String errorMessage =
                AppFunctions.mapFailureToMessage(failure: failure);
            String? errorCode;
            if (failure is ServerFailure) {
              errorCode = failure.errorCode;
            }
            emit(ErrorUserInfoState(
                message: errorMessage, errorCode: errorCode));
          },
          (userInfo) {
            emit(
              LoadedUserInfoState(userInfo: userInfo),
            );
          },
        );
      }
    });
  }
}
