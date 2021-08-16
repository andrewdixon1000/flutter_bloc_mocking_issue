import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(FirstState());

  @override
  Stream<MyState> mapEventToState(
    MyEvent event,
  ) async* {
    if (event is TriggerStateChange) {
      yield SecondState();
    }
  }
}
