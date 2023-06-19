class Day {
  final String title;
  final bool isWorkday;

  Day({
    required this.title,
    required this.isWorkday,
  });

  @override
  String toString() {
    return title;
  }
}

void main() {
  final days = <Day>[
    Day(title: 'Понедельник', isWorkday: true),
    Day(title: 'Вторник', isWorkday: true),
    Day(title: 'Среда', isWorkday: true),
    Day(title: 'Четверг', isWorkday: true),
    Day(title: 'Пятница', isWorkday: true),
    Day(title: 'Суббота', isWorkday: false),
    Day(title: 'Воскресенье', isWorkday: false),
  ];

  do {
    final day = days[0];
    print('-' * 20);
    print('* $day');

    if (day.isWorkday) {
      checkIncoming();
      runDailyStartup();
      clientCall();
      runWork();
      reviewCode();
      finishWorkDay();
    } else {
      familyTime(day);
    }

    days.removeAt(0);
    print('');
  } while (days.isNotEmpty);
}

void checkIncoming() {
  print('Проверить входящие сообщения / письма');
}

void runDailyStartup() {
  print('Провести утренние стендапы');
}

void clientCall() {
  print('Созвоны с клиентами');
}

void runWork() {
  print('Кодинг');
}

void reviewCode() {
  print('Код ревью');
}

void finishWorkDay() {
  print('Постановка задач команде');
}

void familyTime(Day day) {
  print('Время с семьёй');

  switch (day.title) {
    case 'Суббота':
      print('Баня');
    case 'Воскресенье':
      print('Прогулка к морю');
  }
}
