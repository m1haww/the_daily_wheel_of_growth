import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int volume = 50; // Initial volume (50%)
  final Uri _url = Uri.parse(
      'https://www.termsfeed.com/live/a574e3ad-b14f-4099-8135-5a2d5fa243c9');

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();
    // Ensure the correct state of music when the page loads
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (appProvider.musicToggle) {
      _loadAudio(); // Play music if it's enabled in the provider
    }
  }

  // Load and start the audio if needed
  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset('audio/bg music growth.wav');
      _audioPlayer.setVolume(volume / 100); // Set initial volume
      _audioPlayer.play(); // Start playing the audio
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  // Share the app with others
  Future<void> _shareApp() async {
    try {
      final String appLink =
          'https://your-app-link.com'; // Replace with your actual app link
      final String shareText = 'Check out this amazing app: $appLink';
      await Share.share(shareText);
    } catch (e) {
      print("Error sharing app: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing the app')),
      );
    }
  }

  // Reset all data and stop the music
  void _resetAllData() {
    setState(() {
      _audioPlayer.stop(); // Stop the music
    });
    Provider.of<AppProvider>(context, listen: false).resetAllData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All data has been reset.")),
    );
  }

  @override
  void dispose() {
    _audioPlayer
        .dispose(); // Dispose of the audio player when the page is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: kBlackDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeight(context, 0.03),
              Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: kBlackLight),
                ),
              ),
              buildHeight(context, 0.04),
              buildContainerSettingstoggle(
                context,
                "Music",
                appProvider.musicToggle, // Use musicToggle from Provider
                (value) {
                  appProvider
                      .toggleMusic(value); // Update music toggle in Provider
                  if (value) {
                    _loadAudio(); // Start music
                  } else {
                    _audioPlayer.stop(); // Stop music
                  }
                },
              ),
              buildHeight(context, 0.008),
              buildContainerShareAndReset(
                context,
                "Share the app",
                "images/Layer 51.png",
                _shareApp,
              ),
              buildHeight(context, 0.04),
              buildContainerShareAndReset(
                context,
                "Reset all data",
                "images/Frame.png",
                () {
                  _resetAllData();
                },
              ),
              buildHeight(context, 0.008),
              GestureDetector(
                  onTap: _launchUrl,
                  child: buildContainerSettings1(context, "Terms of use")),
              buildHeight(context, 0.008),
              GestureDetector(
                  onTap: _launchUrl,
                  child: buildContainerSettings1(context, "Privacy Policy")),
            ],
          ),
        ),
      ),
    );
  }

  // Updated buildContainerSettingstoggle method
  Widget buildContainerSettingstoggle(
    BuildContext context,
    String text,
    bool currentState, // Pass current state from provider
    ValueChanged<bool> onChanged, // Callback to update state
  ) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height * 0.06,
      decoration: BoxDecoration(
        color: Color(0xffCC16FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Switch(
              value: currentState,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: kGreenLIght,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Color(0xFF787880A3),
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
    VoidCallback onTap,
  ) {
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height * 0.06,
        decoration: BoxDecoration(
          color: Color(0xffCC16FB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Image(image: AssetImage(image)),
            ],
          ),
        ),
      ),
    );
  }
}
