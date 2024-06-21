import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: const Color(0xFF17192D),
      centerTitle: true,
      title: Image.asset(
        'assets/images/tractian_logo.png',
        width: 0.3 * sw,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
