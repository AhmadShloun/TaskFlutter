import 'package:task_flutter/data/model/homemodel/media_model.dart';

class UserModel {
  int? id;
  int? userId;
  String? sn;
  String? firstName;
  String? middleName;
  String? lastName;
  int? gender;
  bool? isBlocked;
  Null? blockedUntil;
  String? createdAt;
  String? updatedAt;
  String? lastSeen;
  String? name;
  int? isFriend;
  int? mutualfriendsCount;
  bool? screenBlock;
  bool? hasMediaProfile;
  bool? hasMediaCover;
  List<MediaModel>? media;

  UserModel(
      {this.id,
        this.userId,
        this.sn,
        this.firstName,
        this.middleName,
        this.lastName,
        this.gender,
        this.isBlocked,
        this.blockedUntil,
        this.createdAt,
        this.updatedAt,
        this.lastSeen,
        this.name,
        this.isFriend,
        this.mutualfriendsCount,
        this.screenBlock,
        this.hasMediaProfile,
        this.hasMediaCover,
        this.media});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sn = json['sn'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    isBlocked = json['isBlocked'];
    blockedUntil = json['blocked_until'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastSeen = json['last_seen'];
    name = json['name'];
    isFriend = json['is_friend'];
    mutualfriendsCount = json['mutualfriends_count'];
    screenBlock = json['screen_block'];
    hasMediaProfile = json['has_media_profile'];
    hasMediaCover = json['has_media_cover'];
    if (json['media'] != null) {
      media = <MediaModel>[];
      json['media'].forEach((v) {
        media!.add(MediaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['sn'] = sn;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['isBlocked'] = isBlocked;
    data['blocked_until'] = blockedUntil;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_seen'] = lastSeen;
    data['name'] = name;
    data['is_friend'] = isFriend;
    data['mutualfriends_count'] = mutualfriendsCount;
    data['screen_block'] = screenBlock;
    data['has_media_profile'] = hasMediaProfile;
    data['has_media_cover'] = hasMediaCover;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}