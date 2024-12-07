part of bank_components;

class CustomPicker extends StatefulWidget {
  /// This use only for one column [itemList].
  ///

  final Function(String) onComplete;
  final Function(String)? onSelect;
  final String placeholder;
  final List<String> itemList;
  final String selectedValue;
  final Widget? confirmTitle;
  final Widget? cancelTitle;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final CustomPickerStyle style;
  CustomPicker({
    required this.onComplete,
    required this.placeholder,
    required this.itemList,
    this.confirmTitle,
    this.cancelTitle,
    this.validator,
    required this.selectedValue,
    this.onSelect,
    required this.controller,
    required this.style,
  });

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.itemList.isNotEmpty) {
          var result = await _showPicker(context);
          widget.onComplete(result);
        }
      },
      child: AbsorbPointer(
        child: MainTextField(
          enabled: widget.itemList.isEmpty ? false : true,
          controller: widget.controller,
          type: TextfieldType.Reqular,
          label: widget.placeholder,
          keyboardType: TextInputType.text,
          validator: widget.validator,
        ),
      ),
    );
  }

  Future<String> _showPicker(BuildContext context) async {
    List<int> selected = widget.selectedValue == ''
        ? [0]
        : [widget.itemList.indexOf(widget.selectedValue)];
    widget.controller.text = widget.itemList[selected.first];
    if (widget.onSelect != null) {
      widget.onSelect!(widget.itemList[selected.first]);
    }
    return await Picker(
      adapter: PickerDataAdapter<String>(pickerData: widget.itemList),
      changeToFirst: false,
      looping: false,
      height: 200,
      itemExtent: 36,
      confirm: InkWell(
        onTap: () {
          Navigator.of(context).pop(widget.controller.text);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: widget.confirmTitle != null
              ? widget.confirmTitle
              : Text(
                  'تایید',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
        ),
      ),
      cancel: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: widget.cancelTitle != null
              ? widget.cancelTitle
              : Text(
                  'لغو',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: widget.style.cancelColor),
                ),
        ),
      ),
      selecteds: selected,
      backgroundColor: widget.style.backgroundColor,
      textStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: widget.style.textColor),
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: (picker, value) {
        widget.controller.text = widget.itemList[value.first];
        // widget.onComplete(widget.itemList[value.first]);
      },
      onCancel: () {},
      onSelect: (Picker picker, int selected, List value) {
        widget.controller.text = widget.itemList[value.first];
        if (widget.onSelect != null) {
          widget.onSelect!(widget.itemList[value.first]);
        }
      },
    ).showModal(context);
  }
}

class CustomPickerStyle {
  final Color backgroundColor;
  final Color cancelColor;
  final Color textColor;

  CustomPickerStyle(
      {required this.backgroundColor,
      required this.cancelColor,
      required this.textColor});
}
