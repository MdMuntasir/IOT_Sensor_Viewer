sealed class ShowDataState{
  const ShowDataState();
}

class InitialShowDataState extends ShowDataState{}

class LoadingShowDataState extends ShowDataState{}

class DataLoadedShowDataState extends ShowDataState{}

class DataFailedState extends ShowDataState{
  final String errorMessage;
  const DataFailedState(this.errorMessage);
}