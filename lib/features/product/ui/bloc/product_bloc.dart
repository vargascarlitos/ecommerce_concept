import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_concept/app_config/error/failure.dart';
import 'package:ecommerce_concept/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_concept/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'product_event.dart';

part 'product_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

const int _limit = 10;
const int _initialSkip = 0;

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductState()) {
    on<ProductFetched>(
      _onProductFetched,
      transformer: throttleDroppable(
        const Duration(milliseconds: 100),
      ),
    );

    on<ProductRefreshed>(
      (event, emit) {
        emit(const ProductState());
        add(ProductFetched());
      },
    );
  }

  final ProductRepository _productRepository;

  Future<void> _onProductFetched(
      ProductFetched event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;

    final result = await _productRepository.getProducts(
      skip: state.skip < 1 ? _initialSkip : state.skip,
      limit: _limit,
    );

    if (result.isError) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
          failure: result.asError!.error as ServerFailure,
        ),
      );
    } else if (result.asValue!.value.isEmpty) {
      emit(
        state.copyWith(
          status: ProductStatus.success,
          hasReachedMax: true,
        ),
      );
    } else {
      final products = result.asValue!.value;
      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: [...state.products, ...products],
          hasReachedMax: false,
          skip: products.last.id,
        ),
      );
    }
  }
}
