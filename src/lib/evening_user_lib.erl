-module(evening_user_lib).
-compile(export_all).

hash_password(Password, Salt) ->
    mochihex:to_hex(erlang:md5(Salt ++ Password)).

hash_for(Name, Password) ->
    Salt = mochihex:to_hex(erlang:md5(Name)),
    hash_password(Password, Salt).

require_login(Req) ->
    case Req:cookie("user_id") of
        undefined -> {redirect, "/user/login"};
        Id ->
            case boss_db:find(Id) of
                undefined -> {redirect, "/user/login"};
                WardBoss ->
                    case WardBoss:session_identifier() =:= Req:cookie("session_id") of
                        false -> {redirect, "/user/login"};
                        true -> {ok, WardBoss}
                    end
            end
     end.