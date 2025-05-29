import 'dart:convert';

extension JsonMap on Map<String, dynamic> {
  /// Convert [Map] to json [String]
  String toJson() => jsonEncode(this);
}
