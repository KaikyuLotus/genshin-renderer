class Relic {
  final int id;
  final int level;
  final int pos;
  final String name;
  final String desc;
  final String icon;
  final int rarity;

  Relic({
    required this.id,
    required this.level,
    required this.pos,
    required this.name,
    required this.desc,
    required this.icon,
    required this.rarity,
  });

  static Relic fromJson(Map<String, dynamic> json) {
    return Relic(
      id: json['id'],
      level: json['level'],
      pos: json['pos'],
      name: json['name'],
      desc: json['desc'],
      icon: json['icon'],
      rarity: json['rarity'],
    );
  }

  static List<Relic> fromJsonArray(List<dynamic> jsonArray) {
    return List<Relic>.from(jsonArray.map((e) => Relic.fromJson(e)));
  }
}

// Light Cone
class Equip {
  final int id;
  final int level;
  final int rank;
  final String name;
  final String desc;
  final String icon;

  Equip({
    required this.id,
    required this.level,
    required this.rank,
    required this.name,
    required this.desc,
    required this.icon,
  });

  static Equip fromJson(Map<String, dynamic> json) {
    return Equip(
      id: json['id'],
      level: json['level'],
      rank: json['rank'],
      name: json['name'],
      desc: json['desc'],
      icon: json['icon'],
    );
  }
}

// Character
class Avatar {
  final int id;
  final int level;
  final String name;
  final String element;
  final String icon;
  final int rarity;
  final int rank;
  final bool? isChosen;
  final Equip? equip;
  final List<Relic>? relics;

  const Avatar({
    required this.id,
    required this.level,
    required this.name,
    required this.element,
    required this.icon,
    required this.rarity,
    required this.rank,
    required this.isChosen,
    required this.equip,
    required this.relics,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      level: json['level'],
      name: json['name'],
      element: json['element'],
      icon: json['icon'],
      rarity: json['rarity'],
      rank: json['rank'],
      isChosen: json['is_chosen'],
      equip: json['equip'] != null ? Equip.fromJson(json['equip']) : null,
      relics: Relic.fromJsonArray(json['relics']),
    );
  }
}

class UserStats {
  final int activeDays;
  final int avatarNum;
  final int achievementNum;
  final int chestNum;
  final String abyssProcess;

  UserStats({
    required this.activeDays,
    required this.avatarNum,
    required this.achievementNum,
    required this.chestNum,
    required this.abyssProcess,
  });

  static UserStats fromJson(Map<String, dynamic> json) {
    return UserStats(
      activeDays: json['active_days'],
      avatarNum: json['avatar_num'],
      achievementNum: json['achievement_num'],
      chestNum: json['chest_num'],
      abyssProcess: json['abyss_process'],
    );
  }
}

class UserInfo {
  final UserStats stats;
  final List<Avatar> avatarList;

  UserInfo({
    required this.stats,
    required this.avatarList,
  });

  static UserInfo fromJson(Map<String, dynamic> json) {
    return UserInfo(
      stats: UserStats.fromJson(json['stats']),
      avatarList: List<Avatar>.from(
        json['avatar_list'].map((a) => Avatar.fromJson(a)),
      ),
    );
  }
}
