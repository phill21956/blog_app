import 'package:flutter/material.dart';

class AppbarTitleWidget extends StatelessWidget {
  const AppbarTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Flutter",
          style: TextStyle(fontSize: 22),
        ),
        Text(
          "Blog",
          style: TextStyle(fontSize: 22, color: Colors.blue),
        )
      ],
    );
  }
}

