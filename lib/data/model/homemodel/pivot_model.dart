class PivotModel {
  int? postId;
  int? profileId;
  int? status;
  int? id;
  int? type;
  String? createdAt;
  String? updatedAt;

  PivotModel(
      {this.postId,
        this.profileId,
        this.status,
        this.id,
        this.type,
        this.createdAt,
        this.updatedAt});

  PivotModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    profileId = json['profile_id'];
    status = json['status'];
    id = json['id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['profile_id'] = profileId;
    data['status'] = status;
    data['id'] = id;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}