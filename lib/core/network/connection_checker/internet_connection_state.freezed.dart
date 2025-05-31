// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InternetConnectionState {

 AppConnectionType get connectionType; AppInternetStatus get status;
/// Create a copy of InternetConnectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternetConnectionStateCopyWith<InternetConnectionState> get copyWith => _$InternetConnectionStateCopyWithImpl<InternetConnectionState>(this as InternetConnectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternetConnectionState&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,connectionType,status);

@override
String toString() {
  return 'InternetConnectionState(connectionType: $connectionType, status: $status)';
}


}

/// @nodoc
abstract mixin class $InternetConnectionStateCopyWith<$Res>  {
  factory $InternetConnectionStateCopyWith(InternetConnectionState value, $Res Function(InternetConnectionState) _then) = _$InternetConnectionStateCopyWithImpl;
@useResult
$Res call({
 AppConnectionType connectionType, AppInternetStatus status
});




}
/// @nodoc
class _$InternetConnectionStateCopyWithImpl<$Res>
    implements $InternetConnectionStateCopyWith<$Res> {
  _$InternetConnectionStateCopyWithImpl(this._self, this._then);

  final InternetConnectionState _self;
  final $Res Function(InternetConnectionState) _then;

/// Create a copy of InternetConnectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionType = null,Object? status = null,}) {
  return _then(_self.copyWith(
connectionType: null == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as AppConnectionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppInternetStatus,
  ));
}

}


/// @nodoc


class _InternetConnectionState implements InternetConnectionState {
  const _InternetConnectionState({this.connectionType = AppConnectionType.none, this.status = AppInternetStatus.offline});
  

@override@JsonKey() final  AppConnectionType connectionType;
@override@JsonKey() final  AppInternetStatus status;

/// Create a copy of InternetConnectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InternetConnectionStateCopyWith<_InternetConnectionState> get copyWith => __$InternetConnectionStateCopyWithImpl<_InternetConnectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InternetConnectionState&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,connectionType,status);

@override
String toString() {
  return 'InternetConnectionState(connectionType: $connectionType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$InternetConnectionStateCopyWith<$Res> implements $InternetConnectionStateCopyWith<$Res> {
  factory _$InternetConnectionStateCopyWith(_InternetConnectionState value, $Res Function(_InternetConnectionState) _then) = __$InternetConnectionStateCopyWithImpl;
@override @useResult
$Res call({
 AppConnectionType connectionType, AppInternetStatus status
});




}
/// @nodoc
class __$InternetConnectionStateCopyWithImpl<$Res>
    implements _$InternetConnectionStateCopyWith<$Res> {
  __$InternetConnectionStateCopyWithImpl(this._self, this._then);

  final _InternetConnectionState _self;
  final $Res Function(_InternetConnectionState) _then;

/// Create a copy of InternetConnectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionType = null,Object? status = null,}) {
  return _then(_InternetConnectionState(
connectionType: null == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as AppConnectionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppInternetStatus,
  ));
}


}

// dart format on
