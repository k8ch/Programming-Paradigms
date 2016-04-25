%
% QUESTION 1
% Use a single cut in the program such that only one solution for each X is found. 
% For example, if X =a, Y = b is found, the solution X = a, Y = c should be excluded. 
%
p1(X,Y):-p3(X),p2(Y,X).
p2(X,Y):-p3(X),p4(Y),X\=Y,!.
p3(a).
p3(b).
p3(c).
p3(d):-!.
p4(c).
p4(a).
p4(b).

%
% QUESTION 2a
% Create the rule cubeLess(X,B,R) which calculates the power of 3 and the remainder such that b =x3+r. 
% Therefore, for a query cubeLess( 2, 10, R) , the result should be R=2.
% Note, that you will not be able to call the rule without X and B instantiated.
%

cubeLess(X,B,R) :-
	R is (B - X**3).
%
% QUESTION 2b
% Use the rule cubeLess from a) to find all numbers with a cube smaller than a given limit by
% creating a new rule smallerCube(X,B). 
% Print your results to the console with write/1 and writeln/1 .
%
int(0).
int(X) :- int(X1), X is X1+1.

smallerCube(1,B) :-
	cubeLess(1,B,R),
	R  >= 0,
	write(1),
	write(' rest '),
	write(R),
	writeln(''),
	X1 is 2,
	smallerCube(X1, B),!.


smallerCube(X,B) :-
	X**3 < B,
	cubeLess(X,B,R),
	R  >= 0,
	write(X),
	write(' rest '),
	write(R),
	writeln(''),
	X1 is X+1,
	smallerCube(X1, B).

smallerCube(X,B):-
	X**3 > B,!.


%
% QUESTION 2c
% Create another rule restSum(B,S)to add up all the remainders from 
% finding all cubes up to an upper limit. 
%
findX(X,S,B):-
	(X+1)**3 > B,
	cubeLess(X,B,R),
	S is R,!.

findX(X,S,B) :-
       X1 is X+1,
       findX(X1, Snext, B),!,
       cubeLess(X,B,R),
       S is R + Snext.


restSum(B,S):-
	findX(1, S, B).

%
% QUESTION 2d
% Write another rule to print all the rest sums that are multiples of 3 within a range
%
isMultiple(X):-
	0 =:= X mod 3.

showAllRestSum(First,Last) :-
	First < Last,
       restSum(First, S),
       not(isMultiple(S)),
       F1 is First + 1,
       showAllRestSum(F1, Last).

showAllRestSum(First,First).
showAllRestSum(First,Last) :-
       First < Last,
       restSum(First, S),
       isMultiple(S),
       writeln(""),
       write(First),
       write(' rest '),
       write(S),
       writeln(""),
       F1 is First + 1,
       showAllRestSum(F1, Last).

%
% QUESTION 3a
% Create a Prolog database representing the items that the outfitter sells. 
%

tent(dreamer, 2, 4.5, 199).
tent(hermite, 1, 2, 159).
tent(family, 5, 5, 349).
tent(expedition, 8, 8.5, 699).

bag(mountain, -15, mummy, 1.5, 350).
bag(cabin, 5, double-bag, 5, 250).
bag(square, -3, rectangular, 2.5, 150).

pad(rock, 2, 0.2, 100).
pad(pfft, 3, 0.8, 10).
pad(heaven, 10, 0.4, 80).
pad(moon, 5, 0.4, 50).

backpack(trapper, 20, 250).
backpack(prospector, 25, 220).
backpack(air, 10, 150).
backpack(comfort, 15, 200).

%
% QUESTION 3b
% Paul is going camping for the first time and needs to buy a tent, sleeping bag and pad as well as
% back pack. Write a query for Paul who likes a sleeping bag good down to at least 0 deg. Celcius,
% and a sleeping pad of 5cm or more. Make sure to also calculate the total price of the package.
%
totalPrice(P1, P2, T):-
	T is P1 + P2.

paul(B,P,T) :-
	bag(_, B, _, _, P1),
	pad(_, P, _, P2),
	B =< 0,
	P >= 5,
	totalPrice(P1, P2, T).
%
% QUESTION 3c
% The travel company Cheap Thrills is offering a trip for 4. Mary, Sean, Paula and Thomas are
% signed up. Create a predicate for Cheap Thrills to find equipment for their four customers. Mary
% does not want to share a tent with Sean. Paula and Thomas would like to share a sleeping bag but
% still need a sleeping pad. They want it all to fit in two back packs and the customers are allowed
% to bring personal belongings of 7 kg each. 
% 
tripFor4(E, mary(MB, MP),
	 sean(SB, SP),
	 paula(PTB, PP),
	 thomas(PTB, TP),
	 tents(T1, T2),
	 backpacks(B1, B2)):- bag(MB, _, _, NBW, _),
	                      bag(SB, _, _, SBW, _),
			      MB \= SB,
			      bag(PTB, _, _, PTBW, _),
	                      pad(MP, _, MPW, _),
	                      pad(SP, _, SPW, _),
			      pad(PP, _, PPW, _),
			      pad(TP, _, TPW, _),
			      tent(T1, _, T1W, _),
			      tent(T2, _, T2W, _),
			      T1 \= T2,
			      backpack(_, B1, _),
			      backpack(_, B2, _),
			      TW is NBW + SBW + PTBW + MPW + SPW + PPW + TPW + T1W + T2W,
			      B1 + B2 >= TW + E*4.


%
% QUESTION 3d
% Jill and Kyle are buying equipment for their camping trip. They will each bring 5 kg of personal
% belongings. They like the Dreamer tent for sure, want to use only one back pack and they can
% spent up to $750 in total. Write the rule equipment2, that will produce all solutions for them
%
equipment2(E, jill(JillBag,JillPad),kyle(KyleBag,KylePad), tents(dreamer), backpacks(BagPack),AvailablePrice):-
	bag(JillBag, _, _, JillBagWeight, JillBagPrice),
	bag(KyleBag, _, _, KyleBagWeight, KyleBagPrice),
	pad(JillPad, _, JillPadWeight, JillPadPrice),
	pad(KylePad, _, KylePadWeight, KylePadPrice),
	tent(dreamer, _, TentWeight, TentPrice),
	backpack(BagPack, BagWeight, BagPrice),
	BagWeight >= JillBagWeight + KyleBagWeight + JillPadWeight + KylePadWeight + TentWeight + E*2,
	T is JillBagPrice + KyleBagPrice + JillPadPrice + KylePadPrice + TentPrice + BagPrice,
	T =< AvailablePrice.

%
% QUESTION 3e
% Cheap Thrills wants to offer a comfort trip for which their guide carries the tents and a Heaven
% sleeping pad for all customers. The predicate needs to return true if the number of people N can
% be served with one guide (i.e., the guide must carry in her/his backpack all tents and sleeping
% pads). Take into account that the guide also has to carry his/her personal belongings of 5 kg, a
% sleeping bag and a pad. 
%
comfort(E, guide(GB, GP), backpacks(GBP), N):-
	bag(_, _, _, GB, _),
	pad(_, _, GP, _),
	backpack(_, GBP, _),
	tent(_, _, TW, _),
	W is E + TW*N + N * 0.4 + GB + GP,
	GBP >= W,
	write("True."),!.

