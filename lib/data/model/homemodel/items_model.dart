import 'package:task_flutter/data/model/homemodel/interactions_counttype_model.dart';
import 'package:task_flutter/data/model/homemodel/media_model.dart';
import 'package:task_flutter/data/model/homemodel/parent_model.dart';
import 'package:task_flutter/data/model/homemodel/tag_model.dart';
import 'package:task_flutter/data/model/homemodel/user_model.dart';

class ItemsModel {
  int? id;
  int? userId;
  int? parentId;
  String? modelType;
  int? modelId;
  String? content;
  int? index;
  int? status;
  int? type;
  String? createdAt;
  String? updatedAt;
  int? interactionsCount;
  InteractionsCountTypesModel? interactionsCountTypes;
  int? commentsCount;
  int? sharesCount;
  int? tagsCount;
  bool? sharingPost;
  bool? hasMedia;
  bool? saved;
  bool? taged;
  UserModel? model;
  List<MediaModel>? media;
  List<TagsModel>? tags;
  Null? interacted;
  ParentModel? parent;

  ItemsModel(
      {this.id,
        this.userId,
        this.parentId,
        this.modelType,
        this.modelId,
        this.content,
        this.index,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.interactionsCount,
        this.interactionsCountTypes,
        this.commentsCount,
        this.sharesCount,
        this.tagsCount,
        this.sharingPost,
        this.hasMedia,
        this.saved,
        this.taged,
        this.model,
        this.media,
        this.tags,
        this.interacted,
        this.parent});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    parentId = json['parent_id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    content = json['content'];
    index = json['index'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    interactionsCount = json['interactions_count'];
    interactionsCountTypes = json['interactions_count_types'] != null
        ? InteractionsCountTypesModel.fromJson(json['interactions_count_types'])
        : null;
    commentsCount = json['comments_count'];
    sharesCount = json['shares_count'];
    tagsCount = json['tags_count'];
    sharingPost = json['sharing_post'];
    hasMedia = json['has_media'];
    saved = json['saved'];
    taged = json['taged'];
    model = json['model'] != null ? UserModel.fromJson(json['model']) : null;
    if (json['media'] != null) {
      media = <MediaModel>[];
      json['media'].forEach((v) {
        media!.add(MediaModel.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <TagsModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagsModel.fromJson(v));
      });
    }
    interacted = json['interacted'];
    parent =
    json['parent'] != null ? ParentModel.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['parent_id'] = parentId;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['content'] = content;
    data['index'] = index;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['interactions_count'] = interactionsCount;
    if (interactionsCountTypes != null) {
      data['interactions_count_types'] = interactionsCountTypes!.toJson();
    }
    data['comments_count'] = commentsCount;
    data['shares_count'] = sharesCount;
    data['tags_count'] = tagsCount;
    data['sharing_post'] = sharingPost;
    data['has_media'] = hasMedia;
    data['saved'] = saved;
    data['taged'] = taged;
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['interacted'] = interacted;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}