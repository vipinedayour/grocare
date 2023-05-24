import 'dart:convert';
// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

List<Model> modelFromJson(String str) => List<Model>.from(
    json.decode(str)['data']['posts'].map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  final String postId;
  final Creator creator;
  final Comment comment;
  final Reaction reaction;
  final Submission submission;

  Model({
    required this.postId,
    required this.creator,
    required this.comment,
    required this.reaction,
    required this.submission,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        postId: json["postId"],
        creator: Creator.fromJson(json["creator"]),
        comment: Comment.fromJson(json["comment"]),
        reaction: Reaction.fromJson(json["reaction"]),
        submission: Submission.fromJson(json["submission"]),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "creator": creator.toJson(),
        "comment": comment.toJson(),
        "reaction": reaction.toJson(),
        "submission": submission.toJson(),
      };
}

class Comment {
  final int count;
  final bool commentingAllowed;

  Comment({
    required this.count,
    required this.commentingAllowed,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        count: json["count"],
        commentingAllowed: json["commentingAllowed"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "commentingAllowed": commentingAllowed,
      };
}

class Creator {
  final String name;
  final String id;
  final String handle;
  final String pic;

  Creator({
    required this.name,
    required this.id,
    required this.handle,
    required this.pic,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        name: json["name"],
        id: json["id"],
        handle: json["handle"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "handle": handle,
        "pic": pic,
      };
}

class Reaction {
  final int count;
  final bool voted;

  Reaction({
    required this.count,
    required this.voted,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        count: json["count"],
        voted: json["voted"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "voted": voted,
      };
}

class Submission {
  final String title;
  final String description;
  final String mediaUrl;
  final String thumbnail;
  final String hyperlink;
  final String placeholderUrl;

  Submission({
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.thumbnail,
    required this.hyperlink,
    required this.placeholderUrl,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        title: json["title"],
        description: json["description"],
        mediaUrl: json["mediaUrl"],
        thumbnail: json["thumbnail"],
        hyperlink: json["hyperlink"],
        placeholderUrl: json["placeholderUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "mediaUrl": mediaUrl,
        "thumbnail": thumbnail,
        "hyperlink": hyperlink,
        "placeholderUrl": placeholderUrl,
      };
}

// enum Title { RANDOM_TITLE }

// final titleValues = EnumValues({"Random Title": Title.RANDOM_TITLE});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
