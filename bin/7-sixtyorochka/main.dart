void main() {
  final List<RawProductItem> rawProductItems = getRawProductItems();
  final StructuredCategories products = getStructuredCategories(rawProductItems);
  print(products);
}

typedef StructuredCategories = Map<String, StructuredSubCategory>;
typedef StructuredSubCategory = Map<String, List<String>>;
final DateTime expirationDateForCompare = DateTime(2022, 12, 20);

class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  RawProductItem({
    required this.name,
    required this.categoryName,
    required this.subcategoryName,
    required this.expirationDate,
    required this.qty,
  });
}

List<RawProductItem> getRawProductItems() => [
      RawProductItem(
        name: 'Персик',
        categoryName: 'Растительная пища',
        subcategoryName: 'Фрукты',
        expirationDate: DateTime(2022, 12, 22),
        qty: 5,
      ),
      RawProductItem(
        name: 'Молоко',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Напитки',
        expirationDate: DateTime(2022, 12, 22),
        qty: 5,
      ),
      RawProductItem(
        name: 'Кефир',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Напитки',
        expirationDate: DateTime(2022, 12, 22),
        qty: 5,
      ),
      RawProductItem(
        name: 'Творог',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Не напитки',
        expirationDate: DateTime(2022, 12, 22),
        qty: 0,
      ),
      RawProductItem(
        name: 'Творожок',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Не напитки',
        expirationDate: DateTime(2022, 12, 22),
        qty: 0,
      ),
      RawProductItem(
        name: 'Творог',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Не напитки',
        expirationDate: DateTime(2022, 12, 22),
        qty: 0,
      ),
      RawProductItem(
        name: 'Гауда',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Сыры',
        expirationDate: DateTime(2022, 12, 22),
        qty: 3,
      ),
      RawProductItem(
        name: 'Маасдам',
        categoryName: 'Молочные продукты',
        subcategoryName: 'Сыры',
        expirationDate: DateTime(2022, 12, 22),
        qty: 2,
      ),
      RawProductItem(
        name: 'Яблоко',
        categoryName: 'Растительная пища',
        subcategoryName: 'Фрукты',
        expirationDate: DateTime(2022, 12, 4),
        qty: 4,
      ),
      RawProductItem(
        name: 'Морковь',
        categoryName: 'Растительная пища',
        subcategoryName: 'Овощи',
        expirationDate: DateTime(2022, 12, 23),
        qty: 51,
      ),
      RawProductItem(
        name: 'Черника',
        categoryName: 'Растительная пища',
        subcategoryName: 'Ягоды',
        expirationDate: DateTime(2022, 12, 25),
        qty: 0,
      ),
      RawProductItem(
        name: 'Курица',
        categoryName: 'Мясо',
        subcategoryName: 'Птица',
        expirationDate: DateTime(2022, 12, 18),
        qty: 2,
      ),
      RawProductItem(
        name: 'Говядина',
        categoryName: 'Мясо',
        subcategoryName: 'Не птица',
        expirationDate: DateTime(2022, 12, 17),
        qty: 0,
      ),
      RawProductItem(
        name: 'Телятина',
        categoryName: 'Мясо',
        subcategoryName: 'Не птица',
        expirationDate: DateTime(2022, 12, 17),
        qty: 0,
      ),
      RawProductItem(
        name: 'Индюшатина',
        categoryName: 'Мясо',
        subcategoryName: 'Птица',
        expirationDate: DateTime(2022, 12, 17),
        qty: 0,
      ),
      RawProductItem(
        name: 'Утка',
        categoryName: 'Мясо',
        subcategoryName: 'Птица',
        expirationDate: DateTime(2022, 12, 18),
        qty: 0,
      ),
      RawProductItem(
        name: 'Гречка',
        categoryName: 'Растительная пища',
        subcategoryName: 'Крупы',
        expirationDate: DateTime(2022, 12, 22),
        qty: 8,
      ),
      RawProductItem(
        name: 'Свинина',
        categoryName: 'Мясо',
        subcategoryName: 'Не птица',
        expirationDate: DateTime(2022, 12, 23),
        qty: 5,
      ),
      RawProductItem(
        name: 'Груша',
        categoryName: 'Растительная пища',
        subcategoryName: 'Фрукты',
        expirationDate: DateTime(2022, 12, 25),
        qty: 5,
      ),
    ];

StructuredCategories getStructuredCategories(List<RawProductItem> rawProductItems) {
  StructuredCategories structuredCategories = StructuredCategories();
  for (RawProductItem item in rawProductItems) {
    if (_isNotValidItem(item)) continue;
    structuredCategories = _fillStructureWithCategory(structuredCategories, item);
    structuredCategories = _fillStructureWithSubategory(structuredCategories, item);
  }
  return structuredCategories;
}

bool _isNotValidItem(RawProductItem item) {
  return _itemLessThanZero(item) || _itemIsRotten(item);
}

bool _itemLessThanZero(RawProductItem item) => item.qty <= 0;
bool _itemIsRotten(RawProductItem item) => item.expirationDate.isBefore(expirationDateForCompare);

StructuredCategories _fillStructureWithCategory(
  StructuredCategories structuredCategories,
  RawProductItem item,
) {
  structuredCategories.putIfAbsent(item.categoryName, () => <String, List<String>>{});
  return structuredCategories;
}

StructuredCategories _fillStructureWithSubategory(
  StructuredCategories structuredCategories,
  RawProductItem item,
) {
  structuredCategories[item.categoryName]?.putIfAbsent(item.subcategoryName, () => <String>[]);
  structuredCategories[item.categoryName]?[item.subcategoryName]?.add(item.name);
  return structuredCategories;
}
