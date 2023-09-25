import 'package:flutter/material.dart';
import 'package:task_flutter/core/constant/imageasset.dart';

class CustomHeaderCreate extends StatelessWidget {
  const CustomHeaderCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(AppImageAsset.avatar),
      title: const Text("Test Account"),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey),
                onPressed: () {},
                icon: const Icon(Icons.group),
                label: Row(
                  children: const [
                    Text('Friends'),
                    Expanded(
                      child: Icon(
                        Icons.arrow_drop_down,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: Row(
                  children: const [
                    Text('Album'),
                    Expanded(
                      child: Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





