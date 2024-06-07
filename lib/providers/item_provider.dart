import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/item_model.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>((ref) {
  return ItemNotifier();
});

class ItemNotifier extends StateNotifier<List<Item>> {
  ItemNotifier() : super([]);

  void fetchItems() {
    // Normally this would fetch from an API
    state = [
      // Mock data
      Item(id: 1, title: 'Item 1', description: 'Description 1'),
      Item(id: 2, title: 'Item 2', description: 'Description 2'),
    ];
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  void updateItem(Item item) {
    state = state.map((i) => i.id == item.id ? item : i).toList();
  }

  void deleteItem(int id) {
    state = state.where((i) => i.id != id).toList();
  }
}
