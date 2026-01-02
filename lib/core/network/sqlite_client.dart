import 'package:mohalla_bazaar/modules/notification/data/models/notification_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mohalla_bazaar/modules/cart/data/models/viewcart_cache_model.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';
import 'package:mohalla_bazaar/modules/category_details/data/models/category_details_cache_model.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_cache_model.dart';

class SQLiteClient {
  static late Database _db;

  /// Initialize database
  static Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "app_database.db");

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createTables(db);
      },
    );
  }

  /// Create all necessary tables
  static Future<void> _createTables(Database db) async {
    // Categories
    await db.execute('''
      CREATE TABLE IF NOT EXISTS categories(
        categoryId TEXT PRIMARY KEY,
        parentName TEXT,
        parentId TEXT,
        parentImage TEXT,
        parentSubtitle TEXT,
        categoryName TEXT,
        image TEXT,
        subtitle TEXT
      )
    ''');

    // Parent Category Details
    await db.execute('''
      CREATE TABLE IF NOT EXISTS parent_category_details(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id TEXT UNIQUE,
        jsonData TEXT,
        lastUpdated TEXT
      )
    ''');

    // Category Details
    await db.execute('''
      CREATE TABLE IF NOT EXISTS category_details(
  category_id TEXT PRIMARY KEY,
  jsonData TEXT,
  lastUpdated TEXT
);

    ''');

    // Cart Count
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cart_count(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        count INTEGER
      )
    ''');

    // View Cart
    await db.execute('''
      CREATE TABLE IF NOT EXISTS view_cart(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT UNIQUE,
        jsonResponse TEXT,
        savedAt TEXT
      )
    ''');
    // Order History
    await db.execute('''
      CREATE TABLE IF NOT EXISTS order_history_cache(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT UNIQUE,
        jsonResponse TEXT,
        savedAt TEXT
      )
    ''');

    // User Addresses
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_addresses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        detail TEXT,
        latitude REAL,
        longitude REAL,
        isSelected INTEGER DEFAULT 0
      )
    ''');
        // Parent Categories
    await db.execute('''
      CREATE TABLE IF NOT EXISTS parent_categories(
        parentCategoryId TEXT PRIMARY KEY,
        parentCategoryName TEXT,
        parentCategoryImage TEXT,
        parentCategorytitle TEXT,
        isActive INTEGER DEFAULT 1,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

     await db.execute('''
CREATE TABLE IF NOT EXISTS notifications(
    id TEXT PRIMARY KEY,
    title TEXT,
    message TEXT,
    image TEXT,
    read INTEGER DEFAULT 0,
    createdAt TEXT
);

''');
await db.execute('''
          CREATE TABLE IF NOT EXISTS home_category_products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            json TEXT,
            lastUpdated TEXT
          )
        ''');

         await db.execute('''
          CREATE TABLE IF NOT EXISTS banners(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            json TEXT,
            lastUpdated TEXT
          )
        ''');
  }

  /// Database instance getter
  static Database get instance => _db;

  // ============================================================
  // CATEGORY CACHE
  // ============================================================
  static Future<void> saveCategories(List<CategoryCacheModel> list) async {
    await _db.transaction((txn) async {
      await txn.delete('categories');
      for (var c in list) {
        await txn.insert('categories', c.toMap());
      }
    });
  }

  static Future<List<CategoryCacheModel>> getCategories() async {
    final maps = await _db.query('categories');
    return maps.map((m) => CategoryCacheModel.fromMap(m)).toList();
  }

  // ============================================================
  // PARENT CATEGORY DETAILS CACHE
  // ============================================================
  static Future<void> saveParentCategoryDetails(
    List<ParentCategoryDetailsCacheModel> list,
    int categoryId,
  ) async {
    await _db.transaction((txn) async {
      // Delete only this category's old data
      await txn.delete(
        'parent_category_details',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      // Insert new data
      for (var p in list) {
        await txn.insert(
          'parent_category_details',
          p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static Future<List<ParentCategoryDetailsCacheModel>> getParentCategoryDetails(
    int categoryId,
  ) async {
    final maps = await _db.query(
      'parent_category_details',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return maps.map((m) => ParentCategoryDetailsCacheModel.fromMap(m)).toList();
  }

  // ============================================================
  // CATEGORY DETAILS CACHE (per category, clean + consistent)
  // ============================================================
  // Save per category (categoryId as String)
  static Future<void> saveCategoryDetails(
    List<CategoryDetailsCacheModel> list,
    String categoryId, // <- String type consistent with model
  ) async {
    await _db.transaction((txn) async {
      // Delete only old data of this category
      await txn.delete(
        'category_details',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      // Insert new data for this category
      for (var c in list) {
        await txn.insert('category_details', {
          'category_id': categoryId,
          'jsonData': c.jsonData,
          'lastUpdated': c.lastUpdated.toIso8601String(),
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  static Future<List<CategoryDetailsCacheModel>> getCategoryDetails(
    String categoryId, // <- String type consistent with model
  ) async {
    final maps = await _db.query(
      'category_details',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    return maps
        .map(
          (m) => CategoryDetailsCacheModel(
            categoryId: m['category_id'] as String,
            jsonData: m['jsonData'] as String,
            lastUpdated: DateTime.parse(m['lastUpdated'] as String),
          ),
        )
        .toList();
  }

  // // ============================================================
  // // CATEGORY DETAILS CACHE
  // // ============================================================
  // static Future<void> saveCategoryDetails(
  //   List<CategoryDetailsCacheModel> list,
  // ) async {
  //   await _db.transaction((txn) async {
  //     await txn.delete('category_details');
  //     for (var c in list) {
  //       await txn.insert('category_details', {
  //         'categoryId': c.categoryId,
  //         'jsonData': c.jsonData,
  //         'lastUpdated': c.lastUpdated.toIso8601String(),
  //       });
  //     }
  //   });
  // }

  // static Future<List<CategoryDetailsCacheModel>> getCategoryDetails() async {
  //   final maps = await _db.query('category_details');
  //   return maps
  //       .map(
  //         (m) => CategoryDetailsCacheModel(
  //           categoryId: m['categoryId'] as String,
  //           jsonData: m['jsonData'] as String,
  //           lastUpdated: DateTime.parse(m['lastUpdated'] as String),
  //         ),
  //       )
  //       .toList();
  // }

  // ============================================================
  // CART COUNT CACHE
  // ============================================================
  static Future<void> saveCartCount(int count) async {
    await _db.transaction((txn) async {
      await txn.delete('cart_count');
      await txn.insert('cart_count', {'count': count});
    });
  }

  static Future<int> getCartCount() async {
    final list = await _db.query('cart_count', limit: 1);
    if (list.isEmpty) return 0;
    return list.first['count'] as int;
  }

  // ============================================================
  // VIEW CART CACHE
  // ============================================================
  static Future<void> saveViewCart(ViewCartCacheModel model) async {
    await _db.insert(
      'view_cart',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<ViewCartCacheModel?> getViewCart(String userId) async {
    final list = await _db.query(
      'view_cart',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (list.isEmpty) return null;
    return ViewCartCacheModel.fromMap(list.first);
  }

  // ============================================================
  // USER ADDRESSES CRUD
  // ============================================================
  static Future<int> insertAddress(Map<String, dynamic> data) async {
    return await _db.insert('user_addresses', data);
  }

  static Future<List<Map<String, dynamic>>> getAddresses() async {
    return await _db.query('user_addresses', orderBy: 'id DESC');
  }

  static Future<int> updateAddress(int id, Map<String, dynamic> data) async {
    return await _db.update(
      'user_addresses',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAddress(int id) async {
    return await _db.delete('user_addresses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> selectAddress(int id) async {
    await _db.update('user_addresses', {'isSelected': 0});
    await _db.update(
      'user_addresses',
      {'isSelected': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<Map<String, dynamic>?> getSelectedAddress() async {
    final list = await _db.query(
      'user_addresses',
      where: 'isSelected = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (list.isNotEmpty) return list.first;
    return null;
  }

  // ============================================================
  // ORDER HISTORY CACHE
  // ============================================================
  static Future<void> saveOrderHistory(String userId, String json) async {
    await _db.insert(
      'order_history_cache',
      {
        'userId': userId,
        'jsonResponse': json,
        'savedAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // old data replace
    );
  }

  static Future<Map<String, dynamic>?> getOrderHistory(String userId) async {
    final list = await _db.query(
      'order_history_cache',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'savedAt DESC',
      limit: 1,
    );
    if (list.isEmpty) return null;
    return list.first;
  }

  // SQLiteClient.dart
  static Future<void> removeOrderHistory(String userId) async {
    try {
      await _db.delete(
        'order_history_cache',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      print("✅ Cache deleted for userId=$userId");
    } catch (e) {
      print("❌ Failed to remove cached OrderHistory: $e");
    }
  }




  // ============================================================
  // NOTIFICATION CACHE
  // ============================================================
  static Future<void> saveNotifications(List<NotificationModel> list) async {
    final db = _db;
    await db.transaction((txn) async {
      for (var n in list) {
        await txn.insert(
          'notifications',
          {
            'id': n.id,
            'title': n.title,
            'message': n.message,
            'image': n.image ,
            'read': n.read ? 1 : 0,
            'createdAt': n.createdAt,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static Future<List<NotificationModel>> getNotifications() async {
    final db = _db;
    final maps = await db.query('notifications', orderBy: 'createdAt DESC');

    return maps
        .map(
          (m) => NotificationModel(
            id: m['id'] as String,
            title: m['title'] as String? ?? '',
            message: m['message'] as String? ?? '',
            image: m['image'] as String? ?? '',
            read: (m['read'] as int? ?? 0) == 1,
            createdAt:
                (m['createdAt'] as String ) ,
          ),
        )
        .toList();
  }

  static Future<void> markAsRead(String id) async {
    final db = _db;
    await db.update(
      'notifications',
      {'read': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }



   static Future<void> saveCache(String json) async {
    await _db.delete('home_category_products');
    await _db.insert('home_category_products', {
      'json': json,
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  static Future<String?> getCache() async {
    final list = await _db.query('home_category_products', limit: 1);
    if (list.isNotEmpty) return list.first['json'] as String;
    return null;
  }


  static Future<void> savebannerCache(String json) async {
    await _db.delete('banners');
    await _db.insert('banners', {
      'json': json,
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  static Future<String?> getbannerCache() async {
    final result = await _db.query('banners', limit: 1);
    if (result.isNotEmpty) return result.first['json'] as String;
    return null;
  }






    // ============================================================
  // PARENT CATEGORY CACHE
  // ============================================================

// ============================================================
  // PARENT CATEGORY CACHE
  // ============================================================
  static Future<void> saveParentCategories(List<Map<String, dynamic>> list) async {
    await _db.transaction((txn) async {
      await txn.delete('parent_categories');
      for (var item in list) {
        await txn.insert('parent_categories', item, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  static Future<List<Map<String, dynamic>>> getParentCategories() async {
    return await _db.query('parent_categories');
  }
}  