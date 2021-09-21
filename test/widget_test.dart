import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:test_bloc_issue/bloc/my_bloc.dart';
import 'package:test_bloc_issue/first_page.dart';

class MockMyBloc extends MockBloc<MyEvent, MyState> implements MyBloc {}

class FakeMyState extends Fake implements MyState {}

class FakeMyEvent extends Fake implements MyEvent {}

void main() {
  const nextScreenPlaceHolder = SizedBox();
  late MockMyBloc mockMyBloc;

  setUpAll(() async {
    registerFallbackValue<MyState>(FakeMyState());
    registerFallbackValue<MyEvent>(FakeMyEvent());

    final di = GetIt.instance;
    di.registerFactory<MyBloc>(() => mockMyBloc);
  });

  setUp(() {
    mockMyBloc = MockMyBloc();
  });

  testWidgets(
      'renders nextScreenPlaceholder '
      'when state changes from first to second', (tester) async {
    final initialState = FirstState();
    whenListen(
      mockMyBloc,
      Stream.fromIterable([initialState, SecondState()]),
      initialState: initialState,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: FirstPage(),
        routes: <String, WidgetBuilder>{
          'SECONDPAGE': (_) => nextScreenPlaceHolder
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byWidget(nextScreenPlaceHolder), findsOneWidget);
  });

  testWidgets('adds TriggerStateChange when button is tapped', (tester) async {
    when(() => mockMyBloc.state).thenReturn(FirstState());

    await tester.pumpWidget(
      MaterialApp(
        home: FirstPage(),
        routes: <String, WidgetBuilder>{
          'SECONDPAGE': (_) => nextScreenPlaceHolder
        },
      ),
    );

    await tester.tap(find.byType(ElevatedButton));

    verify(
      () => mockMyBloc.add(any(that: isA<TriggerStateChange>())),
    ).called(1);
  });
}
