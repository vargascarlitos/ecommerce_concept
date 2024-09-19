part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

final class ProductFetched extends ProductEvent {
  @override
  List<Object> get props => [];
}
