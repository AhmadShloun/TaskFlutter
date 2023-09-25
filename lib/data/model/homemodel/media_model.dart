class MediaModel {
  int? id;
  String? modelType;
  int? modelId;
  String? srcUrl;
  String? srcIcon;
  String? srcThum;
  String? collectionName;
  String? fullPath;
  String? mediaType;
  String? mimeType;
  int? size;
  int? width;
  int? height;
  String? createdAt;
  String? updatedAt;
  bool? saved;

  MediaModel(
      {this.id,
        this.modelType,
        this.modelId,
        this.srcUrl,
        this.srcIcon,
        this.srcThum,
        this.collectionName,
        this.fullPath,
        this.mediaType,
        this.mimeType,
        this.size,
        this.width,
        this.height,
        this.createdAt,
        this.updatedAt,
        this.saved});

  MediaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    srcUrl = json['src_url'];
    srcIcon = json['src_icon'];
    srcThum = json['src_thum'];
    collectionName = json['collection_name'];
    fullPath = json['fullPath'];
    mediaType = json['media_type'];
    mimeType = json['mime_type'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    saved = json['saved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['src_url'] = srcUrl;
    data['src_icon'] = srcIcon;
    data['src_thum'] = srcThum;
    data['collection_name'] = collectionName;
    data['fullPath'] = fullPath;
    data['media_type'] = mediaType;
    data['mime_type'] = mimeType;
    data['size'] = size;
    data['width'] = width;
    data['height'] = height;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['saved'] = saved;
    return data;
  }
}