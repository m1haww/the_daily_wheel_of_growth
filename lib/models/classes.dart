import 'dart:io';

class Home {
  final String title;
  final String description;
  final String image;
  final DateTime date;
  File? fileImage;
  bool isown = false;
  Home(
      {required this.title,
      required this.description,
      required this.date,
      required this.image});
}

class Decisions {
  final String title;
  final String option1;
  final String option2;
  String? option3;
  Decisions(
      {required this.title, required this.option1, required this.option2});
}

class Info {
  final String title;
  final String description;

  Info({required this.title, required this.description});
}

List<Info> info = [
  Info(
    title: "📖 Gratitude Journal",
    description:
        "📌 Focus on the positive aspects of life.\n🔹 Template:\n✨ Today, I am grateful for... (🌿🌞❤️ – List 3-5 things)\n💖 Something good that happened today...\n👥 A person I appreciate today...\n🔄 How I can show more gratitude tomorrow...",
  ),
  Info(
    title: "😨 Fear Reflection",
    description:
        "📌 Understand and work through your fears.\n🔹 Template:\n❓ What am I afraid of right now?\n🧠 Why does this fear exist?\n⚠️ What is the worst that can happen?\n🚀 What small step can I take to reduce this fear?",
  ),
  Info(
    title: "🎯 100 Goals Challenge",
    description:
        "📌 Define your life goals and start working towards them!\n🔹 Template:\n🏆 Long-term goals (10+ years)\n⏳ Mid-term goals (3-5 years)\n📅 Short-term goals (1 year or less)\n🚀 Which goal can I start working on today?",
  ),
  Info(
    title: "😊 Emotional Check-in",
    description:
        "📌 Recognize and analyze your emotions.\n🔹 Template:\n🎭 How do I feel right now? (Choose an emotion 😊😔😡😌)\n🔍 What caused this emotion?\n🌊 How is this emotion affecting my actions?\n⚖️ What can I do to balance my emotions?",
  ),
  Info(
    title: "🤔 Decision-Making Journal",
    description:
        "📌 Make thoughtful decisions and evaluate options.\n🔹 Template:\n❓ What decision do I need to make?\n🔄 What are the possible options?\n⚖️ Pros & cons of each option\n💡 What is my gut feeling?\n🚀 What small step can I take today?",
  ),
];
