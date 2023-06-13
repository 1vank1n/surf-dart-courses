class Person {
  String firstName;
  String lastName;
  DateTime? birthday;

  Person({
    required this.firstName,
    required this.lastName,
  });

  @override
  String toString() {
    return '$lastName $firstName';
  }
}

class Player extends Person {
  Team team;
  Role role;
  String nickname;
  int matchesPlayed = 0;
  int matchesWon = 0;
  int get matchesLost => matchesPlayed - matchesWon;

  Player({
    required String firstName,
    required String lastName,
    required this.nickname,
    required this.team,
    required this.role,
  }) : super(
          firstName: firstName,
          lastName: lastName,
        );

  @override
  String toString() {
    return '$firstName $nickname $lastName » [$team] on ${role.name}';
  }
}

class Coach extends Person {
  Team team;
  List<Trophey> tropheis = [];

  Coach({
    required String firstName,
    required String lastName,
    required this.team,
  }) : super(
          firstName: firstName,
          lastName: lastName,
        );

  @override
  String toString() {
    return '${super.toString()} » [$team]';
  }
}

class Team {
  String title;
  Country country;
  int capacity = 5;
  Coach? coach;
  final Set<Player> _players = {};
  Set<Player> get players => _players;
  List<Trophey> tropheis = [];

  Team({
    required this.title,
    required this.country,
  });

  @override
  String toString() {
    return '$title / $country';
  }

  bool addPlayer(Player player) {
    return _players.length < capacity ? _players.add(player) : false;
  }

  String showFullInfo() {
    String info = '$this';
    info += '\n\n';
    info += 'Players:\n';
    info += _players.map((player) => '$player').join('\n');
    if (coach != null) {
      info += '\n$coach on coach';
    }
    info += '\n\n';
    info += 'Tropheis:\n';
    info += tropheis.map((trophey) => '$trophey').join('\n');
    return info;
  }
}

enum Role {
  carry,
  offlane,
  midlane,
  semisupport,
  support,
}

class Country {
  String title;

  Country({
    required this.title,
  });

  @override
  String toString() {
    return title;
  }
}

class Trophey {
  String title;
  DateTime date;

  Trophey({
    required this.title,
    required this.date,
  });

  @override
  String toString() {
    return '$title / ${date.year}';
  }
}

void main() {
  // Source of data — https://en.wikipedia.org/wiki/Team_Spirit_(esports)

  final russia = Country(
    title: 'Russia',
  );

  final teamSpirit = Team(
    title: 'Team Spirit [Dota2]',
    country: russia,
  );

  final bulkOfPlayers = <Player>[
    Player(
      firstName: 'Ilya',
      lastName: 'Mulyarchuk',
      nickname: 'Yatoro',
      team: teamSpirit,
      role: Role.carry,
    ),
    Player(
      firstName: 'Denis',
      lastName: 'Sigitov',
      nickname: 'Lari',
      team: teamSpirit,
      role: Role.midlane,
    ),
    Player(
      firstName: 'Magomed',
      lastName: 'Khalilov',
      nickname: 'Collapse',
      team: teamSpirit,
      role: Role.offlane,
    ),
    Player(
      firstName: 'Miroslaw',
      lastName: 'Kolpakov',
      nickname: 'Mira',
      team: teamSpirit,
      role: Role.semisupport,
    ),
    Player(
      firstName: 'Yaroslav',
      lastName: 'Naidenov',
      nickname: 'Miposhka',
      team: teamSpirit,
      role: Role.support,
    ),
  ];

  for (var player in bulkOfPlayers) {
    teamSpirit.addPlayer(player);
  }

  final coach = Coach(
    firstName: 'Airat',
    lastName: 'Gaziyev',
    team: teamSpirit,
  );

  teamSpirit.coach = coach;

  final bulkOfTropheis = <Trophey>[
    Trophey(
      title: 'BTS Pro Series Season 4: Europe/CIS',
      date: DateTime(2020, 12, 20),
    ),
    Trophey(
      title: 'Dota 2 Champions League 2021 Season 1 Grand Final',
      date: DateTime(2021, 4, 13),
    ),
    Trophey(
      title: 'The International 2021',
      date: DateTime(2021, 10, 17),
    ),
  ];

  for (var trophey in bulkOfTropheis) {
    teamSpirit.tropheis.add(trophey);
  }

  print(teamSpirit.showFullInfo());
}
