// Mocks generated by Mockito 5.2.0 from annotations
// in toxicity_checker/test/clients/nutrition_ix_client_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rest_client/rest_client.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDuration_0 extends _i1.Fake implements Duration {}

class _FakeResponse_1 extends _i1.Fake implements _i2.Response {}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i2.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Duration get timeout => (super.noSuchMethod(Invocation.getter(#timeout),
      returnValue: _FakeDuration_0()) as Duration);
  @override
  _i3.Future<_i2.Response> execute(
          {_i2.Authorizer? authorizer,
          _i3.StreamController<_i2.Response>? emitter,
          bool? jsonResponse = true,
          _i2.Request? request,
          _i2.Reporter? reporter,
          int? retryCount = 0,
          Duration? retryDelay = const Duration(seconds: 1),
          _i2.DelayStrategy? retryDelayStrategy,
          Duration? timeout}) =>
      (super.noSuchMethod(
              Invocation.method(#execute, [], {
                #authorizer: authorizer,
                #emitter: emitter,
                #jsonResponse: jsonResponse,
                #request: request,
                #reporter: reporter,
                #retryCount: retryCount,
                #retryDelay: retryDelay,
                #retryDelayStrategy: retryDelayStrategy,
                #timeout: timeout
              }),
              returnValue: Future<_i2.Response>.value(_FakeResponse_1()))
          as _i3.Future<_i2.Response>);
}

/// A class which mocks [Response].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockResponse extends _i1.Mock implements _i2.Response {
  MockResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, String> get headers =>
      (super.noSuchMethod(Invocation.getter(#headers),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  int get statusCode =>
      (super.noSuchMethod(Invocation.getter(#statusCode), returnValue: 0)
          as int);
}
