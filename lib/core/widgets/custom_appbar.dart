import 'package:flutter/material.dart';

AppBar customAppBar (BuildContext context , String text, bool isPopped){
    return AppBar(
      leading: isPopped ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ) : const SizedBox(),
      centerTitle: true,
      title: Text(text),
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    );
}