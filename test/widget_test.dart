import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:get_it/get_it.dart';
import 'package:test_bloc_issue/bloc/my_bloc.dart';
import 'package:test_bloc_issue/first_page.dart';

class MockMyBloc extends MockBloc<MyEvent, MyState> implements MyBloc {}
class FakeMyState extends Fake implements MyState {}
class FakeMyEvent extends Fake implements MyEvent {}

void main() {
  MockMyBloc mockMyBloc;
  mocktail.registerFallbackValue<MyState>(FakeMyState());
  mocktail.registerFallbackValue<MyEvent>(FakeMyEvent());
  mockMyBloc = MockMyBloc();

  var nextScreenPlaceHolder = Container();

  setUpAll(() async {
    final di = GetIt.instance;
    di.registerFactory<MyBloc>(() => mockMyBloc);
  });

  _loadScreen(WidgetTester tester) async {
    mocktail.when(() => mockMyBloc.state).thenReturn(FirstState());
    await tester.pumpWidget(
      MaterialApp(
        home: FirstPage(),
        routes: <String, WidgetBuilder> {
          'SECONDPAGE': (context) => nextScreenPlaceHolder
        }
      )
    );
  }

  testWidgets('test', (WidgetTester tester) async {
    await _loadScreen(tester);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    
    // What do I need to do here to mock the state change that would
    // happen in the real bloc when a TriggerStateChange event is received,
    // such that the listener in my BlocConsumer will see it?
    // if tried:
    // whenListen(mockMyBloc, Stream<MyState>.fromIterable([SecondState()]));
    // and
    // mocktail.when(() => mockMyBloc.state).thenReturn(SecondState());
    await tester.pumpAndSettle();

    expect(find.byWidget(nextScreenPlaceHolder), findsOneWidget);
  });
}
