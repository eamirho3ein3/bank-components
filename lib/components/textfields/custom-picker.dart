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
  int selectedIndex = 0;
  late FixedExtentScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    selectedIndex = widget.selectedValue == ''
        ? 0
        : widget.itemList.indexOf(widget.selectedValue);

    _scrollController = FixedExtentScrollController(initialItem: selectedIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.itemList.isNotEmpty) {
          _scrollController.dispose();
          _scrollController =
              FixedExtentScrollController(initialItem: selectedIndex);
          await _showPicker(context);
          widget.onComplete(widget.itemList[selectedIndex]);
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

  Future _showPicker(BuildContext context) async {
    selectedIndex = widget.selectedValue == ''
        ? 0
        : widget.itemList.indexOf(widget.selectedValue);
    widget.controller.text = widget.itemList[selectedIndex];
    if (widget.onSelect != null) {
      widget.onSelect!(widget.itemList[selectedIndex]);
    }

    return await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 280,
          color: widget.style.buttonBackgroundColor,
          child: Column(
            children: [
              Container(
                color: widget.style.buttonBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: widget.confirmTitle != null
                            ? widget.confirmTitle
                            : Text(
                                'تایید',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  ],
                ),
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return CupertinoPicker(
                      scrollController: _scrollController,
                      useMagnifier: false,
                      itemExtent: 46,
                      backgroundColor: widget.style.backgroundColor,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex = index;
                        });

                        widget.controller.text = widget.itemList[index];
                        if (widget.onSelect != null) {
                          widget.onSelect!(widget.itemList[index]);
                        }
                      },
                      children: widget.itemList
                          .map((e) => Center(
                                  child: Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color:
                                            e == widget.itemList[selectedIndex]
                                                ? Theme.of(context).primaryColor
                                                : widget.style.textColor),
                              )))
                          .toList(),
                    );
                  },
                ),
              ),
              Container(
                color: widget.style.backgroundColor,
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomPickerStyle {
  final Color backgroundColor;
  final Color cancelColor;
  final Color textColor;
  final Color buttonBackgroundColor;

  CustomPickerStyle({
    required this.backgroundColor,
    required this.cancelColor,
    required this.textColor,
    required this.buttonBackgroundColor,
  });
}
