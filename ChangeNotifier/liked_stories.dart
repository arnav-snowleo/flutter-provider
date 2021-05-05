import 'package:flutter/material.dart';

import '../helpers/api_handler.dart';
import './story.dart';

class LikedStories with ChangeNotifier {
  List<Story> _stories = [];

  Future<void> load() async {
    _stories = await APIHandler.getLikedStories();
    notifyListeners();
  }

  List<Story> get stories {
    return [..._stories];
  }
}
