import 'package:delivery_app/data/api/api_client.dart';
import 'package:delivery_app/utils/app_constains.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
   return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);

  }
}