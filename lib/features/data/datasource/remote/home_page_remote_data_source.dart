import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:fun_app/features/data/datasource/local/home_page_local_data_source.dart';
import 'package:fun_app/features/data/datasource/remote/network_client/api_service.dart';
import 'package:fun_app/features/data/models/home/jokes_model.dart';
import 'package:http/http.dart' as http;

abstract class HomePageRemoteDataSource {
  Future<List<JokesModel>> getJokes();
}

class HomePageRemoteDataSourceImpl extends HomePageRemoteDataSource {
  final ApiService apiService;
  final HomePageLocalDataSource localDataSource;

  HomePageRemoteDataSourceImpl(this.apiService, this.localDataSource);

  @override
  Future<List<JokesModel>> getJokes() async {
    try {
      final Response response = await apiService.getJoke();
      final JokesModel model =
          JokesModel.fromJson(json.decode(response.bodyString) as Map<String, dynamic>);
      final List<JokesModel>? list = await localDataSource.getJokes();
      if (list != null && list.isNotEmpty && list.length >= 10) {
        await localDataSource.deleteJoke(list[0].id!);
        list.removeAt(0);
      }
      await localDataSource.insertJoke(model);
      (list ?? []).add(model);
      return list!;
    } on SocketException {
      throw const SocketException('SocketException');
    } on http.ClientException {
      throw http.ClientException("ClientException");
    } on TimeoutException {
      throw TimeoutException("TimeoutException");
    }
  }
}
