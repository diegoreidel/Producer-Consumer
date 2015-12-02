-module(consumer).
-export([init/2]).

init(Master, Table) ->
	Pid = self(),
	Msg = "The japanese guy has been created!",
	Master ! {Pid, message, Msg},

	loop(Master, Table, 2000).

loop(Master, Table, Hush) ->
	timer:sleep(Hush),
	getSushi(Master, Table).

getSushi(Master, Table) ->
	Pid = self(),
	Table ! {Pid, starving},

	receive
		{Sushi, ready} ->
			eatSushi(Master, Sushi),
			loop(Master, Table, 2000);
		noSushi ->
			Msg = "I am starting to hate this place. There is no sushi!!",
			Master ! {Pid, message, Msg},
			loop(Master, Table, 5000);
		dead ->
			true
	end.

eatSushi(Master, Sushi) ->
	Pid = self(),
	Sushi ! {Pid, getID},
	receive
		{SushiId, sushi} ->
			Msg = lists:flatten(io_lib:format("I ate sushi ~p and it was great! Thank you.", [SushiId])),
			Sushi ! eaten,
			Master ! {Pid, message, Msg}
	end.