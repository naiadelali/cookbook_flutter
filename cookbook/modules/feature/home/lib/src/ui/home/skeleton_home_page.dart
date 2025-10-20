import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home/src/theme/strings.dart';
import 'package:home/src/ui/state/cubit/home_cubit.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class SkeletonHomePage extends StatefulWidget {
  final Function(int) onTap;
  final int index;
  final Widget child;

  const SkeletonHomePage(
      {super.key,
      required this.index,
      required this.child,
      required this.onTap});

  @override
  State<SkeletonHomePage> createState() => _SkeletonHomePageState();
}

class _SkeletonHomePageState extends State<SkeletonHomePage> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().initialize(appCubit: context.read());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              label: ModuleStrings.home,
              icon: Icon(Icons.home),
            ),
            NavigationDestination(
              label: ModuleStrings.explore,
              icon: Icon(Icons.explore),
            ),
            NavigationDestination(
              label: ModuleStrings.profile,
              icon: Icon(Icons.person),
            ),
            NavigationDestination(
              label: ModuleStrings.settings,
              icon: Icon(Icons.settings),
            )
          ],
          onDestinationSelected: widget.onTap,
          selectedIndex: widget.index,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        body: widget.child,
      ),
    );
  }
}
