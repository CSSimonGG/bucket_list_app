import 'package:flutter/material.dart';

class CompletedTile extends StatelessWidget {
  final String taskName;
  Function(BuildContext)? deleteFunction;

  CompletedTile({
    super.key,
    required this.taskName,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            // task name
            Text(taskName),

            Spacer(),

            // Delete icon
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
