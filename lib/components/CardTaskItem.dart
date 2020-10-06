import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/theme.dart';

import '../styles.dart';

class CardTaskItem extends StatelessWidget {
  final String text;
  final bool done;
  CardTaskItem({this.text,this.done = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        this.text,
        style: Theme.of(context).textTheme.bodyText1.apply(
          decoration: (this.done) ?TextDecoration.lineThrough:TextDecoration.none,
          color: (this.done)? ThemeColors.doneTaskColor:Colors.white,
        )
      ),
    );
  }
}
