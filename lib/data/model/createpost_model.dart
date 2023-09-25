class CreatePostModel {
  String? content;
  List<Media>? media;

  CreatePostModel({this.content, this.media});

  CreatePostModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null){
      data['content'] = content;
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  String? srcUrl;
  String? srcThum;
  String? srcIcon;
  String? mediaType;
  String? mimeType;
  String? fullPath;
  int? width;
  int? height;
  int? size;

  Media(
      {this.srcUrl,
        this.srcThum,
        this.srcIcon,
        this.mediaType,
        this.mimeType,
        this.fullPath,
        this.width,
        this.height,
        this.size});

  Media.fromJson(Map<String, dynamic> json) {
    srcUrl = json['src_url'];
    srcThum = json['src_thum'];
    srcIcon = json['src_icon'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    fullPath = json['fullPath'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src_url'] = srcUrl;
    data['src_thum'] = srcThum;
    data['src_icon'] = srcIcon;
    data['media_type'] = mediaType;
    data['mime_type'] = mimeType;
    data['fullPath'] = fullPath;
    data['width'] = width;
    data['height'] = height;
    data['size'] = size;
    return data;
  }
}
