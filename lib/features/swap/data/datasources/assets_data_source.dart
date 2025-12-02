import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/token_model.dart';

abstract class AssetsDataSource {
  Future<List<TokenModel>> getTokens();
}

class AssetsDataSourceImpl implements AssetsDataSource {
  List<TokenModel>? _cachedTokens;
  
  @override
  Future<List<TokenModel>> getTokens() async {
    if (_cachedTokens != null) {
      return _cachedTokens!;
    }
    
    try {
      final String jsonString = await rootBundle.loadString('assets/data/assets.json');
      final List<dynamic> assetsList = json.decode(jsonString);
      
      _cachedTokens = assetsList
          .map((asset) => TokenModel.fromJson(asset as Map<String, dynamic>))
          .toList();
      return _cachedTokens!;
    } catch (e) {
      throw Exception('Failed to load assets: $e');
    }
  }
}