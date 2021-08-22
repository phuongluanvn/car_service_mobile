import 'package:equatable/equatable.dart';

abstract class FeedbackOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}



class DoFeedbackButtonPressed extends FeedbackOrderEvent {
  final String ordeId;
  final int rating;
  final String description;

  DoFeedbackButtonPressed({this.ordeId, this.rating, this.description});
  @override
  List<Object> get props => [ordeId, rating, description];
}

