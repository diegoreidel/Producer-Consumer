-module(master).
-export([init/0]).

init() ->
	
	Pid 		= self(),
	Table 		= createSushiTable(Pid),
	SushiMen 	= createSushiMen(Pid, Table),
	Client		= createJapanese(Pid, Table),
	loop(Table).

createSushiTable(Pid) ->
	spawn(bufferMemory, init, [Pid]).

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



