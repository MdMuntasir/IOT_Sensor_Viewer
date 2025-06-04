import '../../domain/entity/show_data_entity.dart';

sealed class ShowDataEvent {
  const ShowDataEvent();
}

class InitialShowDataEvent extends ShowDataEvent {

}

class SubscribeTopicEvent extends ShowDataEvent{
  final String? topic;
  final Function(List<ShowDataEntity>)? onMessageReceived;
  const SubscribeTopicEvent(
      this.topic,
      this.onMessageReceived,
      );
}
