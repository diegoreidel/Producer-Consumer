-module(bufferMemory).
-export([init/2]).

init(Master, Max) -> 
	
	timer:sleep(1000),
	Pid = self(),
	Msg = "I have been created!",
	Master ! {Pid, message, Msg},
	Table = [],
	loop(Table, Master, Max).

loop(Table, Master, Max) ->
	Pid = self(),

	receive
		{Sushi, sushiReady} ->
			QtdSushi = length(Table),
			if
				Max > QtdSushi ->
					NewTable = lists:append(Table, [Sushi]),
					Msg = "A Sushi was added to the table",
					io:format("Length: ~w~n", [length(NewTable)]),
					Master ! {Pid, message, Msg},
					loop(NewTable, Master, Max);

				QtdSushi >= Max ->
					io:format("List is full: ~w~n", [length(Table)]),
					loop(Table, Master, Max)

			end;

		{Client, starving} ->
			{Sushi, All} = getSushi(Table),
			Client ! {Sushi, ready},
			Msg = "A Sushi was removed from the table",
			Master ! {Pid, message, Msg},

			loop(All, Master, Max);

		stop ->
			true
	end.

getSushi([Head | Tail]) ->
	{Head, Tail}.