import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_api.g.dart';

@RestApi(baseUrl: "https://api.example.com/api/v1")
abstract class ProductsApi {
  factory ProductsApi(Dio dio, {String baseUrl}) = _ProductsApi;

  @GET("/products")
  Future<List<ProductDTO>> getProducts(
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET("/products/{id}")
  Future<ProductDTO> getProductById(@Path("id") String id);

  @POST("/products")
  Future<ProductDTO> createProduct(@Body() CreateProductRequest request);

  @PUT("/products/{id}")
  Future<ProductDTO> updateProduct(
    @Path("id") String id,
    @Body() UpdateProductRequest request,
  );

  @DELETE("/products/{id}")
  Future<void> deleteProduct(@Path("id") String id);

  @GET("/products/search")
  Future<List<ProductDTO>> searchProducts(
    @Query("q") String query,
    @Query("category") String? category,
    @Queries() Map<String, dynamic>? filters,
  );
}

@JsonSerializable()
class ProductDTO {
  final String id;
  final String name;
  final String description;
  final double price;
  @JsonKey(name: 'category_id')
  final String categoryId;
  @JsonKey(name: 'created_at')
  final String createdAt;

  ProductDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.createdAt,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}

@JsonSerializable()
class CreateProductRequest {
  final String name;
  final String description;
  final double price;
  @JsonKey(name: 'category_id')
  final String categoryId;

  CreateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
  });

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProductRequestToJson(this);
}

@JsonSerializable()
class UpdateProductRequest {
  final String? name;
  final String? description;
  final double? price;
  @JsonKey(name: 'category_id')
  final String? categoryId;

  UpdateProductRequest({
    this.name,
    this.description,
    this.price,
    this.categoryId,
  });

  factory UpdateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductRequestToJson(this);
}

