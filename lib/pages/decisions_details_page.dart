import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class DecisionsDetailsPage extends StatefulWidget {
  const DecisionsDetailsPage({super.key});

  @override
  State<DecisionsDetailsPage> createState() => _DecisionsDetailsPageState();
}

class _DecisionsDetailsPageState extends State<DecisionsDetailsPage> {
  final TextEditingController _controllerdecisions = TextEditingController();
  final TextEditingController _controlleroption1 = TextEditingController();
  final TextEditingController _controlleroption2 = TextEditingController();
  final TextEditingController _controlleroption3 = TextEditingController();

  bool _save = false;
  bool _showExtraOption = false;
  bool _showDeleteIcon = false;

  @override
  void initState() {
    super.initState();
    _controllerdecisions.addListener(_updateSaveButtonState);
    _controlleroption1.addListener(_updateSaveButtonState);
    _controlleroption2.addListener(_updateSaveButtonState);
    _controlleroption3.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    _controllerdecisions.dispose();
    _controlleroption1.dispose();
    _controlleroption2.dispose();
    _controlleroption3.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    setState(() {
      _save = _controllerdecisions.text.isNotEmpty &&
          _controlleroption1.text.isNotEmpty &&
          _controlleroption2.text.isNotEmpty &&
          (!_showExtraOption || _controlleroption3.text.isNotEmpty);
    });
  }

  void _deleteOption3() {
    setState(() {
      _controlleroption3.clear();
      _showExtraOption = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        backgroundColor: kBlackDark,
        leading: buildAppbarLeading(context),
        centerTitle: false,
        title: buildAppbartext(context, "Back"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: buildSave(context, () {
              final provider = Provider.of<AppProvider>(context, listen: false);

              // Check if Option 1 or Option 2 are empty
              if (_controlleroption1.text.isEmpty ||
                  _controlleroption2.text.isEmpty ||
                  _controllerdecisions.text.isEmpty) {
                // Show SnackBar if any required field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please complete all required fields.",
                      style: TextStyle(fontFamily: "Inter"),
                    ),
                    backgroundColor: Color(0xffE5182B),
                  ),
                );
              } else if (_showExtraOption && _controlleroption3.text.isEmpty) {
                // Show SnackBar if Option 3 is visible but empty
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please complete Option 3.",
                      style: TextStyle(fontFamily: "Inter"),
                    ),
                    backgroundColor: Color(0xffE5182B),
                  ),
                );
              } else {
                final eventik = Decisions(
                  title: _controllerdecisions.text,
                  option1: _controlleroption1.text,
                  option2: _controlleroption2.text,
                );
                if (_showExtraOption) {
                  eventik.option3 = _controlleroption3.text;
                }
                provider.addDecisions(eventik);
                Navigator.pop(context);
              }
            }, "Save"),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeight(context, 0.02),
              buildTextField(context, "What decision do you need to make?",
                  Colors.white, Colors.transparent, kBlackLight,
                  controller: _controllerdecisions),
              buildHeight(context, 0.02),
              buildTextFieldOption(context, "Add Option", Colors.white,
                  Colors.transparent, Color(0xffCCCCCC),
                  controller: _controlleroption1),
              buildHeight(context, 0.02),
              buildTextFieldOption(context, "Add Option", Colors.white,
                  Colors.transparent, Color(0xffCCCCCC),
                  controller: _controlleroption2),
              buildHeight(context, 0.02),
              if (_showExtraOption)
                Stack(
                  children: [
                    // Delete button (behind the text field)
                    Positioned(
                      right: 0,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: _showDeleteIcon ? 1.0 : 0.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showDeleteIcon = false;
                              _showActionSheet(context);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kkPurpleDark,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Swipeable Text Field
                    GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta! < -10 && !_showDeleteIcon) {
                          // Swiped left
                          setState(() {
                            _showDeleteIcon = true;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: EdgeInsets.only(
                            right: _showDeleteIcon
                                ? 50
                                : 0), // Shift left when swiped
                        child: buildTextFieldOption(
                          context,
                          "Add Option",
                          Colors.white,
                          Colors.transparent,
                          Color(0xffCCCCCC),
                          controller: _controlleroption3,
                        ),
                      ),
                    ),
                  ],
                ),
              buildHeight(context, 0.02),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showExtraOption = !_showExtraOption; // Toggle visibility
                  });
                },
                child: Center(
                  child: Container(
                      width: width * 0.15,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kkPurpleDark,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Unsaved Changes",
            style: TextStyle(
              fontFamily: "Sf",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: const Text(
            "You have unsaved changes. If you exit \n now, your progress will be lost. Do you \n want to continue?",
            style: TextStyle(
              fontFamily: "Sf",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Închide dialogul fără să șteargă
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: "Sf",
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff007AFF),
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  _deleteOption3(); // Șterge opțiunea 3
                });
                Navigator.pop(context); // Închide dialogul după ștergere
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontFamily: "Sf",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffFF3B30),
                ),
              ),
              isDestructiveAction: true, // Marcat ca acțiune distructivă
            ),
          ],
        );
      },
    );
  }
}
