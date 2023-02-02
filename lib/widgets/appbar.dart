import 'package:flutter/material.dart';

AppBar homeAppBar = AppBar(
  backgroundColor: const Color(0xff0d7a9a),
  title: const Text('Visual Assistant'),
  leading: const FittedBox(
    child: Image(
      image: AssetImage('assets/images/white_logo.png'),
    ),
  ),
);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
      Key? key,
      this.title = "Visual Assistant",
      this.onBackPressed
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff0d7a9a),
      title: Text(title),
      leading: (onBackPressed != null)
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
