part of bank_components;

class CustomPicker extends StatefulWidget {
  /// This use only for one column [itemList].
  ///

  final Function(String) onComplete;
  final String placeholder;
  final List<String> itemList;
  final String selectedValue;
  final Widget confirmTitle;
  final Widget cancelTitle;
  final Function(String) validator;
  CustomPicker({
    @required this.onComplete,
    @required this.placeholder,
    @required this.itemList,
    this.confirmTitle,
    this.cancelTitle,
    this.validator,
    @required this.selectedValue,
  });

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: AbsorbPointer(
        child: MainTextField(
          controller: dateController,
          type: TextfieldType.Reqular,
          label: widget.placeholder,
          keyboardType: TextInputType.text,
          validator: widget.validator,
        ),
      ),
    );
  }

  _showPicker(BuildContext context) {
    List<int> selected = widget.selectedValue == ''
        ? [0]
        : [widget.itemList.indexOf(widget.selectedValue)];
    dateController.text = widget.itemList[selected.first];
    Picker(
      adapter: PickerDataAdapter<String>(pickerdata: widget.itemList),
      changeToFirst: false,
      looping: false,
      height: 200,
      itemExtent: 36,
      confirm: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: widget.confirmTitle != null
              ? widget.confirmTitle
              : Text(
                  'تایید',
                  style: Theme.of(context)
                      .textTheme
                      .button
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
                      .button
                      .copyWith(color: Colors.red),
                ),
        ),
      ),
      selecteds: selected,
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: (picker, value) {},
      onCancel: () {},
      onSelect: (Picker picker, int selected, List value) {
        dateController.text = widget.itemList[value.first];
        widget.onComplete(widget.itemList[value.first]);
      },
    ).showModal(context);
  }
}
