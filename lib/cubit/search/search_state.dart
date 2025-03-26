part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;
  SearchLoaded(this.products);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}