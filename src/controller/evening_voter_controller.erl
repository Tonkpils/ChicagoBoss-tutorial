-module(evening_voter_controller, [Req]).
-compile(export_all).

before_(_) ->
    evening_user_lib:require_login(Req).

list('GET', [], WardBoss) ->
		{ok, [{ward_boss, WardBoss}]}.

view('GET', [VoterId], WardBoss) ->
		Voter = boss_db:find(VoterId),
		{ok, [{voter, Voter}]}.

register('GET', [], WardBoss) ->
		{ok, []};
register('POST', [], WardBoss) ->
		Voter = voter:new(id, Req:post_param("first_name"), Req:post_param("last_name"),
				Req:post_param("address"), Req:post_param("notes"), WardBoss:id()),
		case Voter:save() of
				{ok, SavedVoter} ->
						{redirect, "/voter/view/"++SavedVoter:id()};
				{error, Errors} ->
						{ok, [{error, Errors}, {voter, Voter}]}
		end.

