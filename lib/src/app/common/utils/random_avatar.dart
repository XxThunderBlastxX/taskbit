import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_avatar/random_avatar.dart' as avatar;

final randomAvatarProvider = Provider.family<Widget, String>((ref, str) {
  return RandomAvatar.getRandomAvatar(str);
});

class RandomAvatar {
  static Widget getRandomAvatar(String str) {
    return avatar.RandomAvatar(str);
  }
}
