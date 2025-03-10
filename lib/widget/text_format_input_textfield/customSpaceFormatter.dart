import 'package:flutter/services.dart';

class CustomCharacterSpaceFormatter extends TextInputFormatter {
  final int interval;

  CustomCharacterSpaceFormatter({required this.interval});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(' ', ''); // Remove existing spaces
    String formattedText = '';

    // Add spaces every `interval` characters
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % interval == 0) {
        formattedText += ' ';
      }
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length, // Move cursor to the end
      ),
    );
  }
}