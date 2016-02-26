%
%Assignment 2
%Kateryna Chernega
%7246161

treeA(X) :- X = t(73,
		   t(31,
		      t(5,nil,nil),
		      nil),
		   t(101,
		      t(83, nil,
			 t(97,nil,nil)),
		      t(2016,
			nil,nil))).


lca(Key1, Key2, T):-
	search(Key1, Key2, T).

%search for a subroot of keys
search(Key1, Key2, t(nil, Key1, Key2)) :- !.
search(Key1, Key2, t(Root, Left, _)) :-
	Key1 < Root,
	Key2 < Root,
	search(Key1, Key2, Left).
search(Key1, Key2, t(Root, _, Right)) :-
	Key1 > Root,
	Key2 > Root,
	search(Key1, Key2, Right).

%print when found
search(Key1, Key2, t(SubRoot, Left, Right)) :-
	Key1 < SubRoot,
	Key2 > SubRoot,
	write(t(SubRoot, Left, Right)).
