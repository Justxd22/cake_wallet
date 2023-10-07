class TwitterUser {
  TwitterUser(
      {required this.id,
      required this.username,
      required this.name,
      required this.description,
      this.tweets});

  final String id;
  final String username;
  final String name;
  final String description;
  final List<Tweet>? tweets;

  factory TwitterUser.fromJson(Map<String, dynamic> json) {
    return TwitterUser(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      description: json['address'] as String? ?? '',
      tweets: null,
    );
  }
}

class Tweet {
  Tweet({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
      id: json['id'] as String,
      text: json['text'] as String,
    );
  }
}
