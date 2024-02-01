import 'package:flutter/material.dart';
import 'package:la_cuisine_dathena/constants.dart';
import 'package:la_cuisine_dathena/models/button_object.dart';
import 'package:la_cuisine_dathena/widgets/branding.dart';

class DrawerSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.center,
              child: Branding(),
            );
          } else {
            ButtonObject button = menuButton[index - 1];
            return ListTile(
              title: Text(button.text),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => button.destination),
                );
              },
            );
          }
        },
        separatorBuilder: (_, index) {
          if (index == 0) {
            return Divider(thickness: 2.0, height: 0, color: Colors.red);
          } else {
            return Divider(height: 0);
          }
        },
        itemCount: menuButton.length + 1,
      ),
    );
  }
}