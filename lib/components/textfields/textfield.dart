part of bank_components;

class MainTextField extends StatefulWidget {
  final TextfieldType type;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final String? label;
  final String? placeholder;
  final Widget? helper;
  final int? limit;
  final TextfieldExtend? prefix;
  final TextfieldExtend? suffix;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textFieldStyle;
  final TextDirection? textDirection;
  final EdgeInsetsGeometry? contentPadding;
  final bool? showCursor;
  final bool readOnly;
  final bool? enabled;
  final bool showCounter;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;

  MainTextField({
    required this.controller,
    this.textAlign,
    this.label,
    this.helper,
    this.limit,
    this.prefix,
    this.suffix,
    this.validator,
    required this.type,
    this.keyboardType,
    this.onChanged,
    this.inputFormatters,
    this.focusNode,
    this.placeholder,
    this.textFieldStyle,
    this.textDirection,
    this.contentPadding,
    this.showCursor,
    this.showCounter = true,
    this.readOnly = false,
    this.enabled,
    this.onFieldSubmitted,
    this.onTap,
    this.minLines,
    this.maxLines,
    this.textInputAction,
  });

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign ?? TextAlign.start,
          maxLength: widget.limit,
          minLines: widget.minLines ??
              (widget.keyboardType == TextInputType.multiline ? 4 : 1),
          maxLines: widget.maxLines ??
              (widget.keyboardType == TextInputType.multiline ? 4 : 1),
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            return widget.limit != null && widget.showCounter
                ? Container(
                    child: Text(
                      replaceToFarsiNumber(
                              '$maxLength/${widget.controller.text.length}') ??
                          '',
                      style:
                          Theme.of(context).inputDecorationTheme.counterStyle,
                    ),
                  )
                : null;
          },
          inputFormatters: widget.inputFormatters,
          showCursor: widget.showCursor,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          decoration: InputDecoration(
            alignLabelWithHint:
                widget.keyboardType == TextInputType.multiline ? true : false,
            hintText: widget.placeholder,
            labelText: widget.label,
            prefixIcon: _buildExtendWidget(widget.prefix, context, false),
            suffixIcon: widget.type == TextfieldType.Password
                ? _buildEyeIconSuffix()
                : _buildExtendWidget(widget.suffix, context, true),
            contentPadding: widget.contentPadding ?? EdgeInsets.all(12),
          ),
          obscureText: widget.type == TextfieldType.Password ||
                  widget.type == TextfieldType.SecurePassword
              ? hidePassword
              : false,
          onTap: widget.onTap,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style:
              widget.textFieldStyle ?? Theme.of(context).textTheme.titleMedium,
          textDirection: widget.textDirection,
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
        widget.helper != null
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: widget.helper,
              )
            : SizedBox(),
      ],
    );
  }

  _buildEyeIconSuffix() {
    return InkWell(
      onTap: () {
        setState(() {
          hidePassword = !hidePassword;
        });
      },
      child: Icon(hidePassword
          ? Icons.visibility_off_outlined
          : Icons.visibility_outlined),
    );
  }

  _buildExtendWidget(
      TextfieldExtend? widget, BuildContext context, bool isSuffix) {
    if (widget == null) {
      return null;
    } else if (widget.type == TextfieldExtendType.Icon) {
      // icon

      return InkWell(
        onTap: widget.onTap,
        child: Icon(
          widget.icon?.icon,
          color: widget.icon?.iconColor,
        ),
      );
    } else if (widget.type == TextfieldExtendType.Text) {
      // text

      return Container(
        margin: EdgeInsets.only(
            left: isSuffix ? 4 : 8,
            right: !isSuffix ? 4 : 8,
            top: 4,
            bottom: 4),
        width: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: widget.textBackgroundColor,
        ),
        child: Text(
          widget.text ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    } else {
      // child
      return widget.child;
    }
  }
}

class TextfieldHelper extends StatelessWidget {
  final HeplerType type;
  final String text;
  final HelperWidgetTheme theme;

  TextfieldHelper(
      {required this.type, required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    if (type == HeplerType.Regular) {
      // regular
      return Text(
        text,
        style: Theme.of(context).inputDecorationTheme.helperStyle,
      );
    } else {
      // success or error
      return Row(
        children: [
          // TODO: change icon data with real one
          Icon(
            type == HeplerType.Success ? Icons.info : Icons.info,
            color: type == HeplerType.Success ? theme.success : theme.error,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              text,
              style: Theme.of(context)
                  .inputDecorationTheme
                  .helperStyle!
                  .copyWith(
                      color: type == HeplerType.Success
                          ? theme.success
                          : theme.error),
            ),
          ),
        ],
      );
    }
  }
}

class HelperWidgetTheme {
  // on regular type you don't need to pass this
  final Color success;
  final Color error;

  HelperWidgetTheme({required this.success, required this.error});
}

class TextfieldExtend {
  final TextfieldExtendType type;
  final CustomIconTheme? icon;
  final String? text;
  final Widget? child;
  final Function()? onTap;
  final Color? textBackgroundColor;

  TextfieldExtend({
    required this.type,
    this.icon,
    this.text,
    this.child,
    this.onTap,
    this.textBackgroundColor,
  });
}

enum HeplerType { Regular, Error, Success }

enum TextfieldExtendType { Icon, Text, Child }

enum TextfieldType {
  Reqular,
  Password,
  SecurePassword, // type of textfield for online shopping password that user can not see the password
}

class CodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var numberIndex = oldValue.text.lastIndexOf(RegExp(r'@"^\d$"'));

    if (newValue.text.length > oldValue.text.length) {
      return TextEditingValue(
        text: newValue.text.replaceFirst(RegExp(r'- |-'), ''),
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    } else {
      return TextEditingValue(
        text: newValue.text + '- ',
        selection: TextSelection.collapsed(offset: numberIndex + 2),
      );
    }
  }
}
