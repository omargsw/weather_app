import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:weather_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:weather_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:weather_app/features/auth/domain/usecases/register_usercase.dart';
import 'package:weather_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:weather_app/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:weather_app/features/home/data/data_sources/remote/user_info_remote_data_source.dart';
import 'package:weather_app/features/home/domain/repositories/user_info_repo.dart';
import 'package:weather_app/features/home/domain/usecases/fetch_user_info_usecase.dart';
import 'package:weather_app/features/home/presentation/bloc/user_info_bloc/user_info_bloc.dart';

part 'service_locator.dart';
