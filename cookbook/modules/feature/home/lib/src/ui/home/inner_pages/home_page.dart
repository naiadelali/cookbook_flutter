import 'package:flutter/material.dart';
import 'package:home/src/theme/strings.dart';
import 'package:home/src/ui/state/cubit/home_cubit.dart';
import 'package:home/src/ui/state/home_state.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 50,
              ),
              Text(
                ModuleStrings.homePage,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (_, state) {
                    final cubit = context.read<HomeCubit>();

                    if (state.session != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10,
                        children: [
                          ClipRect(
                            child: Text(
                              '${ModuleStrings.token} ${state.session?.content?.refreshToken}',
                            ),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(8),
                              ),
                            ),
                            onPressed: cubit.refreshToken,
                            child: Text(ModuleStrings.refreshToken),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(8),
                              ),
                            ),
                            onPressed: cubit.signOut,
                            child: Text(ModuleStrings.logout),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(8),
                              ),
                            ),
                            onPressed: cubit.pop,
                            child: const Icon(Icons.arrow_back),
                          )
                        ],
                      );
                    } else if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            Text(state.errorMessage ?? ModuleStrings.notLogged),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional.circular(8),
                                ),
                              ),
                              onPressed: cubit.signOut,
                              child: Text(ModuleStrings.logout),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
