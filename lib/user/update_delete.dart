import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDeleteUser extends StatelessWidget {
  const UpdateDeleteUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update & Delete test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc('r6gxNGKD2xiaVrxLem80');

                //  update specific field
                //  unlike set which sets all fields and assigns new values from start
                //  update only updates specific fields
                docUser.update({
                  'name': 'Update name',
                  // 'city.name': 'KTM',
                  // 'city': FieldValue.delete(),
                });
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc('r6gxNGKD2xiaVrxLem80');

                docUser.delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
