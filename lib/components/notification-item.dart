part of components;

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String image;
  final String title;
  final String description;
  final String date;
  final ContactItemTheme style;
  NotificationItem({
    this.icon,
    this.image,
    this.description,
    @required this.style,
    @required this.title,
    @required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.backgroundColor,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // image
          image != null
              ? Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    image,
                    height: 176,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              icon != null
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: style.logoBackgroundColor,
                      child: Icon(
                        icon,
                        color: style.logoColor,
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),

                    // description
                    description != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(description,
                                style: Theme.of(context).textTheme.subtitle1),
                          )
                        : SizedBox(),

                    // date
                    Text(date,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: style.subtitleColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
