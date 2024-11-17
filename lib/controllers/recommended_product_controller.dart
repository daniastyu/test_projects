import 'package:delivery_app/modeles/product_model.dart';
import 'package:get/get.dart';
import 'package:delivery_app/data/repository/recommended_product_repo.dart';



class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
   bool _isloded = false;
  bool get isloded => _isloded;

  Future<void> getrecommendedproductList() async{
    Response response =await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isloded = true;
      update();
    }else{

    }
  }

}