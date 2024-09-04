import 'package:flutter/material.dart';

class AlarmMenu extends StatelessWidget {
  const AlarmMenu({super.key});

  Widget _buildSoundOption(BuildContext context, String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "Notification Sound",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              _buildSoundOption(context, "None", Icons.volume_off),
              _buildSoundOption(context, "Forest", Icons.park),
              _buildSoundOption(context, "Tide", Icons.waves),
              _buildSoundOption(context, "Cafe", Icons.local_cafe),
              _buildSoundOption(context, "Storm", Icons.cloud),
              _buildSoundOption(context, "Clock", Icons.access_time),
              _buildSoundOption(
                  context, "Bonfire", Icons.local_fire_department),
              _buildSoundOption(context, "Books", Icons.menu_book),
              _buildSoundOption(context, "Temple", Icons.temple_buddhist),
              _buildSoundOption(context, "Stream", Icons.water),
              _buildSoundOption(context, "Grass", Icons.grass),
              _buildSoundOption(context, "Library", Icons.library_books),
            ],
          ),
        ],
      ),
    );
  }
}
