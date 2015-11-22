-module(producer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The sushi-man has been created!",
	Master ! {Pid, message, Msg},

	loop(Table, 0).

loop(Table, SushiId) ->
	timer:sleep(1000),
	makeSushi(Table, SushiId),
	loop(Table, SushiId+1).

makeSushi(Table, SushiId) ->
	Self = self(),
	Sushi = spawn(product, init, [Self, SushiId]),
	Table ! {[Sushi, SushiId], sushiReady}.