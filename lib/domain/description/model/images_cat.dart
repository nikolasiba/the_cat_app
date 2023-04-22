

// To parse this JSON data, do
//
//     final imagesCat = imagesCatFromJson(jsonString);

import 'dart:convert';

ImagesCat imagesCatFromJson(String str) => ImagesCat.fromJson(json.decode(str));

String imagesCatToJson(ImagesCat data) => json.encode(data.toJson());

class ImagesCat {
    ImagesCat({
        this.id,
        this.url,
        this.width,
        this.height,
    });

    String? id;
    String? url;
    int? width;
    int? height;

    factory ImagesCat.fromJson(Map<String, dynamic> json) => ImagesCat(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
    };
}
