import 'package:mohalla_bazaar/modules/cart/domain/entities/viewcart_entity.dart';

abstract class ViewCartRepository {
  /// तुरंत स्थानीय cache से data return करो (या null अगर नहीं है)
  Future<ViewCartEntity?> getCachedViewCart(String userId);

  /// API से fresh data fetch करो
  Future<ViewCartEntity> fetchViewCartFromApi(String userId);

  
}
