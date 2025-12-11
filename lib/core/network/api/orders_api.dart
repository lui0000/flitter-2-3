import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_api.g.dart';

@RestApi(baseUrl: "https://api.example.com/api/v1")
abstract class OrdersApi {
  factory OrdersApi(Dio dio, {String baseUrl}) = _OrdersApi;

  @GET("/orders")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<PaginatedOrdersResponse> getOrders(
    @Query("page") int page,
    @Query("limit") int limit,
    @Query("status") String? status,
  );

  @GET("/orders/{id}")
  Future<OrderDTO> getOrderById(
    @Path("id") String id,
    @Header("X-Request-ID") String requestId,
  );

  @POST("/orders")
  Future<OrderDTO> createOrder(@Body() CreateOrderRequest request);

  @PATCH("/orders/{id}/status")
  Future<OrderDTO> updateOrderStatus(
    @Path("id") String id,
    @Body() UpdateStatusRequest request,
  );

  @DELETE("/orders/{id}")
  @Headers(<String, dynamic>{
    "X-Delete-Reason": "User request",
  })
  Future<void> cancelOrder(@Path("id") String id);

  @GET("/orders/{id}/items")
  Future<List<OrderItemDTO>> getOrderItems(@Path("id") String id);
}

@JsonSerializable()
class OrderDTO {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String status;
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  final List<OrderItemDTO> items;
  @JsonKey(name: 'created_at')
  final String createdAt;

  OrderDTO({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.items,
    required this.createdAt,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDTOFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDTOToJson(this);
}

@JsonSerializable()
class OrderItemDTO {
  @JsonKey(name: 'product_id')
  final String productId;
  @JsonKey(name: 'product_name')
  final String productName;
  final int quantity;
  final double price;

  OrderItemDTO({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDTOFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemDTOToJson(this);
}

@JsonSerializable()
class PaginatedOrdersResponse {
  final List<OrderDTO> data;
  final int page;
  final int limit;
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;

  PaginatedOrdersResponse({
    required this.data,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginatedOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedOrdersResponseToJson(this);
}

@JsonSerializable()
class CreateOrderRequest {
  @JsonKey(name: 'user_id')
  final String userId;
  final List<CreateOrderItemRequest> items;

  CreateOrderRequest({
    required this.userId,
    required this.items,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}

@JsonSerializable()
class CreateOrderItemRequest {
  @JsonKey(name: 'product_id')
  final String productId;
  final int quantity;

  CreateOrderItemRequest({
    required this.productId,
    required this.quantity,
  });

  factory CreateOrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderItemRequestToJson(this);
}

@JsonSerializable()
class UpdateStatusRequest {
  final String status;

  UpdateStatusRequest({required this.status});

  factory UpdateStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateStatusRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateStatusRequestToJson(this);
}

