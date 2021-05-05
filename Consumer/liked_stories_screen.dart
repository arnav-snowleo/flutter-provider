import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart' as Colors;
import '../providers/liked_stories.dart';
import '../widgets/story/stories_grid.dart';
import '../widgets/left_menu_drawer.dart';

class LikedStoriesScreen extends StatelessWidget {
  static const String id = 'liked_stories_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.kTransparent,
      appBar: AppBar(
        title: Text('Liked Stories'),
        // backgroundColor: Colors.kTransparent,
        // elevation: 0,
      ),
      // extendBodyBehindAppBar: true,
      drawer: LeftMenuDrawer(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: Colors.kDarkBackgroundGradient),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<LikedStories>(context, listen: false).load(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  heightFactor: 15,
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.error != null) {
                  // ...TODO
                  // Do error handling stuff
                  return Center(
                    heightFactor: 5,
                    child: Text('An error occurred!'),
                  );
                } else {
                  return Consumer<LikedStories>(
                    builder: (ctx, data, _) => Column(
                      children: [
                        // SizedBox(height: 70),
                        data.stories.isNotEmpty
                            ? StoriesGrid(stories: data.stories)
                            : Center(
                                child: Text('This space is empty'),
                              ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
