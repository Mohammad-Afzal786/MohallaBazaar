// Path: lib/features/viewcart/data/datasources/viewcart_local_data_source.dart

import 'dart:convert';

import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:sqflite/sqflite.dart';

import '../models/viewcart_cache_model.dart';
import '../models/viewcart_response.dart';

abstract class ViewCartLocalDataSource {
  Future<ViewCartResponse?> getCachedViewCart(String userId);
  Future<void> cacheViewCart(String userId, ViewCartResponse response);
}

class ViewCartLocalDataSourceImpl implements ViewCartLocalDataSource {
  @override
  Future<ViewCartResponse?> getCachedViewCart(String userId) async {
    final db = SQLiteClient.instance;
    final list = await db.query(
      'view_cart',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (list.isEmpty) return null;

    final cacheModel = ViewCartCacheModel.fromMap(list.first);
    final Map<String, dynamic> json = jsonDecode(cacheModel.jsonResponse);
    return ViewCartResponse.fromJson(json);
  }

  @override
  Future<void> cacheViewCart(String userId, ViewCartResponse response) async {
    final db = SQLiteClient.instance;
    final cacheModel = ViewCartCacheModel(
      userId: userId,
      jsonResponse: jsonEncode(response.toJson()),
      savedAt: DateTime.now(),
    );

    await db.insert(
      'view_cart',
      cacheModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
