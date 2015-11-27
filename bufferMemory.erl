-module(bufferMemory).
-export([init/2]).

init(Master, Max) -> 
	
	Pid = self(),
	Msg = "I have been created!",
	Master ! {Pid, message, Msg},
	Table = [],
	loop(Master, Table, Max).

loop(Master, Table, Max) ->
	Pid = self(),

	receive
		{Producer, Sushi, sushiReady} ->
			QtdSushi = length(Table),
			if
				Max > QtdSushi ->
					addSushi(Master, Table, Max, Sushi, Producer);
				QtdSushi >= Max ->
					%io:format("List is full: ~w~n", [length(Table)]),
					Producer ! full,
					loop(Master, Table, Max)

			end;

		{Client, starving} ->
			QtdSushi = length(Table),
			if
				QtdSushi > 0 ->
					{Sushi, All} = getSushi(Table),
					Client ! {Sushi, ready},
					NewQtdSushi = QtdSushi-1,
					Msg = lists:flatten(io_lib:format("A Sushi was removed from the table. There are ~w now.", [NewQtdSushi])),
					Master ! {Pid, message, Msg},
					loop(Master, All, Max);

				0 >= QtdSushi ->
					%io:format("List is empty: ~w~n", [length(Table)]),
					Client ! noSushi,
					loop(Master, Table, Max)
			end;
			

		stop ->
			true
	end.

getSushi([Head | Tail]) ->
	{Head, Tail}.

addSushi(Master, Table, Max, Sushi, Producer) ->
	Pid = self(),
	QtdSushi = length(Table),
	NewTable = lists:append(Table, [Sushi]),
	NewQtdSushi = QtdSushi+1,
	Msg = lists:flatten(io_lib:format("A Sushi was added to the table! There are ~w now.",[NewQtdSushi])),
	Master ! {Pid, message, Msg},
	checkTable(Master, NewTable, Max, QtdSushi+1, Producer).

checkTable(Master, Table, Max, QtdSushi, Producer) ->
	if
		Max > QtdSushi ->
			Producer ! done;
			
		QtdSushi >= Max ->
			Producer ! full
	end,

	loop(Master, Table, Max).



