:- include(pop).
:- dynamic holds/2.

% FAIA
% Ejemplo de Pacman con Planning

%----------------------------------
% OPERADORES
%

% avanzar(Pos1,Pos2)
preconditions( avanzar(Pos1,Pos2), [en(Pos1), adyacente(Pos1,Pos2), vacio(Pos1)] ).
achieves( avanzar(Pos1,Pos2), en(Pos2) ).
deletes( avanzar(Pos1,Pos2), en(Pos1) ).

% comer(Pos)
preconditions( comer(Pos), [en(Pos), comida(Pos)] ).
achieves( comer(Pos), vacio(Pos) ).
deletes( comer(Pos), comida(Pos) ).

% pelear(Pos)
preconditions( pelear(Pos), [en(Pos), enemigo(Pos)] ).
achieves( pelear(Pos), vacio(Pos) ).
deletes( pelear(Pos), enemigo(Pos) ).


%----------------------------------
% PREDICADOS DEL DOMINIO

primitive( en(_) ).
primitive( adyacente(_,_) ).
primitive( enemigo(_) ).
primitive( comida(_) ).
primitive( vacio(_) ).


% Adyacencia
% 0   1   2   3
% 4   5   6   7
% 8   9   10  11
% 12  13  14  15

holds(adyacente(10,6), init).
holds(adyacente(10,11), init).
holds(adyacente(10,14), init).
holds(adyacente(10,9), init).

holds(adyacente(11,7), init).
holds(adyacente(11,8), init).
holds(adyacente(11,15), init).
holds(adyacente(11,10), init).

holds(adyacente(12,8), init).
holds(adyacente(12,13), init).
holds(adyacente(12,0), init).
holds(adyacente(12,15), init).

holds(adyacente(13,9), init).
holds(adyacente(13,14), init).
holds(adyacente(13,1), init).
holds(adyacente(13,12), init).

holds(adyacente(14,10), init).
holds(adyacente(14,15), init).
holds(adyacente(14,2), init).
holds(adyacente(14,13), init).

holds(adyacente(15,11), init).
holds(adyacente(15,12), init).
holds(adyacente(15,3), init).
holds(adyacente(15,14), init).

holds(adyacente(0,12), init).
holds(adyacente(0,1), init).
holds(adyacente(0,4), init).
holds(adyacente(0,3), init).

holds(adyacente(1,13), init).
holds(adyacente(1,2), init).
holds(adyacente(1,5), init).
holds(adyacente(1,0), init).

holds(adyacente(2,14), init).
holds(adyacente(2,3), init).
holds(adyacente(2,6), init).
holds(adyacente(2,1), init).

% 0   1   2   3
% 4   5   6   7
% 8   9   10  11
% 12  13  14  15

holds(adyacente(3,15), init).
holds(adyacente(3,0), init).
holds(adyacente(3,7), init).
holds(adyacente(3,2), init).

holds(adyacente(4,0), init).
holds(adyacente(4,5), init).
holds(adyacente(4,8), init).
holds(adyacente(4,7), init).

holds(adyacente(5,6), init).
holds(adyacente(5,9), init).
holds(adyacente(5,4), init).
holds(adyacente(5,1), init).

holds(adyacente(6,2), init).
holds(adyacente(6,7), init).
holds(adyacente(6,10), init).
holds(adyacente(6,5), init).

holds(adyacente(7,3), init).
holds(adyacente(7,4), init).
holds(adyacente(7,11), init).
holds(adyacente(7,6), init).

holds(adyacente(8,4), init).
holds(adyacente(8,9), init).
holds(adyacente(8,12), init).
holds(adyacente(8,11), init).

holds(adyacente(9,5), init).
holds(adyacente(9,10), init).
holds(adyacente(9,13), init).
holds(adyacente(9,8), init).

% ESTADO INICIAL
% 0   1   2   3
% 4   5   6   7
% 8   9   10  11
% 12  13  14  15

holds(vacio(0), init).
holds(enemigo(1), init).
holds(vacio(2), init).
holds(enemigo(3), init).
holds(comida(4), init).
holds(vacio(5), init).
holds(vacio(6), init).
holds(vacio(7), init).
holds(vacio(8), init).
holds(vacio(9), init).
holds(vacio(10), init).
holds(vacio(11), init).
holds(enemigo(12), init).
holds(vacio(13), init).
holds(vacio(14), init).
holds(vacio(15), init).
holds(en(0), init).

% Si no hay comida ni enemigo en la celda, entonces
% está vacía.

%holds(desconocido(Pos), init) :-
%	not(holds(enemigo(Pos), init)),
%	not(holds(comida(Pos), init)),
%	not(holds(vacio(Pos), init)).

achieves(init,X) :-
	holds(X,init).

%
% obtenerAccion(Accion)
%
% Devuelve la acción siguiente a ejecutarse.
%

obtenerAccion(Accion) :-
	solve([vacio(0),vacio(1),vacio(2),vacio(3),
		   vacio(4),vacio(5),vacio(6),vacio(7),
		   vacio(8),vacio(9),vacio(10),vacio(11),
		   vacio(12),vacio(13),vacio(14),vacio(15)],P,10),
	seq(P,[Init,Accion|S]),!.


%
% debug(S)
%
% Es igual que obtenerAccion. Lo uso para debugging.
%

debug(S) :-
	solve([vacio(0),vacio(1),vacio(2),vacio(3),
		   vacio(4),vacio(5),vacio(6),vacio(7),
		   vacio(8),vacio(9),vacio(10),vacio(11),
		   vacio(12),vacio(13),vacio(14),vacio(15)],P,10),
	seq(P,S),!,
	write(S).


%
% ejecutarAccion(X)
%
% X es alguna acción. Ejecuta la acción efectivamente, para que así al
% correr otra vez 'obtenerAccion' se realice el paso siguiente. Quita
% o agrega holds(...
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

ejecutarAccion(end).

