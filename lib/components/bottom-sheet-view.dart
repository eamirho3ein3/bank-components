part of bank_components;

typedef ScrollableContentWidgetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

class BottomSheetView extends StatelessWidget {
  final String? title;
  final Widget? content;

  /// content that contains scrollview and padding
  final Widget? contentWithSelfScroll;
  final ComponentAction? rightButton;
  final ComponentAction? leftButton;
  final BottomSheetTheme style;
  final ScrollableContentWidgetBuilder? builder;
  BottomSheetView({
    this.title,
    this.content,
    this.contentWithSelfScroll,
    this.rightButton,
    this.leftButton,
    required this.style,
    this.builder,
  });
  @override
  Widget build(BuildContext context) {
    return builder != null
        ? ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - kToolbarHeight),
            child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return _buidDragableView(context, scrollController);
                }),
          )
        : _checkSelfScroll(context);
  }

  _checkSelfScroll(BuildContext context) {
    return contentWithSelfScroll != null
        ? _buildView(context)
        : SingleChildScrollView(
            child: _buildView(context),
          );
  }

  _buildView(BuildContext context) {
    var bottomPadding = rightButton != null || leftButton != null
        ? 16 + MediaQuery.of(context).viewInsets.bottom
        : MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0)),
        color: style.backgroundColor,
      ),
      padding: EdgeInsets.only(
          left: contentWithSelfScroll != null ? 0 : 16,
          right: contentWithSelfScroll != null ? 0 : 16,
          bottom: bottomPadding),
      child: CustomSafeArea(
        child: Column(
          children: [
            _buildHandle(context),
            _buildTitle(context),
            contentWithSelfScroll != null
                ? Expanded(child: contentWithSelfScroll!)
                : SizedBox(),
            content ?? SizedBox(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  _buidDragableView(BuildContext context, ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0)),
        color: style.backgroundColor,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CustomSafeArea(
          child: Column(
            children: [
              _buildHandle(context),
              _buildTitle(context),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      builder!(context, scrollController),
                    ],
                  ),
                ),
              ),
              _buildButtons(context),
            ],
          ),
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
            child: Text(title!,
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
                        title: rightButton!.text,
                        size: ButtonSize.medium,
                        onClick: rightButton!.onClick,
                        style: rightButton!.style,
                        isLoading: rightButton!.isLoading,
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
                        title: leftButton!.text,
                        size: ButtonSize.medium,
                        onClick: leftButton!.onClick,
                        style: leftButton!.style,
                        isLoading: leftButton!.isLoading,
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
    required this.backgroundColor,
    required this.handleColor,
  });
}
