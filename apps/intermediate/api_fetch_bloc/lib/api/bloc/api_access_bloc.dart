import 'package:equatable/equatable.dart';

sealed class ApiRequestState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiRequestStateInitial extends ApiRequestState {}

class ApiRequestStateWaiting extends ApiRequestState {}

class ApiRequestStateResolved<T> extends ApiRequestState {
  final T item;

  ApiRequestStateResolved(this.item);
  @override
  List<Object?> get props => super.props..add(item);
}

class ApiRequestStateRejected<T> extends ApiRequestState {
  final T failedPayload;
  final dynamic reason;

  ApiRequestStateRejected(this.failedPayload, this.reason);
  @override
  List<Object?> get props => super.props..addAll([failedPayload, reason]);
}

abstract class ApiRequestEvent extends Equatable {}
