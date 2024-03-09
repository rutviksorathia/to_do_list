import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
        viewModelBuilder: () => StartupViewModel(),
        onViewModelReady: (model) {
          model.checkAuthentication();
        },
        builder: (context, model, child) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}
