String? formatAllString(String? stringToFormat, int space) {
  if (stringToFormat == null || stringToFormat.isEmpty) return null;

  final pattern = RegExp('.{1,$space}'); // use the parameter
  return stringToFormat.replaceAllMapped(pattern, (match) => '${match.group(0)} ').trim();
}