import 'package:app/modal/color_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final Box<ColorModal> _colorBox = Hive.box<ColorModal>('colorBox');
  List<ColorModal> colors = [];

  @override
  void initState() {
    super.initState();
    _loadColors();
  }

  void _loadColors() {
    setState(() {
      colors = _colorBox.values.toList();
    });
  }

  void _addColor(String colorName) async {
    String trimmedColorName = colorName.trim();
    if (trimmedColorName.isNotEmpty) {
      await _colorBox.add(ColorModal(colorName: trimmedColorName));
      _loadColors();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Color added successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
        )
        );
      }
    }
  }

  void _updateColorName(dynamic key, String editedColorName) async {
    String trimmedColorName = editedColorName.trim();
    if (trimmedColorName.isNotEmpty) {
      final color = _colorBox.get(key);
      if (color != null) {
        final updatedColor = ColorModal(colorName: trimmedColorName);
        await _colorBox.put(key, updatedColor);
        _loadColors();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Color updated successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
          )
          );
        }
      }
    }
  }

  void alertDialogueColor(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController colorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text(
            'Add New Color',
            style: TextStyle(fontSize: 20),
          ),
          content: Container(
            height: 100,
            width: 300,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: colorController,
                    decoration: InputDecoration(
                      hintText: 'Enter color',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Color name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final colorName = colorController.text.trim();
                  _addColor(colorName);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void alertDialogEditColorName(BuildContext context, dynamic key, String currentColorName) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _colorController = TextEditingController(text: currentColorName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text(
            'Edit Color',
            style: TextStyle(fontSize: 20),
          ),
          content: Container(
            height: 100,
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _colorController,
                    decoration: InputDecoration(
                      hintText: 'Edit color name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Color name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final editedColorName = _colorController.text.trim();
                  _updateColorName(key, editedColorName);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Color',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final color = colors[index];
            final key = _colorBox.keyAt(index); // Get the key for the color

            return Card(
              color: const Color(0xFFFCF7F8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    color.colorName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 60),
                  Row(
                    children: [
                      IconButton(
                    onPressed: () {
                      alertDialogEditColorName(context, key, color.colorName); // Pass key and current color name
                    },
                    icon: const Icon(Icons.edit, size: 17),
                  ),
                   IconButton(
                    onPressed: () {
                      alertDialogEditColorName(context, key, color.colorName); // Pass key and current color name
                    },
                    icon: const Icon(Icons.delete, size: 17),
                  ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          alertDialogueColor(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F2F33),
          minimumSize: const Size(350, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'Add Color',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}