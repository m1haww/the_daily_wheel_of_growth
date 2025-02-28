import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_daily_wheel_of_growth/models/app_provider.dart';
import 'package:the_daily_wheel_of_growth/models/classes.dart';
import 'package:the_daily_wheel_of_growth/models/container.dart';
import 'package:the_daily_wheel_of_growth/models/text.dart';
import 'package:the_daily_wheel_of_growth/utils.dart';

class AaClanedarWrinting extends StatefulWidget {
  final DateTime selectedDay;
  const AaClanedarWrinting({super.key, required this.selectedDay});

  @override
  State<AaClanedarWrinting> createState() => _AaClanedarWrintingState();
}

class _AaClanedarWrintingState extends State<AaClanedarWrinting> {
  final TextEditingController _controllerttitle = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();
  bool _save = false;

  @override
  void initState() {
    super.initState();
    _controllerttitle.addListener(_updateSaveButtonState);
    _controllerdescription.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    _controllerttitle.dispose();
    _controllerdescription.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    setState(() {
      _save = _controllerttitle.text.isNotEmpty &&
          _controllerdescription.text.isNotEmpty &&
          (_selectedImage != null ||
              _imageData != null); // Added image condition
    });
  }

  File? _selectedImage;
  Uint8List? _imageData;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (kIsWeb) {
        Uint8List imageBytes = await pickedImage.readAsBytes();
        setState(() {
          _imageData = imageBytes;
        });
      } else {
        final directory = await getTemporaryDirectory();
        final cachedImage = File('${directory.path}/${pickedImage.name}');
        await File(pickedImage.path).copy(cachedImage.path);
        setState(() {
          _selectedImage = cachedImage;
        });
      }
      _updateSaveButtonState(); // 🔥 Actualizează starea butonului
    } else {
      if (kDebugMode) {
        print("No image selected.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBlackDark,
      appBar: AppBar(
        centerTitle: false,
        title: buildAppbartext(context, "Back"),
        backgroundColor: kBlackDark,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: buildAppbarLeading(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10),
            child: buildSave(
              context,
              _save
                  ? () {
                      final provider =
                          Provider.of<AppProvider>(context, listen: false);
                      final newEvent = Home(
                        title: _controllerttitle.text,
                        description: _controllerdescription.text,
                        image: _selectedImage?.path ?? "images/Untitled 1.png",
                        date: widget
                            .selectedDay, // Save the selected day with the event
                      );
                      newEvent.fileImage = _selectedImage;
                      provider.addEvent(newEvent);
                      // Double pop: first closes the writing page, then the calendar page,
                      // returning to HomePage with the updated event list.
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  : () {
                      // Show SnackBar if fields are not filled
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please complete all required fields, including image.",
                            style: TextStyle(fontFamily: "Inter"),
                          ),
                          backgroundColor: Color(0xffE5182B),
                        ),
                      );
                    },
              "Save",
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildHeight(context, 0.04),
              buildTextField(
                context,
                "Write your journal entry title here...",
                Colors.white,
                Colors.transparent,
                kBlackLight,
                controller: _controllerttitle,
              ),
              buildHeight(context, 0.02),
              buildTextFieldDescription(
                context,
                "Start writing your thoughts here...",
                Colors.white,
                Colors.transparent,
                kBlackLight,
                controller: _controllerdescription,
              ),
              buildHeight(context, 0.02),
              (_selectedImage == null && _imageData == null)
                  ? const SizedBox.shrink()
                  : Stack(
                      children: [
                        Container(
                          width: width * 0.49,
                          height: height * 0.23,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _selectedImage != null
                                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                                : Image.memory(_imageData!, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                                onTap: () => _showActionSheet(context),
                                child: Image(
                                    image: AssetImage("images/Close.png"))))
                      ],
                    ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap:
                        _pickImage, // Open image picker when the icon is tapped
                    child: Container(
                      width: width * 0.15,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kkPurpleDark,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Close the dialog (Cancel)
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
                  _selectedImage = null;
                  _imageData = null; // Remove the image data (Delete action)
                });
                Navigator.pop(context); // Close the dialog after deletion
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
              isDestructiveAction: true, // Mark as destructive
            ),
          ],
        );
      },
    );
  }
}
