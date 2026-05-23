part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {
  final int pageKey;

  LoadProducts(this.pageKey);
}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}