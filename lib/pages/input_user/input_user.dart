import 'package:flutter/material.dart';

import '../../maquette/footer.dart';
import './header.dart';
import 'input_user_body.dart';

class InputUser extends StatefulWidget {
  var color;
  InputUser({Key key, this.color}) : super(key: key);

  @override
  State<InputUser> createState() => _InputUserState();
}

class _InputUserState extends State<InputUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Header(
                      title: "My profile",
                      home: true,
                    ),
                    Expanded(
                        child: InputUserBody(
                      color: widget.color,
                    )),
                    Fotter(),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
