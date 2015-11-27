-module(producer).
-export([init/2]).

init(Master, Table) ->
	timer:sleep(1000),
	Pid = self(),
	Msg = "The sushi-man has been created!",
	Master ! {Pid, message, Msg},

	loop(Table, 1, 1000).

loop(Table, SushiId, Hush) ->
	timer:sleep(Hush),
	makeSushi(Table, SushiId),
	loop(Table, SushiId+1, Hushi).

makeSushi(Table, SushiId) ->
	Self = self(),
	Sushi = spawn(product, init, [Self, SushiId]),
	Table ! {Sushi, sushiReady}.