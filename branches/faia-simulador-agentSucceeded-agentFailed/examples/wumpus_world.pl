:- dynamic actualSituation/1, bump/2, glitter/2, wumpusKilled/1, action/2, stench/2, breeze/2, perception/2, at/3, position/2, orientation/2, holding/2.

maxCell(S) :- S is 3.

rows(R) :- R is 0.
rows(R) :- R is 1.
rows(R) :- R is 2.
rows(R) :- R is 3.

cols(R) :- R is 0.
cols(R) :- R is 1.
cols(R) :- R is 2.
cols(R) :- R is 3.

add(P,X,P1):-P1 is P+X.

adjacent2(down,[R,C],[R1,C]) :- rows(R),maxCell(Mx),R<Mx,add(R,1,R1).
adjacent2(up,[R,C],[R1,C]) :- rows(R),R>0,add(R,-1,R1).
adjacent2(left,[R,C],[R,C1]) :- cols(C),C>0,add(C,-1,C1).
adjacent2(right,[R,C],[R,C1]) :- cols(C),maxCell(Mx),C<Mx,add(C,1,C1).

adjacent([X,Y],[X1,Y1]) :- adjacent2(down,[X,Y],[X1,Y1]).
adjacent([X,Y],[X1,Y1]) :- adjacent2(up,[X,Y],[X1,Y1]).
adjacent([X,Y],[X1,Y1]) :- adjacent2(left,[X,Y],[X1,Y1]).
adjacent([X,Y],[X1,Y1]) :- adjacent2(right,[X,Y],[X1,Y1]).

moveRight(up,right).
moveRight(right,down).
moveRight(down,left).
moveRight(left,up).

moveLeft(right,up).
moveLeft(down,right).
moveLeft(left,down).
moveLeft(up,left).

count(Template, Query, Count) :-
	setof(Template, Query, Set),
	length(Set, Count).

count(Query, Count) :-
	count(Query, Query, Count).

% Situation must be initialized to 0.
actualSituation(0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Diagnostic rules                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stench(P,S) :-
	perception([stench,_,_,_,_]),
	position(P,S).

breeze(P,S) :-
	perception([_,breeze,_,_,_]),
	position(P,S).

glitter(P,S) :-
	perception([_,_,glitter,_,_]),
	position(P,S).

bump(S) :-
	perception([_,_,_,bump,_]).

wumpusKilled(S) :-
	perception([_,_,_,_,wumpusScream]).

at(nothing,P,S) :-
	perception([nothing,nothing,nothing,nothing,nothing]),
	position(P,S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Causal rules                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% holding(O,S) : where O is an object holded by the agent, and S is a
% situation.

% action(A,S) : where A is an action taken by the agent at situation S.

% at(O,P,S) : where O is an object, P is a location, and S is a situation.

% belief(O,P,S) : where O is an object that the agent *believes* is at location
% P in situaion S.

safe(P,S) :-
	at(nothing,P,S).

safe(Pa,S) :-
	at(nothing,P,S),
	adjacent(P,Pa),
	not(at(wall,Pa,S)).

unknown([R,C],S) :-
	R < 4, C < 4,
	not(stench([R,C],S)),
	not(breeze([R,C],S)),
	not(glitter([R,C],S)),
	not(at(Sm,[R,C],S)).

belief(wumpus,Pa,S) :-
	stench(P,S),
	adjacent(P,Pa),
	not(safe(Pa,S)).
%	count((adjacent(Pa,Pb),(unknown(Pb);stench(Pb))),4).

%at(wumpus,P) :-
%	belief(wumpus,P),
%	count((belief(wumpus,P)),1).

%stench(P) :- at(wumpus,P).
%stench(Pa) :- at(wumpus,P),adjacent(P,Pa).

belief(pit,Pa,S) :-
	breeze(P,S),
	adjacent(P,Pa),
	not(safe(Pa,S)).
%	count((adjacent(Pa,Pb),(unknown(Pb);breeze(Pb))),4).

%at(pit,P) :-
%	belief(pit,P),
%	count((belief(pit,P)),1).

at(wall,Pa,S) :-
	bump(S),
	position(P,S),
	orientation(O,S),
	adjacent2(O,P,Pa).

existUnknownCell(S) :-
	rows(R),cols(C),
	unknown([R,C],S),!.

% present: O is an object present in the current room, and S is a situation.
%present(O,S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Successor-State Axioms                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% When position doesn't change.
est(S1):- S1 > 0,S is S1-1,action(A,S),A\=forward,position(P,S),asserta(position(P,S1)).
est(S1):- S1 > 0,S is S1-1,action(forward,S),position(P,S),orientation(O,S),not(adjacent2(O,P,_)),asserta(position(P,S1)).

% When orientation doesn't change.
est(S1):- S1 > 0,S is S1-1,action(A,S),A\=turnright,A\=turnleft,orientation(O,S),asserta(orientation(O,S1)).

% Position or orientation change.
est(S1):- S1 > 0,S is S1-1,action(forward,S),orientation(O,S),position(P,S),adjacent2(O,P,Pa),asserta(position(Pa,S1)).
est(S1):- S1 > 0,S is S1-1,action(turnright,S),orientation(O,S),moveRight(O,O1),asserta(orientation(O1,S1)).
est(S1):- S1 > 0,S is S1-1,action(turnleft,S),orientation(O,S),moveLeft(O,O1),asserta(orientation(O1,S1)).

est(S1):- S1 > 0,S is S1-1,stench(P,S),asserta(stench(P,S1)).
est(S1):- S1 > 0,S is S1-1,breeze(P,S),asserta(breeze(P,S1)).
est(S1):- S1 > 0,S is S1-1,glitter(P,S),asserta(glitter(P,S1)).
est(S1):- S1 > 0,S is S1-1,bump(P,S),asserta(bump(P,S1)).
est(S1):- S1 > 0,S is S1-1,wumpusKilled(S),asserta(wumpusKilled(S1)).
est(S1):- S1 > 0,S is S1-1,at(nothing,P,S),asserta(at(nothing,P,S1)).

est(S1):- S1 > 0,S is S1-1,action(grab,S),asserta(holding(gold,S1)).
est(S1):- S1 > 0,S is S1-1,action(A,S),holding(gold,S),A\=release,asserta(holding(gold,S1)).

est(S1):- S1 > 0,S is S1-1,action(A,S),A\=shoot,asserta(holding(arrow,S1)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Actions                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

excelent(grab,S) :- position(P,S),glitter(P,S).
excelent(shoot,S) :- holding(arrow,S),orientation(O,S),position(P,S),adjacent2(O,P,Pa),at(wumpus,Pa,S).

veryGood(forward,S) :- orientation(O,S),position(P,S),adjacent2(O,P,Pa),safe(Pa,S),unknown(Pa,S).
veryGood(turnright,S) :- orientation(O,S),position(P,S),moveRight(O,O1),adjacent2(O1,P,Pa),safe(Pa,S),unknown(Pa,S).
veryGood(turnleft,S) :- orientation(O,S),position(P,S),moveLeft(O,O1),adjacent2(O1,P,Pa),safe(Pa,S),unknown(Pa,S).

good(forward,S) :- orientation(O,S),position(P,S),adjacent2(O,P,Pa),safe(Pa,S),adjacent(Pa,Ps),unknown(Ps,S).
good(turnright,S) :- position(P,S),adjacent(P,Pa),safe(Pa,S),adjacent(Pa,Ps),unknown(Ps,S).

notSoGood(forward,S) :- orientation(O,S),position(P,S),adjacent2(O,P,Pa),unknown(Pa,S).
notSoGood(turnright,S) :- position(P,S),adjacent(P,Pa),unknown(Pa,S).

bad(forward,S) :- orientation(O,S),position(P,S),adjacent2(O,P,Pa),belief(wumpus,Pa,S).
bad(forward,S) :- orientation(O,S),position(P,S),adjacent2(O,P,Pa),belief(pit,Pa,S).

% bestAction:
bestAction(noAction,S) :- holding(gold,S).
bestAction(A,S) :- excelent(A,S).
bestAction(A,S) :- veryGood(A,S).
bestAction(A,S) :- good(A,S).
bestAction(A,S) :- notSoGood(A,S).
bestAction(A,S) :- bad(A,S).

