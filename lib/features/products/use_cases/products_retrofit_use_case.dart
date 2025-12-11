import '../../../core/network/api/products_api.dart';

class ProductsRetrofitUseCase {
  final ProductsApi _api;

  ProductsRetrofitUseCase(this._api);

  Future<List<ProductDTO>> getProducts({int page = 1, int limit = 10}) async {
    try {
      return await _api.getProducts(page, limit);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<ProductDTO> getProductById(String id) async {
    try {
      if (id.trim().isEmpty) {
        throw Exception('Product ID cannot be empty');
      }
      return await _api.getProductById(id);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  Future<ProductDTO> createProduct({
    required String name,
    required String description,
    required double price,
    required String categoryId,
  }) async {
    try {
      if (name.trim().isEmpty) {
        throw Exception('Product name cannot be empty');
      }
      if (price <= 0) {
        throw Exception('Price must be greater than zero');
      }

      final request = CreateProductRequest(
        name: name,
        description: description,
        price: price,
        categoryId: categoryId,
      );

      return await _api.createProduct(request);
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<ProductDTO> updateProduct({
    required String id,
    String? name,
    String? description,
    double? price,
    String? categoryId,
  }) async {
    try {
      if (id.trim().isEmpty) {
        throw Exception('Product ID cannot be empty');
      }

      final request = UpdateProductRequest(
        name: name,
        description: description,
        price: price,
        categoryId: categoryId,
      );

      return await _api.updateProduct(id, request);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      if (id.trim().isEmpty) {
        throw Exception('Product ID cannot be empty');
      }
      await _api.deleteProduct(id);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<List<ProductDTO>> searchProducts({
    required String query,
    String? category,
    Map<String, dynamic>? filters,
  }) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query cannot be empty');
      }
      return await _api.searchProducts(query, category, filters);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}

