class Courses {
  String? sId;
  int? id;
  String? title;
  String? description;
  String? imageUrl;
  List<Lessons>? lessons;
  List<String>? enrolledUsers;

  Courses(
      {this.sId,
        this.id,
        this.title,
        this.description,
        this.imageUrl,
        this.lessons,
        this.enrolledUsers});

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
    enrolledUsers = json['enrolledUsers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    data['enrolledUsers'] = this.enrolledUsers;
    return data;
  }
}

class Lessons {
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  String? imageUrl;

  Lessons(
      {this.id, this.title, this.description, this.videoUrl, this.imageUrl});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
