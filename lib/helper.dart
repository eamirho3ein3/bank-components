part of bank_components;

// return list of string that contain card nmuber in 4 pices
List<String> getCorrectCardNumber(String number) {
  List<String> numbers = [];

  for (var i = 0; i < number.characters.length; i = i + 4) {
    var str = number.substring(i, i + 3);
    numbers.add(str);
  }

  return numbers;
}

String replaceToEnglishNumber(String input) {
  if (input != null && input.isNotEmpty) {
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      ',',
      '.'
    ];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '،', '٫'];

    for (int i = 0; i < farsi.length; i++) {
      input = input.replaceAll(farsi[i], english[i]);
    }
  }

  return input;
}

String replaceToFarsiNumber(String input) {
  if (input != null && input.isNotEmpty) {
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      ',',
      '.'
    ];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '،', '٫'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }
  }

  return input;
}

String addCommasToPrice(String input) {
  if (input != null && input.isNotEmpty) {
    try {
      input = input.seRagham();
    } catch (e) {
      print("e = $e");
    }
  }

  return input;
}
