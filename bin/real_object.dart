// Пример классов и рейда по игре Warhammer 40k : Dark Tide
// https://warhammer-40k-darktide.fandom.com/wiki/Warhammer_40K_Darktide_Wiki

abstract class Person implements IAtackable {
  final String name;
  final int health = 100;
  final int toughness = 100;

  Person({
    required this.name,
  });

  @override
  String toString() {
    return 'Person {name: $name, health: $health, toughness: $toughness}';
  }
}

abstract class IAtackable {
  int atack(int distance);
}

mixin MMelee {
  int meleeDamage = 40;

  int meleeAtack() {
    print('Enemy melee damaged by $meleeDamage');
    return meleeDamage;
  }
}

mixin MRange {
  int rangeDamage = 30;

  int rangeAtack() {
    print('Enemy range damaged by $rangeDamage');
    return rangeDamage;
  }
}

mixin MGrenade {
  int grenadeDamage = 140;

  int grenadeAtack() {
    print('Enemy grenage damaged by $grenadeDamage');
    return grenadeDamage;
  }
}

mixin MWarp {
  int warpDamage = 200;

  int grenadeAtack() {
    print('Enemy grenage damaged by $warpDamage');
    return warpDamage;
  }
}

class Ogryn extends Person with MMelee, MRange {
  final bool isElectricWeapon;
  String? clan;
  Shield? shield;

  Ogryn({
    required super.name,
    required this.isElectricWeapon,
    this.clan,
    this.shield,
  });

  @override
  get meleeDamage => isElectricWeapon ? 120 : 80;

  @override
  get health => 300;

  @override
  int atack(int distance) {
    if (distance > 100) {
      return rangeAtack();
    }

    return meleeAtack();
  }

  @override
  String toString() {
    var description = super.toString();
    if (clan != null) {
      description += ' Clan: $clan';
    }

    return description;
  }
}

class Shield {
  final int durability;
  String color = 'red';

  Shield(this.durability, this.color);
}

class Veteran extends Person with MMelee, MRange, MGrenade implements IAtackable {
  Veteran({
    required super.name,
  });

  @override
  get health => 150;

  @override
  get toughness => 200;

  @override
  get rangeDamage => 80;

  @override
  int atack(int distance) {
    if (distance >= 150) {
      return rangeAtack();
    } else if (distance > 50) {
      return rangeAtack() + grenadeAtack();
    }

    return meleeAtack();
  }
}

class Zealot extends Person with MMelee, MRange, MGrenade implements IAtackable {
  Zealot({required super.name});

  @override
  get toughness => 200;

  @override
  get meleeDamage => 70;

  @override
  get grenadeDamage => 120;

  @override
  int atack(int distance) {
    if (distance >= 150) {
      return rangeAtack();
    } else if (distance > 50) {
      return rangeAtack() + grenadeAtack();
    }

    return meleeAtack();
  }
}

class Psyker extends Person with MMelee, MRange, MWarp implements IAtackable {
  Psyker({
    required super.name,
  });

  @override
  get health => 150;

  @override
  int atack(int distance) {
    if (distance >= 150) {
      return rangeAtack();
    }

    return meleeAtack() + warpAtack();
  }

  int warpAtack() {
    print('Enemy range damaged by $warpDamage');
    return warpDamage;
  }
}

void _fight({
  required List<Person> party,
  required int distance,
}) {
  int damage = 0;
  for (final person in party) {
    print(person);
    damage += person.atack(distance);
  }

  print('Total damage: $damage');
}

void main() {
  final ogryn = Ogryn(
    name: 'Krokotug',
    isElectricWeapon: true,
    clan: 'Imperial Guard',
  );
  final veteran = Veteran(
    name: 'Gilza',
  );
  final zealot = Zealot(
    name: 'Zub',
  );
  final psyker = Psyker(
    name: 'Antena',
  );

  final List<Person> party = [
    ogryn,
    veteran,
    zealot,
    psyker,
  ];

  print('READY');
  for (final person in party) {
    print(person);
  }

  print('START BATTLE');
  print('-' * 20);
  print('first creep wave');
  _fight(
    party: party,
    distance: 200,
  );

  print('-' * 20);
  print('second creep wave');
  _fight(
    party: party,
    distance: 100,
  );

  print('-' * 20);
  print('third creep wave');
  _fight(
    party: party,
    distance: 50,
  );

  print('END BATTLE');
}
