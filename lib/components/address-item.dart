part of bank_components;

class AddressItem extends StatelessWidget {
  final String title;
  final String address;
  final String code;
  final IconData icon;
  final IconData editIcon;
  final AddressItemTheme style;
  final Function(BuildContext) onEditClick;

  AddressItem({
    @required this.title,
    @required this.address,
    @required this.code,
    @required this.icon,
    @required this.style,
    @required this.editIcon,
    @required this.onEditClick,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // icon
          CircleAvatar(
            radius: 24,
            backgroundColor: style.iconBackgroundColor,
            child: Icon(
              icon,
              color: style.iconColor,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // title
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.w700)),
                      ),
                    ),

                    // edit button
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CustomIconButton(
                          backgroundColor: Colors.transparent,
                          icon: editIcon,
                          onClick: () {
                            onEditClick(context);
                          }),
                    ),
                  ],
                ),

                // address + code
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(address + ' -  کدپستی: ' + code,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: style.addressColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddressItemTheme {
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color addressColor;
  AddressItemTheme(
      {@required this.addressColor,
      @required this.iconColor,
      @required this.iconBackgroundColor});
}
