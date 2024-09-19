import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int rating;
  final String comment;
  final String reviewerName;
  final String reviewerEmail;
  final DateTime date;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.reviewerName,
    required this.reviewerEmail,
    required this.date,
  });

  @override
  List<Object?> get props => [rating, comment, reviewerName, reviewerEmail, date];
}
