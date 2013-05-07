-module(ward_boss, [Id, Name, PasswordHash]).
-compile(export_all).
-has({voters, many}).

-define(SECRET_STRING, "Not telling secrets!").

session_identifier() ->
		mochihex:to_hex(erlang:md5(?SECRET_STRING ++ Id)).

check_password(Password) ->
    Salt = mochihex:to_hex(erlang:md5(Name)),
    evening_user_lib:hash_password(Password, Salt) =:= PasswordHash.

login_cookies() ->
		[ mochiweb_cookies:cookie("user_id", Id, [{path, "/"}]),
				mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].
