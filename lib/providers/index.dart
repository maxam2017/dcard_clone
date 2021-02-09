import 'package:dcard_clone/providers/post_provider.dart';
import 'package:dcard_clone/providers/reaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
  ChangeNotifierProvider<ReactionProvider>(create: (_) => ReactionProvider(),)
];
