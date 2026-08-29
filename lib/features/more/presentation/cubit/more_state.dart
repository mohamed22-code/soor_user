import 'package:equatable/equatable.dart';
import '../../data/models/terms_model.dart';

abstract class MoreState extends Equatable {
  const MoreState();

  @override
  List<Object?> get props => [];
}

class MoreInitial extends MoreState {
  const MoreInitial();
}

class MoreLoading extends MoreState {
  const MoreLoading();
}

class TermsLoaded extends MoreState {
  final TermsResponse terms;

  const TermsLoaded(this.terms);

  @override
  List<Object?> get props => [terms];
}

class MoreError extends MoreState {
  final String message;

  const MoreError(this.message);

  @override
  List<Object?> get props => [message];
}
