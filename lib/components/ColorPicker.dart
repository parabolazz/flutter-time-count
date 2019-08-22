    
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final int color;
  final bool active;
  final onClick;

  ColorPicker({this.color, this.active, this.onClick});

  @override
  Widget build(context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
        child: GestureDetector(
          onTap: () {
            this.onClick(color);
            print(color);
          },
          child: ClipOval(
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: active ? BoxDecoration(
                border: Border.all(width: 1.0, color: const Color(0xFFcac6c6)),
                borderRadius: BorderRadius.circular(30.0),
              ) : null,
              child: ClipOval(
                child: Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: Color(color)
                  ),
                ),
              )
            )
          )
        )
      );
  }
}
    
