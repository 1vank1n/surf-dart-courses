final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

class Item {
  final int id;
  final String category;
  final String name;
  final double price;
  final int quantity;

  Item({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Item.fromString(String item) {
    List<String> parts = item.split(',');
    return Item(
      id: int.parse(parts[0]),
      category: parts[1],
      name: parts[2],
      price: double.parse(parts[3]),
      quantity: int.parse(parts[4]),
    );
  }

  @override
  String toString() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'price': price,
      'quantity': quantity,
    }.toString();
  }
}

void main() {
  final List<Item> items = parseItems(articles);
  print('Все товары:\n');
  printItemsAsTable(items);
  print('\n');

  // Затем напишите несколько реализаций интерфейса `Filter`, которые фильтрует товары
  // по категории;
  final waterItems = applyFilter(items, FilterByCategory('хлеб'));
  print('Товары отфильтрованные по категории хлеб:');
  printItemsAsTable(waterItems);
  print('\n');

  // по цене (не больше указанной);
  final cheapItems = applyFilter(items, FilterByPrice(50));
  print('Товары отфильтрованные по цене ниже 50 руб:');
  printItemsAsTable(cheapItems);
  print('\n');

  // по количеству остатков на складе (меньше указанной).
  final lowQuantityItems = applyFilter(items, FilterByQuantity(5));
  print('Товары отфильтрованные по количеству остатков на складе меньше 5:');
  printItemsAsTable(lowQuantityItems);
  print('\n');

  // Например, нужно вывести все товары, стоимость которой до/равно 500:
  final itemsBy500 = applyFilter(items, FilterByPrice(500));
  print('все товары, стоимость которой до/равно 500:');
  printItemsAsTable(itemsBy500);
}

List<Item> parseItems(String items) {
  return items
      .split('\n')
      .where((item) => item.isNotEmpty)
      .map((item) => Item.fromString(item.trim()))
      .toList();
}

List<Item> applyFilter(List<Item> items, Filter filter) {
  return items.where((item) => filter.apply(item)).toList();
}

abstract class Filter {
  bool apply(Item item);
}

class FilterByCategory implements Filter {
  final String category;

  FilterByCategory(this.category);

  @override
  bool apply(Item item) {
    return item.category == category;
  }
}

class FilterByPrice implements Filter {
  final double price;

  FilterByPrice(this.price);

  @override
  bool apply(Item item) {
    return item.price <= price;
  }
}

class FilterByQuantity implements Filter {
  final int quantity;

  FilterByQuantity(this.quantity);

  @override
  bool apply(Item item) {
    return item.quantity <= quantity;
  }
}

void printItemsAsTable(List<Item> items) {
  print('id\tcategory\tname\tprice\tquantity');
  for (var item in items) {
    print('${item.id}\t${item.category}\t${item.name}\t${item.price}\t${item.quantity}');
  }
}
