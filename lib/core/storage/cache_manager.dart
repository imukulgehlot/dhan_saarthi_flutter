import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../utils/logger_util.dart';

class APICacheManager {
  APICacheManager._internal();

  static final APICacheManager instance = APICacheManager._internal();

  static final _cacheManager = DefaultCacheManager();

  static Future<void> putFile(String url, Uint8List bytes) async {
    await _cacheManager.putFile(url, bytes, fileExtension: "json");
    logger.i("CacheManager: Saved data for $url");
  }

  static Future<String?> getFileFromCache(String url) async {
    final cacheFile = await _cacheManager.getFileFromCache(url);
    if (cacheFile != null) {
      final cachedData = await cacheFile.file.readAsString();
      logger.i("CacheManager: Fetched data for $url");
      return cachedData;
    }
    return null;
  }

  static clearAll() async => await _cacheManager.emptyCache();
}
