import 'package:equatable/equatable.dart';

enum FeedbackOrderStatus {
  init,
  loading,
  successFeedback,
  error,
}

class FeedbackOrderState extends Equatable {
  final FeedbackOrderStatus status;
  final String message;
  const FeedbackOrderState({
    this.status: FeedbackOrderStatus.init,
    this.message: '',
  });

  FeedbackOrderState copyWith({
    FeedbackOrderStatus status,
    String message,
  }) =>
      FeedbackOrderState(
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  List<Object> get props => [
        status,
        message,
      ];
}
