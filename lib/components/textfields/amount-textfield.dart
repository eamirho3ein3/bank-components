part of bank_components;

class AmountTextField extends StatefulWidget {
  final TextStyle textFieldStyle;
  final TextStyle textUnitStyle;
  final Function(String) onTextFieldChanged;

  AmountTextField(
      {@required this.textFieldStyle,
      @required this.textUnitStyle,
      this.onTextFieldChanged});

  @override
  _AmountTextFieldState createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  TextEditingController controller;
  @override
  void initState() {
    controller = RichTextController(
      patternMatchMap: {
        RegExp(r"\Bریال"): widget.textUnitStyle,
      },
      onMatch: (List<String> match) {
        print("calll");
      },
      deleteOnBack: true,
      text: 'ریال',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      controller: controller,
      inputFormatters: [PriceTextFormatter()],
      textAlign: TextAlign.center,
      type: TextfieldType.Reqular,
      onChanged: (value) {
        var result =
            replaceToEnglishNumber(value).replaceAll(RegExp('[^0-9]'), '');
        widget.onTextFieldChanged(result);
      },
      textDirection: TextDirection.ltr,
      textFieldStyle: widget.textFieldStyle,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class PriceTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final currencySymbol = 'ریال' + '\u2067';
    if (newValue.text.isEmpty || newValue.text.trim() == currencySymbol) {
      return newValue.copyWith(text: '$currencySymbol');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final f = intel.NumberFormat("#,###");

      var num = int.parse(replaceToEnglishNumber(newValue.text)
          .replaceAll(RegExp('[^0-9]'), ''));
      final newString = '$currencySymbol' + '\u2066' + f.format(num).trim();

      return TextEditingValue(
        text: replaceToFarsiNumber(newString),
        selection:
            TextSelection.fromPosition(TextPosition(offset: newString.length)),
      );
    } else {
      return newValue;
    }
  }
}
