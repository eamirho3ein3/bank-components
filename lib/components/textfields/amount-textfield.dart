part of bank_components;

class AmountTextField extends StatefulWidget {
  final TextStyle textFieldStyle;
  final Function(String)? onTextFieldChanged;
  final String? Function(String?)? validator;
  final String Function(String) showValueBaseOnOppositeCurrency;
  final GlobalKey<FormState>? formKey;
  final TextfieldExtend? suffix;
  final TextfieldExtend? prefix;

  AmountTextField({
    required this.showValueBaseOnOppositeCurrency,
    required this.textFieldStyle,
    this.onTextFieldChanged,
    this.validator,
    this.formKey,
    this.suffix,
    this.prefix,
  });

  @override
  _AmountTextFieldState createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  late TextEditingController controller;
  String? wordPrice = '';

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      controller: controller,
      inputFormatters: [PriceTextFormatterV2()],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      type: TextfieldType.Reqular,
      onChanged: (value) {
        var result = (replaceToEnglishNumber(value) ?? '')
            .replaceAll(RegExp('[^0-9]'), '');

        if (widget.formKey != null) {
          if (!widget.formKey!.currentState!.validate()) {
            wordPrice = null;
          } else {
            wordPrice = widget.showValueBaseOnOppositeCurrency(result);
          }
        } else {
          wordPrice = widget.showValueBaseOnOppositeCurrency(result);
        }

        setState(() {});

        if (widget.onTextFieldChanged != null) {
          widget.onTextFieldChanged!(result);
        }
      },
      validator: widget.validator,
      helper: wordPrice == null || wordPrice!.isEmpty
          ? SizedBox()
          : Text(
              wordPrice!,
              style: Theme.of(context).textTheme.caption,
            ),
      textDirection: TextDirection.ltr,
      textFieldStyle: widget.textFieldStyle,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      prefix: widget.prefix,
      suffix: widget.suffix,
    );
  }
}

class PriceTextFormatterV2 extends TextInputFormatter {
  PriceTextFormatterV2();
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      var newString = (replaceToEnglishNumber(newValue.text) ?? '')
          .replaceAll(RegExp('[^0-9]'), '');
      if (newString.trim().isEmpty) {
        return newValue;
      } else {
        final f = intel.NumberFormat("#,###");
        var num = int.parse(replaceToEnglishNumber(newValue.text)!
            .replaceAll(RegExp('[^0-9]'), ''));
        final newString = f.format(num).trim();

        return TextEditingValue(
          text: replaceToFarsiNumber(newString)!,
          selection: TextSelection.fromPosition(
              TextPosition(offset: newString.length)),
        );
      }
    } else {
      return newValue;
    }
  }
}

class PriceTextFormatter extends TextInputFormatter {
  final String currency;
  PriceTextFormatter({required this.currency});
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final currencySymbol = currency.trim();
    if (newValue.text.isEmpty ||
        newValue.text.trim() == currencySymbol.trim()) {
      return newValue.copyWith(text: '$currencySymbol');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      var newString = (replaceToEnglishNumber(newValue.text) ?? '')
          .replaceAll(RegExp('[^0-9]'), '');
      if (newString.trim().isEmpty) {
        return TextEditingValue(
          text: currencySymbol + '\u2066' + ' ',
          selection: TextSelection.fromPosition(
              TextPosition(offset: currencySymbol.length)),
        );
      } else {
        final f = intel.NumberFormat("#,###");
        var num = int.parse(replaceToEnglishNumber(newValue.text)!
            .replaceAll(RegExp('[^0-9]'), ''));
        final newString =
            '$currencySymbol' + '\u2066' + ' ' + f.format(num).trim();

        return TextEditingValue(
          text: replaceToFarsiNumber(newString)!,
          selection: TextSelection.fromPosition(
              TextPosition(offset: newString.length)),
        );
      }
    } else {
      return newValue;
    }
  }
}
