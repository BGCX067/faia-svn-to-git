:- include(pop).
:- dynamic holds/2.

% FAIA
% Ejemplo de Pacman con Planning

%----------------------------------
% OPERADORES
%

/*
preconditions( irDerecha(Pos1,Pos2), [en(Pos1), adyDerecha(Pos1,Pos2)] ).
achieves( irDerecha(Pos1,Pos2), en(Pos2) ).
deletes( irDerecha(Pos1,Pos2), en(Pos1) ).

preconditions( irIzquierda(Pos1,Pos2), [en(Pos1), adyIzquierda(Pos1,Pos2)] ).
achieves( irIzquierda(Pos1,Pos2), en(Pos2) ).
deletes( irIzquierda(Pos1,Pos2), en(Pos1) ).

preconditions( irArriba(Pos1,Pos2), [en(Pos1), adyArriba(Pos1,Pos2)] ).
achieves( irArriba(Pos1,Pos2), en(Pos2) ).
deletes( irArriba(Pos1,Pos2), en(Pos1) ).

preconditions( irAbajo(Pos1,Pos2), [en(Pos1), adyAbajo(Pos1,Pos2)] ).
achieves( irAbajo(Pos1,Pos2), en(Pos2) ).
deletes( irAbajo(Pos1,Pos2), en(Pos1) ).
*/

% avanzar(Pos1,Pos2)
preconditions( avanzar(Pos1,Pos2), [en(Pos1), adyacente(Pos1,Pos2)] ).
%preconditions( avanzar(Pos1,Pos2), [en(Pos1), adyacente(Pos1,Pos2), celdaNoVisitada(Pos2)] ).
achieves( avanzar(Pos1,Pos2), en(Pos2) ).
deletes( avanzar(Pos1,_Pos2), en(Pos1) ).
%deletes( avanzar(Pos1,Pos2), celdaNoVisitada(Pos2) ).

% descubrir(Pos)
preconditions( descubrir(Pos), [en(Pos), desconocido(Pos)] ).
achieves( descubrir(Pos), descubre(Pos) ).
deletes( descubrir(Pos), desconocido(Pos) ).

% comer(Pos)
preconditions( comer(Pos), [en(Pos), comida(Pos)] ).
achieves( comer(Pos), come(Pos) ).
deletes( comer(Pos), comida(Pos) ).

% pelear(Pos)
preconditions( pelear(Pos), [en(Pos), enemigo(Pos)] ).
achieves( pelear(Pos), pelea(Pos) ).
deletes( pelear(Pos), enemigo(Pos) ).


%----------------------------------
% PREDICADOS DEL DOMINIO

primitive( en(_) ).
%primitive( adyDerecha(_,_) ).
%primitive( adyIzquierda(_,_) ).
%primitive( adyAbajo(_,_) ).
%primitive( adyArriba(_,_) ).
primitive( adyacente(_,_) ).
primitive( enemigo(_) ).
primitive( comida(_) ).
primitive( vacio(_) ).
primitive( desconocido(_) ).
primitive( descubre(_) ).
primitive( pelea(_) ).
primitive( come(_) ).
%primitive( celdaNoVisitada(_) ).

%
% tamaño_mundo(N).
%
% Indica qué tamaño tendrá el mundo, que será de N x N.
%

tamaño_mundo(3).


%
% generarPosicion(N).
%
% Da como solución todas las posiciones posibles del mundo.
%

generarPosicion(0).
generarPosicion(N) :-
	generarPosicionAux(N,0).

generarPosicionAux(Sig,Num) :-
	Sig is Num + 1.

generarPosicionAux(Sig,Num) :-
	tamaño_mundo(T),
	Num < (T * T) - 2,
	generarPosicionAux(Sig, Num + 1).


%
% Adyacencia de las celdas
%

holds(adyacente(Pos1, Pos2), init) :-
	adyacenteArriba(Pos1, Pos2).

holds(adyacente(Pos1, Pos2), init) :-
	adyacenteDerecha(Pos1, Pos2).

holds(adyacente(Pos1, Pos2), init) :-
	adyacenteAbajo(Pos1, Pos2).

holds(adyacente(Pos1, Pos2), init) :-
	adyacenteIzquierda(Pos1, Pos2).


% Adyacente por derecha no en borde
adyacenteDerecha(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	M is Pos1 mod T, M =\= T - 1,
	Pos2 is Pos1 + 1.

% Adyacente por derecha en borde
adyacenteDerecha(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	M is Pos1 mod T, M =:= T - 1,
	Pos2 is Pos1 - (T - 1).

% Adyacente por izquierda no en borde
adyacenteIzquierda(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	M is Pos1 mod T, M =\= 0,
	Pos2 is Pos1 - 1.

% Adyacente por izquierda en borde
adyacenteIzquierda(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	M is Pos1 mod T, M =:= 0,
	Pos2 is Pos1 + (T - 1).

% Adyacente por abajo no en borde
adyacenteAbajo(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	Pos1 < T * (T - 1),
	Pos2 is Pos1 + T.

% Adyacente por abajo en borde
adyacenteAbajo(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	Pos1 >= T * (T - 1),
	Pos2 is Pos1 - (T * (T - 1)).

% Adyacente por arriba no en borde
adyacenteArriba(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	Pos1 >= T,
	Pos2 is Pos1 - T.

% Adyacente por arriba en borde
adyacenteArriba(Pos1, Pos2) :-
	generarPosicion(Pos1),
	generarPosicion(Pos2),
	tamaño_mundo(T),
	Pos1 < T,
	Pos2 is Pos1 + (T * (T - 1)).

% Ejemplo de un mundo 4 x 4
%
% 0   1   2   3
% 4   5   6   7
% 8   9   10  11
% 12  13  14  15
%
% Ejemplo de un mundo 3 x 3
%
% 0  1  2
% 3  4  5
% 6  7  8

% ESTADO INICIAL


holds(en(0), init).
holds(vacio(6), init).
holds(comida(1), init).
holds(enemigo(2), init).
holds(enemigo(3), init).
/*
holds(en(0), init).
holds(vacio(0), init).
holds(vacio(1), init).
holds(vacio(2), init).
holds(comida(3), init).
holds(vacio(4), init).
holds(vacio(5), init).
holds(enemigo(6), init).
holds(vacio(7), init).
holds(comida(8), init).
*/


% Si no hay comida ni enemigo ni está vacía la celda, entonces
% es desconocida.

holds(desconocido(Pos), init) :-
	not(holds(enemigo(Pos), init)),
	not(holds(comida(Pos), init)),
	not(holds(vacio(Pos), init)).

holds(celdaNoVisitada(Pos), init) :-
	holds(en(P), init),
	Pos =\= P.

achieves(init,X) :-
	holds(X,init).

%
% armarObjetivo(L)
%
% Devuelve una lista con los objetivos por cumplir
%

armarObjetivos(L) :-
	armarObjetivosAux(L,0).

armarObjetivosAux([come(N)|Xs],N) :-
	tamaño_mundo(T),
	N < T * T,
	holds(comida(N), init),
	M is N + 1,
	armarObjetivosAux(Xs, M).

armarObjetivosAux([pelea(N)|Xs],N) :-
	tamaño_mundo(T),
	N < T * T,
	holds(enemigo(N), init),
	M is N + 1,
	armarObjetivosAux(Xs, M).

armarObjetivosAux([descubre(N)|Xs],N) :-
	tamaño_mundo(T),
	N < T * T,
	holds(desconocido(N), init),
	M is N + 1,
	armarObjetivosAux(Xs, M).

armarObjetivosAux(Xs,N) :-
	holds(vacio(N), init),
	M is N + 1,
	armarObjetivosAux(Xs, M).

armarObjetivosAux([],N) :-
	tamaño_mundo(T),
	N is T * T.

%
% celdaArriba(X,R).
%
% Recibe una posición en X y devuelve la celda que está arriba en R.
%

%celdaArriba(X,R) :-


%
% obtenerAccion(Accion)
%
% Devuelve la acción siguiente a ejecutarse.
%

obtenerAccion(Accion) :-
	resolver(Init,Accion,S).


%
% debug(S)
%
% Es igual que obtenerAccion. Lo uso para debugging.
%

debug([Init,Accion|As]) :-
	resolver(Init,Accion,As).


%
% resolver(S)
%
% Realiza la resolución principal. Es común a debug y obtenerAccion.
%

resolver(Init,Accion,S) :-
	armarObjetivos(Objetivos),
	solve(Objetivos,P,20),
	seq(P,[Init,Accion|S]),!.


%
% ejecutarAccion(X)
%
% X es alguna acción. Ejecuta la acción efectivamente, para que así al
% correr otra vez 'obtenerAccion' se realice el paso siguiente. Quita
% o agrega holds(...)
%

ejecutarAccion(avanzar(Pos1,Pos2)) :-
	retract(holds(en(Pos1),init)),
	assert(holds(en(Pos2),init)).

ejecutarAccion(comer(Pos)) :-
	retract(holds(comida(Pos),init)),
	assert(holds(vacio(Pos),init)).

ejecutarAccion(pelear(Pos)) :-
	retract(holds(enemigo(Pos),init)),
	assert(holds(vacio(Pos),init)).

ejecutarAccion(descubrir(Pos)) :-
	assert(holds(vacio(Pos),init)).

ejecutarAccion(end).

