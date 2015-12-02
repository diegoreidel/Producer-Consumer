-module(master).
-export([init/0]).

init() ->
	
	Pid 		= self(),
	MaxSushi    = 4,
	Table 		= createSushiTable(Pid, MaxSushi),
	createSushiMen(Pid, Table),
	createJapanese(Pid, Table),
	loop(Table).

createSushiTable(Pid, MaxSushi) ->
	spawn(bufferMemory, init, [Pid, MaxSushi]).

createSushiMen(Pid, Table) ->
	spawn(producer, init, [Pid, Table]).

createJapanese(Pid, Table) ->
	spawn(consumer, init, [Pid, Table]).

loop(Table) ->
	
	receive
		{From, message, Msg} ->
			showMessage(From, [Msg]),
			loop(Table);
		stop ->
			true
	end.

showMessage(From, Msg) ->
	io:format("~p says: ~p~n", [From, Msg]).



