import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/item_model.dart';

class ApiService {
  final String baseUrl = 'https://mockapi.io/projects/YOUR_PROJECT_ID';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/items'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> addItem(Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add item');
    }
  }

  Future<void> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/items/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/items/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}
