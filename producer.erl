-module(producer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The sushi-man has been created!",
	Master ! {Pid, message, Msg},

	loop(Table).

loop(Table) ->
	timer:sleep(1000),
	makeSushi(Table),
	loop(Table).

makeSushi(Table) ->
	Sushi = "A",
	Table ! {Sushi, sushiReady}.