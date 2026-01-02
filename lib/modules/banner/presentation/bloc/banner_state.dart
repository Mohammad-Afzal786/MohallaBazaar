import 'package:equatable/equatable.dart';
import '../../domain/entities/banner_entity.dart';

enum BannerStatus { initial, loading, success, failure }

class BannerState extends Equatable {
  final BannerStatus status;
  final List<BannerEntity> banners;
  final String? error;

  const BannerState({required this.status, required this.banners, this.error});

  factory BannerState.initial() => const BannerState(status: BannerStatus.initial, banners: []);

  BannerState copyWith({
    BannerStatus? status,
    List<BannerEntity>? banners,
    String? error,
  }) {
    return BannerState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, banners, error];
}
