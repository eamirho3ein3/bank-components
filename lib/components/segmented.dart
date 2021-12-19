part of bank_components;

class CustomSegmented extends StatelessWidget {
  final CustomSegmentedTheme style;
  final int selectedIndex;
  final Function(int) onTabClick;
  final List<String> tabs;
  CustomSegmented(
      {@required this.style,
      @required this.selectedIndex,
      this.onTabClick,
      @required this.tabs});

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    for (var i = 0; i < tabs.length; i++) {
      _children.add(_buildTabItem(context, i));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: style.backgroundColor,
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
            onTabClick(index);
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index == selectedIndex
                  ? style.selectedBackgroundColor
                  : style.backgroundColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8),
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 300),
            child: Text(
              tabs[index],
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSegmentedTheme {
  final Color backgroundColor;
  final Color selectedBackgroundColor;

  CustomSegmentedTheme({this.selectedBackgroundColor, this.backgroundColor});
}
