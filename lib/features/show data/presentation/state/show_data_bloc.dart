import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/core/network/data_state.dart';
import 'package:iot/features/show%20data/domain/usecase/connect_client_usecase.dart';
import 'package:iot/features/show%20data/domain/usecase/subscribe_client_usecase.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_event.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_state.dart';

class ShowDataBloc extends Bloc<ShowDataEvent, ShowDataState> {
  SubscribeClientUseCase subscribeClientUseCase;
  ConnectClientUseCase connectClientUseCase;

  ShowDataBloc({
    required this.connectClientUseCase,
    required this.subscribeClientUseCase,
  }) : super(InitialShowDataState()) {
    on<InitialShowDataEvent>(initialShowDataEvent);
    on<SubscribeTopicEvent>(subscribeTopicEvent);
  }

  FutureOr<void> initialShowDataEvent(
      InitialShowDataEvent event, Emitter<ShowDataState> emit) async {
    emit(LoadingShowDataState());
    try
    {
      final dataState = await connectClientUseCase.call();
      if (dataState is DataSuccess) {
        emit(InitialShowDataState());
      } else {
        emit(DataFailedState(dataState.error!));
      }
    }
    on Exception catch(e){
      emit(DataFailedState(e.toString()));
    }
  }

  FutureOr<void> subscribeTopicEvent(
      SubscribeTopicEvent event, Emitter<ShowDataState> emit) async {
    try
    {
      emit(LoadingShowDataState());
      final dataState = await connectClientUseCase.call();

      if (dataState is DataSuccess) {

        await subscribeClientUseCase.call(
            para: SubscribeCred(
              event.topic!,
              event.onMessageReceived!,
            ));
        emit(DataLoadedShowDataState());

      } else {
        emit(DataFailedState(dataState.error!));
      }


    }
    on Exception catch(e){
      emit(DataFailedState(e.toString()));
    }
  }


}
