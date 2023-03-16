import 'package:json_annotation/json_annotation.dart';

part 'app_version.g.dart';

@JsonSerializable()
class AppVersion{
	String version;
	
	AppVersion({this.version});
	
	static Map<String, dynamic> toJson(AppVersion instance){
		return _$AppVersionToJson(instance);
	}
	
	static AppVersion fromJson(Map<String, dynamic> json){
		return _$AppVersionFromJson(json);
	}
}