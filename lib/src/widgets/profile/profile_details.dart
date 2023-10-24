import 'package:flutter/material.dart';

import 'display_number_button.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PhysicalModel(
                elevation: 8,
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(64),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 64,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://picsum.photos/200?blur=1",
                    ),
                    radius: 60,
                  ),
                ),
              ),
              Text(
                "Aman R",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.grey.shade50),
              ),
              Text(
                "I am a Locus User",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade50,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const DisplayNumberButton(
                    0,
                    "Moments",
                    onTap: null,
                  ),
                  DisplayNumberButton(
                    225,
                    "Followers",
                    onTap: () {},
                  ),
                  DisplayNumberButton(
                    250,
                    "Following",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
