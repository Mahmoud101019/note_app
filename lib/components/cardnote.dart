import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String content;
  const CardNote({
    super.key,
    required this.onTap,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/logo.png",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(title),
                subtitle: Text(content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
