-module(learning_file).
-export([double/1, factorial/1, area/1]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

area({square, Side}) ->
	Side * Side;

area({circle, Radius}) ->
	% almost :-)
	3 * Radius * Radius;

area({retangle, A, B}) ->
	A * B;

area({triangle, A, B, C}) ->
	S = (A + B + C)/2,
	math:sqrt(S*(S-A)*(S-B)*(S-C));

area(Other) ->
	{invalid_object, Other}.

double(X) ->
	times(X, 2).

times(X, N) ->
	X * N.