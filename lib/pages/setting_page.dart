import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // Use a Map to track each switch's state by its name
  Map<String, bool> toggles = {
    "Music": false,
    "Password to enter the app": false,
  };
  final AudioPlayer _audioPlayer = AudioPlayer();
  int volume = 50; // Initial volume (50%)

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset('audio/bg music growth.wav');
      _audioPlayer.setVolume(volume / 100); // Set initial volume
      _audioPlayer.play(); // Play the song automatically
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _shareApp() async {
    try {
      final String appLink =
          'https://your-app-link.com'; // Replace with your actual app link
      final String shareText = 'Check out this amazing app: $appLink';
      await Share.share(shareText);
    } catch (e) {
      print("Error sharing app: $e");
      // Show a feedback to the user (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing the app')),
      );
    }
  }

  void _resetAllData() {
    setState(() {
      toggles.updateAll((key, value) => false); // Reset all switches to false
      volume = 50; // Reset volume to 50%
      _audioPlayer.stop(); // Stop the music
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All data has been reset.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        backgroundColor: kBlackDark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: buildAppbarTitle(context, "Settings"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeight(context, 0.04),
              buildContainerSettings(
                context,
                "Create a password",
              ),
              buildHeight(context, 0.04),
              buildContainerSettingstoggle(
                context,
                "Music",
              ),
              buildHeight(context, 0.005),
              buildContainerSettingstoggle(
                context,
                "Password to enter the app",
              ),
              buildHeight(context, 0.005),
              buildContainerShareAndReset(
                  context, "Share the app", "images/Layer 51.png", _shareApp),
              buildHeight(context, 0.04),
              buildContainerShareAndReset(
                context,
                "Reset all data",
                "images/Frame.png",
                () {
                  Provider.of<AppProvider>(context, listen: false)
                      .resetAllData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("All data has been reset!")),
                  );
                },
              ),
              buildHeight(context, 0.005),
              buildContainerSettings(context, "Terms of use"),
              buildHeight(context, 0.005),
              buildContainerSettings(context, "Privacy Policy")
            ],
          ),
        ),
      ),
    );
  }

  // The function now accepts a callback for onChanged
  // Update the buildContainerSettingstoggle method
  Widget buildContainerSettingstoggle(
    BuildContext context,
    String text,
  ) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height * 0.06,
      decoration: BoxDecoration(
          color: kkPurpleDark, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Switch(
              value: toggles[text]!, // Access the state by the setting name
              onChanged: (value) {
                setState(() {
                  toggles[text] = value; // Update the switch state
                  if (text == "Music") {
                    if (value) {
                      _loadAudio(); // Start music
                    } else {
                      _audioPlayer.stop(); // Stop music
                    }
                  }

                  if (text == "Share the app") {
                    if (value) {
                      // Share the app via different platforms
                      _shareApp();
                    }
                  }
                });
              },
              activeColor: kGreenLIght,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Color(0xff787880A3),
            )
          ],
        ),
      ),
    );
  }

  Widget buildContainerShareAndReset(
    BuildContext context,
    String text,
    String image,
    VoidCallback onTap, // Adăugăm un callback pentru acțiune
  ) {
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap, // Apelează funcția specificată când este apăsat
      child: Container(
        width: double.infinity,
        height: height * 0.06,
        decoration: BoxDecoration(
            color: kkPurpleDark, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Image(image: AssetImage(image))
            ],
          ),
        ),
      ),
    );
  }
}
