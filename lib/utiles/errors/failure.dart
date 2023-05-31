import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String failureMessage;

  const Failure({
    required this.failureMessage,
  });

  @override
  List<Object> get props => [failureMessage];
}
