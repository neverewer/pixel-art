import 'dart:convert';

class PixelData {
  final List<List<int>> pixels;
  final List<int>? colors;

  PixelData({
    required this.pixels,
    this.colors,
  });

  factory PixelData.fromRawJson(String str) => PixelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PixelData.fromJson(Map<String, dynamic> json) => PixelData(
        colors: json["colors"] == null ? [] : List<int>.from(json["colors"].map((x) => x)),
        pixels: List<List<int>>.from(json["pixels"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "pixels": List<dynamic>.from(pixels.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
