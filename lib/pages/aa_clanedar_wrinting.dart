import 'dart:io';
import 'dart:typed_data';
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
          _controllerdescription.text.isNotEmpty;
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
        backgroundColor: kBlackDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          buildSave(
            context,
            _save
                ? () {
                    final provider =
                        Provider.of<AppProvider>(context, listen: false);
                    final newEvent = Home(
                      title: _controllerttitle.text,
                      description: _controllerdescription.text,
                      image: _selectedImage?.path ?? "images/splash_img.png",
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please complete all required fields.",
                          style: TextStyle(fontFamily: "Inter"),
                        ),
                        backgroundColor: Color(0xffE5182B),
                      ),
                    );
                  },
            "Save",
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  : Container(
                      width: width * 0.3,
                      height: height * 0.23,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : Image.memory(_imageData!, fit: BoxFit.cover),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  backgroundColor: kBlackLight,
                  onPressed: _pickImage,
                  child: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
