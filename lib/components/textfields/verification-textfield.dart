part of bank_components;

class VerificationTextField extends StatefulWidget {
  final Function(String) onComplete;
  final Function(String) onChanged;
  final Function(TextEditingController) onClipboardChange;
  final TextStyle? textFieldStyle;

  final int otpLength;
  VerificationTextField({
    required this.onComplete,
    required this.onChanged,
    this.otpLength = 6,
    required this.onClipboardChange,
    this.textFieldStyle,
  });

  @override
  _VerificationTextFieldState createState() => _VerificationTextFieldState();
}

class _VerificationTextFieldState extends State<VerificationTextField>
    with WidgetsBindingObserver {
  late TextEditingController _controller;
  FocusNode _focusNode = FocusNode();
  String _input = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = VerificationTextEditingController(limit: widget.otpLength);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      widget.onClipboardChange(_controller);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MainTextField(
        showCursor: false,
        textAlign: TextAlign.center,
        type: TextfieldType.Reqular,
        controller: _controller,
        focusNode: _focusNode,
        limit: widget.otpLength,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        textFieldStyle: widget.textFieldStyle,
        keyboardType: TextInputType.number,
        contentPadding: EdgeInsets.symmetric(vertical: 30),
        showCounter: false,
        onChanged: (String value) {
          _input = value;
          if (widget.onChanged != null) {
            widget.onChanged(_input);
          }

          if (_input.length == widget.otpLength) {
            _focusNode.unfocus();
            if (widget.onComplete != null) {
              widget.onComplete(_input);
            }
          }
          setState(() {});
        },
      ),
    );
  }
}

class VerificationTextEditingController extends TextEditingController {
  final int limit;
  VerificationTextEditingController({required this.limit});
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    TextSpan original = super.buildTextSpan(
        context: context, style: style, withComposing: withComposing);
    String text = replaceToEnglishNumber(original.toPlainText())!;
    const dashCode = 45;
    List<int> codes = List.filled(6, dashCode);
    String result = String.fromCharCodes(codes);
    // If the text is empty, show "------", otherwise show the text with "-" appended until it reaches 6 characters
    String newText = text.isEmpty ? result : text.padRight(limit, '-');
    // Add spaces between each character to looks better
    newText = newText.split('').join('  ');
    TextSpan newSpan =
        TextSpan(text: replaceToFarsiNumber(newText), style: original.style);
    return newSpan;
  }
}
