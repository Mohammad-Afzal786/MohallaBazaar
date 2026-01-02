import '../../data/models/banner_model.dart';

class BannerEntity {

  final String imageUrl;
  final String count;
  final String createdAt;

  BannerEntity({
 
    required this.imageUrl,
    required this.count,
    required this.createdAt,
  });

  factory BannerEntity.fromModel(BannerModel model) => BannerEntity(
      
        imageUrl: model.imageUrl,
        count: model.count,
        createdAt: model.createdAt,
      );
}
