part of bank_components;

class BottomSheetView extends StatelessWidget {
  final String title;
  final Widget content;
  final ComponentAction rightButton;
  final ComponentAction leftButton;
  final BottomSheetTheme style;
  BottomSheetView({
    this.title,
    this.content,
    this.rightButton,
    this.leftButton,
    @required this.style,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(8.0),
              topRight: const Radius.circular(8.0)),
          color: style.backgroundColor,
        ),
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            _buildHandle(context),
            _buildTitle(context),
            content != null ? content : SizedBox(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  _buildHandle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: style.handleColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return title != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4),
          )
        : SizedBox();
  }

  _buildButtons(BuildContext context) {
    return rightButton != null || leftButton != null
        ? Row(
            children: [
              // right button
              rightButton != null
                  ? Expanded(
                      child: CustomButton(
                        title: rightButton.text,
                        size: ButtonSize.medium,
                        onClick: rightButton.onClick,
                        style: rightButton.style,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: leftButton != null && rightButton != null ? 12 : 0,
              ),
              // left button
              leftButton != null
                  ? Expanded(
                      child: CustomButton(
                        title: leftButton.text,
                        size: ButtonSize.medium,
                        onClick: leftButton.onClick,
                        style: leftButton.style,
                      ),
                    )
                  : SizedBox(),
            ],
          )
        : SizedBox();
  }
}

class BottomSheetTheme {
  final Color backgroundColor;
  final Color handleColor;

  BottomSheetTheme({
    @required this.backgroundColor,
    @required this.handleColor,
  });
}
