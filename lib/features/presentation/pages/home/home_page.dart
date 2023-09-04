import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_app/core/di/injection_container_getit.dart';
import 'package:fun_app/features/presentation/bloc/home/home_bloc.dart';
import 'package:fun_app/features/presentation/pages/home/subpage/home_mobile_subpage.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  static const id = 'home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<HomeBloc>()),
      ],
      child: ResponsiveBuilder(
        builder: (_, size) {
          return (size.isDesktop) ? const HomeMobileSubpage() : const HomeMobileSubpage();
        },
      ),
    );
  }
}
