-module(evening_user_controller, [Req]).
-compile(export_all).

index('GET', []) ->
		{ok, []}.

login('GET', []) ->
		{ok, [{redirect, Req:header(referrer)}]};

login('POST', []) ->
    Name = Req:post_param("name"),
    case boss_db:find(ward_boss, [{name, Name}], [{limit, 1}]) of
        [WardBoss] ->
            case WardBoss:check_password(Req:post_param("password")) of
                true ->
                    {redirect, proplists:get_value("redirect",
                        Req:post_params(), "/"), WardBoss:login_cookies()};
                false ->
                    {ok, [{error, "Bad name/password combination"}]}
            end;
        [] ->
            {ok, [{error, "No Ward Boss named " ++ Name}]}
    end.

logout('GET', []) ->
		{redirect, "/",
				[ mochiweb_cookies:cookie("user_id", "", [{path, "/"}]),
						mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.