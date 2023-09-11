part of bank_components;

class CustomSegmented extends StatefulWidget {
  final CustomSegmentedTheme style;
  final int? initIndex;
  final Function(int)? onTabClick;
  final List<String> tabs;
  CustomSegmented(
      {required this.style,
      this.initIndex,
      this.onTabClick,
      required this.tabs});

  @override
  _CustomSegmentedState createState() => _CustomSegmentedState();
}

class _CustomSegmentedState extends State<CustomSegmented> {
  var _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initIndex ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    for (var i = 0; i < widget.tabs.length; i++) {
      _children.add(_buildTabItem(context, i));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.style.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: _children,
      ),
    );
  }

  _buildTabItem(BuildContext context, int index) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            if (widget.onTabClick != null) {
              widget.onTabClick!(index);
            }
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index == _selectedIndex
                  ? widget.style.selectedBackgroundColor
                  : widget.style.backgroundColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 300),
            child: Text(
              widget.tabs[index],
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSegmentedTheme {
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;

  CustomSegmentedTheme({this.selectedBackgroundColor, this.backgroundColor});
}
