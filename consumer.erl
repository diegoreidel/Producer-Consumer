-module(consumer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The japanese guy has been created!",
	Master ! {Pid, message, Msg},

	loop(Master, Table).

loop(Master, Table) ->
	timer:sleep(2000),
	getSushi(Master, Table),
	loop(Master, Table).

getSushi(Master, Table) ->
	Pid = self(),
	Table ! {Pid, starving},

	receive
		{Sushi, ready} ->
			eatSushi(Master, Table, Sushi),
			loop(Master, Table);
		dead ->
			true
	end.

eatSushi(Master, Table, Sushi) ->
	Pid = self(),
	Sushi ! {Pid, getID},
	receive
		{SushiId, sushi} ->
			Msg = lists:flatten(io_lib:format("I ate sushi ~p and it was great! Thank you.", [SushiId])),
			Master ! {Pid, message, Msg}
	end.


