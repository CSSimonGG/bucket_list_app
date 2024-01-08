import 'package:flutter/material.dart';

class BucketListTaskTile extends StatelessWidget {
  final String itemName;
  Function()? checkFunction;
  Function(BuildContext)? editFunction;
  Function(BuildContext)? deleteFunction;

  BucketListTaskTile({
    super.key,
    required this.itemName,
    required this.checkFunction,
    required this.editFunction,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.green[300], borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            IconButton(
              onPressed: checkFunction,
              icon: Icon(Icons.check),
            ),

            // Bucket list item name
            Container(
              width: 175,
              child: Text(
                itemName,
                overflow: TextOverflow.fade,
              ),
            ),

            Spacer(),

            // Edit button
            IconButton(
              onPressed: () {
                if (editFunction != null) {
                  editFunction!(context);
                }
              },
              icon: Icon(Icons.edit),
            ),

            // Delete button
            IconButton(
              onPressed: () {
                if (deleteFunction != null) {
                  deleteFunction!(context);
                }
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
