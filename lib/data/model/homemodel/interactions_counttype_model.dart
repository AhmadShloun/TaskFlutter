class InteractionsCountTypesModel {
  int? like;
  int? love;
  int? care;
  int? haha;
  int? wow;
  int? sad;
  int? angry;

  InteractionsCountTypesModel(
      {this.like,
        this.love,
        this.care,
        this.haha,
        this.wow,
        this.sad,
        this.angry});

  InteractionsCountTypesModel.fromJson(Map<String, dynamic> json) {
    like = json['like'];
    love = json['love'];
    care = json['care'];
    haha = json['haha'];
    wow = json['wow'];
    sad = json['sad'];
    angry = json['angry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['like'] = like;
    data['love'] = love;
    data['care'] = care;
    data['haha'] = haha;
    data['wow'] = wow;
    data['sad'] = sad;
    data['angry'] = angry;
    return data;
  }
}