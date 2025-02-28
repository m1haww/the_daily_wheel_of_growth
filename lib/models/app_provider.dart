import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/quiz.list.dart';
import 'package:the_daily_wheel_of_growth/models/quiz_manager.dart';

class AppProvider extends ChangeNotifier {
  var directorypath = "";
  final List<Home> _home = [];
  List<Home> get home => _home;
  final List<Decisions> _decisions = [];
  List<Decisions> get decisions => _decisions;
  final QuizManager _quizManager = QuizManager();

  // New state for music toggle (no persistence)
  bool musicToggle = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int volume = 50;
  // Method to change the music toggle state
  void toggleMusic(bool value) {
    musicToggle = value;
    if (musicToggle) {
      _loadAudio(); // Start the music
    } else {
      _audioPlayer.stop(); // Stop the music
    }
    notifyListeners();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset('audio/bg music growth.wav');
      _audioPlayer.setVolume(volume / 100); // Set initial volume
      _audioPlayer.setLoopMode(LoopMode.all); // Enable infinite looping
      _audioPlayer.play(); // Start playing the audio
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void addEvent(Home home) {
    _home.add(home);
    notifyListeners();
  }

  void addScore(String question, int score) {
    _quizManager.addScore(question, score);
    print("AppProvider: Score saved for $question -> $score"); // Debugging
    notifyListeners();
  }

  Map<String, double> calculateCategoryScores(QuizData quizDataInstance) {
    var scores = _quizManager.calculateCategoryScores(quizDataInstance);
    print("AppProvider: Final Calculated Scores: $scores"); // Debugging
    return scores;
  }

  void resetScores() {
    _quizManager.resetScores();
    notifyListeners();
  }

  void addDecisions(Decisions decisions) {
    _decisions.add(decisions);
    notifyListeners();
  }

  void resetAllData() {
    _home.clear();
    _decisions.clear();
    _quizManager.resetScores(); // Resets quiz scores
    directorypath = ""; // Resets directory path if necessary
    musicToggle = false; // Reset music switch
    _audioPlayer.stop(); // Ensure music is stopped
    notifyListeners();
    print("Data reset complete.");
  }
}
