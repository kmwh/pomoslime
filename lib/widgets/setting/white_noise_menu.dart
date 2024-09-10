import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pomoslime/provider/white_noise_provider.dart';
import 'package:provider/provider.dart';

class WhiteNoiseMenu extends StatelessWidget {
  const WhiteNoiseMenu({super.key});

  Widget _whiteNoiseOption(
      BuildContext context, int index, String label, String icon) {
    return Consumer<WhiteNoiseProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(12),
            border: provider.whiteNoiseIndex == index
                ? Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 0.9,
                  )
                : null,
          ),
          child: InkWell(
            onTap: () => provider.setWhiteNoise(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/$icon.png",
                  width: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> sounds = [
      ['None', 'mute'],
      ['White Noise', 'sound'],
      ['Rain', 'rain'],
      ['Forest', 'tree'],
      ['Cafe', 'sound'],
      ['Fire', 'fire2'],
      ['Library', 'book_open'],
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 22,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "white_noise".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: sounds.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return _whiteNoiseOption(
                  context, index, sounds[index][0], sounds[index][1]);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
