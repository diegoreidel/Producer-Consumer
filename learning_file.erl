-module(learning_file).
-export([double/1, factorial/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

double(X) ->
	times(X, 2).

times(X, N) ->
	X * N.