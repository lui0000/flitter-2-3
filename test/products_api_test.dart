import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:project1/core/network/api/products_api.dart';

@GenerateMocks([ProductsApi])
import 'products_api_test.mocks.dart';

void main() {
  late MockProductsApi mockProductsApi;

  setUp(() {
    mockProductsApi = MockProductsApi();
  });

  group('ProductsApi Tests', () {
    test('getProducts returns list of products', () async {
      final mockProducts = [
        ProductDTO(
          id: '1',
          name: 'Product 1',
          description: 'Description 1',
          price: 99.99,
          categoryId: 'cat1',
          createdAt: '2024-01-01',
        ),
        ProductDTO(
          id: '2',
          name: 'Product 2',
          description: 'Description 2',
          price: 149.99,
          categoryId: 'cat2',
          createdAt: '2024-01-02',
        ),
      ];

      when(mockProductsApi.getProducts(1, 10))
          .thenAnswer((_) async => mockProducts);

      final result = await mockProductsApi.getProducts(1, 10);

      expect(result, isA<List<ProductDTO>>());
      expect(result.length, 2);
      expect(result[0].name, 'Product 1');
      verify(mockProductsApi.getProducts(1, 10)).called(1);
    });

    test('getProductById returns single product', () async {
      final mockProduct = ProductDTO(
        id: '1',
        name: 'Test Product',
        description: 'Test Description',
        price: 99.99,
        categoryId: 'cat1',
        createdAt: '2024-01-01',
      );

      when(mockProductsApi.getProductById('1'))
          .thenAnswer((_) async => mockProduct);

      final result = await mockProductsApi.getProductById('1');

      expect(result, isA<ProductDTO>());
      expect(result.id, '1');
      expect(result.name, 'Test Product');
      verify(mockProductsApi.getProductById('1')).called(1);
    });

    test('createProduct returns created product', () async {
      final request = CreateProductRequest(
        name: 'New Product',
        description: 'New Description',
        price: 79.99,
        categoryId: 'cat1',
      );

      final mockProduct = ProductDTO(
        id: '3',
        name: 'New Product',
        description: 'New Description',
        price: 79.99,
        categoryId: 'cat1',
        createdAt: '2024-01-03',
      );

      when(mockProductsApi.createProduct(request))
          .thenAnswer((_) async => mockProduct);

      final result = await mockProductsApi.createProduct(request);

      expect(result, isA<ProductDTO>());
      expect(result.name, 'New Product');
      expect(result.price, 79.99);
      verify(mockProductsApi.createProduct(request)).called(1);
    });

    test('deleteProduct completes successfully', () async {
      when(mockProductsApi.deleteProduct('1'))
          .thenAnswer((_) async => Future.value());

      await mockProductsApi.deleteProduct('1');

      verify(mockProductsApi.deleteProduct('1')).called(1);
    });

    test('searchProducts returns filtered list', () async {
      final mockProducts = [
        ProductDTO(
          id: '1',
          name: 'Search Result',
          description: 'Description',
          price: 99.99,
          categoryId: 'cat1',
          createdAt: '2024-01-01',
        ),
      ];

      when(mockProductsApi.searchProducts('test', 'cat1', null))
          .thenAnswer((_) async => mockProducts);

      final result = await mockProductsApi.searchProducts('test', 'cat1', null);

      expect(result, isA<List<ProductDTO>>());
      expect(result.length, 1);
      verify(mockProductsApi.searchProducts('test', 'cat1', null)).called(1);
    });
  });
}

