import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';
import 'package:fun_app/features/presentation/bloc/home/home_bloc.dart';

class HomeMobileSubpage extends StatefulWidget {
  const HomeMobileSubpage({Key? key}) : super(key: key);

  @override
  State<HomeMobileSubpage> createState() => _HomeMobileSubpageState();
}

class _HomeMobileSubpageState extends State<HomeMobileSubpage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetJokesList());
    timer = Timer.periodic(const Duration(seconds: 60),
        (Timer t) => BlocProvider.of<HomeBloc>(context).add(GetJokesList()));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Joke List"),
          backgroundColor: Colors.blueAccent,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            debugPrint("state: $state");
            if (state is HomeJokeListLoaded) {
              debugPrint("state HomeJokeListLoaded: ${state.entityList.length}");
            }
          },
          builder: (context, state) {
            if (state is HomeJokeListLoaded) {
              return ListView.builder(
                itemCount: state.entityList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(16.0),
                    color: Colors.blueAccent.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(state.entityList[index].jokeDes ?? ""),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
