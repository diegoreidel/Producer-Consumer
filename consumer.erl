-module(consumer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The japanese guy has been created!",
	Master ! {Pid, message, Msg},

	loop(Table).

loop(Table) ->
	timer:sleep(2000),
	eatSushi(Table),
	loop(Table).

eatSushi(Table) ->
	Pid = self(),
	Table ! {Pid, starving},

	receive
		{Sushi, ready} ->
			io:fwrite("Thanks for the great sushi ~n")
	end.