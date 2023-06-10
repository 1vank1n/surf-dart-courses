enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

Set<AgriculturalMachinery> getAgriculturalMachineries() {
  final machineriesBefore2010 = _prepareMap(mapBefore2010);
  final machineriesAfter2010 = _prepareMap(mapAfter2010);
  final machineries = {
    ...machineriesBefore2010,
    ...machineriesAfter2010,
  };
  return machineries;
}

Set<AgriculturalMachinery> _prepareMap(Map<Countries, List<Territory>> sourceMap) {
  Set<AgriculturalMachinery> machineries = {};
  for (List<Territory> territories in sourceMap.values) {
    for (Territory territory in territories) {
      machineries.addAll(territory.machineries);
    }
  }
  return machineries;
}

List<int> getMachineriesAgeList(Iterable<AgriculturalMachinery> machineries) {
  return machineries
      .map((AgriculturalMachinery machinery) => _getAge(machinery.releaseDate))
      .toList();
}

int _getAge(DateTime date) {
  return DateTime.now().year - date.year;
}

double getAverage(Iterable<int> source) {
  final sum = source.reduce((value, element) => value + element);
  return sum / source.length;
}

List<int> getSortedAgeList(List<int> ageList) {
  final sortedAgeList = ageList..sort((a, b) => b.compareTo(a));
  return sortedAgeList;
}

void main() {
  final machineries = getAgriculturalMachineries();
  final allMachineriesAgeList = getMachineriesAgeList(machineries);
  final allMachineriesAge = getAverage(allMachineriesAgeList).toStringAsFixed(2);
  print('Средний возраст всей техники: $allMachineriesAge лет');

  final sortedAgeList = getSortedAgeList(allMachineriesAgeList);
  final oldestAgeList = sortedAgeList.sublist(0, sortedAgeList.length ~/ 2);
  final oldestMachineriesAge = getAverage(oldestAgeList).toStringAsFixed(2);
  print('Средний возраст самой старой техники: $oldestMachineriesAge лет');
}
