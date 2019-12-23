import 'package:carambar/work/ui/entity/display_job.dart';
import 'package:flutter/material.dart';

class JobListItem extends StatelessWidget {
  final DisplayJob job;
  final Function() onTap;
  final bool isCurrentJob;
  final Key titleKey;

  const JobListItem(
      {Key key, this.job, this.onTap, this.isCurrentJob, this.titleKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splashColor = Theme.of(context).splashColor;
    var highlightColor = Theme.of(context).highlightColor;
    var jobTitle = <Widget>[
      Text(
        job.name,
        key: titleKey,
      ),
    ];

    if (isCurrentJob) {
      jobTitle.add(Text(
        '(Current)',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ));
      splashColor = Colors.transparent;
      highlightColor = Colors.transparent;
    }

    return InkWell(
      splashColor: splashColor,
      highlightColor: highlightColor,
      onTap: _onJobListItemTap,
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: jobTitle,
            ),
            Text(
              job.salary,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  void _onJobListItemTap() {
    if (!this.isCurrentJob) {
      this.onTap();
    }
  }
}
