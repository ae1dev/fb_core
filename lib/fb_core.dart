library fb_core;

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:uuid/uuid.dart';
import 'models/_models.dart' as fb;

export 'models/_models.dart';

//API
part 'featurebase.dart';
part 'endpoint_base.dart';
part 'endpoints/auth.dart';
part 'endpoints/help_center.dart';
part 'endpoints/changelog.dart';
part 'endpoints/organization.dart';
part 'endpoints/feedback.dart';
part 'endpoints/messenger.dart';
part 'endpoints/user.dart';
part 'endpoints/comment.dart';
