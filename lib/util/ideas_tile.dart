import 'package:flutter/material.dart';

class IdeasTile extends StatelessWidget {
  final String itemName;
  Function()? addFunction;

  IdeasTile({
    super.key,
    required this.itemName,
    required this.addFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: addFunction,
              icon: Icon(Icons.add),
            ),

            // Bucket list item name
            Container(
              width: 175,
              child: Text(
                itemName,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
