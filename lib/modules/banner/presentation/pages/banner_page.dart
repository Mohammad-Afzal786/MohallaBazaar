import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/auth_injection.dart';
import '../bloc/banner_bloc.dart';
import '../bloc/banner_event.dart';
import '../bloc/banner_state.dart';


class BannerPage extends StatelessWidget {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BannerBloc>()..add(BannerRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Banners")),
        body: 
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state.status == BannerStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == BannerStatus.failure) {
              return Center(child: Text("Error: ${state.error}"));
            } else if (state.banners.isEmpty) {
              return const Center(child: Text("No Banners Found"));
            } else {
              return PageView.builder(
                itemCount: state.banners.length,
                itemBuilder: (context, index) {
                  final banner = state.banners[index];
                  return Image.network(
                    banner.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
