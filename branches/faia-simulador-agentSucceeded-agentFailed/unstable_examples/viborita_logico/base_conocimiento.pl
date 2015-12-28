:- dynamic percepcion/2,executedAction/2,composicionDelAgente/2,vacia/3,comida/3,pared/2,existenParedes/1.

%% INICIO FUNCIONES AUXILIARES %%
% Inicio funciones genéricas
% Inicio funciones que no dependen de otras funciones
primerElem([X|_Y],X).

pertenece(X,[X|_Y]).
pertenece(X,[_C|Y]):-pertenece(X,Y).

cantidad([],0):-!.
cantidad([_|Ls],C):-cantidad(Ls,T),C is T+1.

concatenar([],L,L):-!.
concatenar([X|M],L,[X|Y]):-concatenar(M,L,Y).

max([], MaxSoFar, MaxSoFar).
max([Number|Rest], MaxSoFar, Max):-Number > MaxSoFar,max(Rest, Number, Max).
max([Number|Rest], MaxSoFar, Max):-Number =< MaxSoFar,max(Rest, MaxSoFar, Max).

lista([]):-!.
lista([_X|Y]):-lista(Y).

maximo(X, Y, MAX) :- X > Y, !, MAX is X.
maximo(_, Y, MAX) :- MAX is Y.

auxiliarMayor([],Temp,Resultado):-Resultado is Temp.
auxiliarMayor([(X,Y)|Resto],Temp,Resultado):-maximo(X,Y,MAX),maximo(MAX,Temp,R),auxiliarMayor(Resto,R,Resultado).

mayorValorDeLaLista([],0).
mayorValorDeLaLista([(X,Y)|Resto],Resultado):-maximo(X,Y,MAX),Temp is MAX,auxiliarMayor(Resto,Temp,Resultado).

sacaNpri([],_N,[]):-!.
sacaNpri([_X|M],1,M):-!.
sacaNpri([_X|M],N,S):-N1 is N - 1,sacaNpri(M,N1,S).

eliminaX([],_X,[]):-!.
eliminaX([X|M],X,Z):- eliminaX(M,X,Z),!.
eliminaX([R|M],X,[R|Z]):- eliminaX(M,X,Z),!.
% Fin funciones que no dependen de otras funciones

elim12([],L,L):-!.
elim12([X|M],L,S):-eliminaMx(L,X,T),elim12(M,T,S).

eliminaR([],[]):-!.
eliminaR([X|M],S):-not(lista(X)),eliminaX(M,X,T),eliminaR(T,Y),concatenar([X],Y,S).
eliminaR([X|M],S):-lista(X),elim12(X,M,T),eliminaR(X,Y),
  eliminaR(T,J),concatenar([Y],J,S).

invertir([],[]):-!.
invertir([X],[X]):-!.
invertir([X|M],L):-invertir(M,S),concatenar(S,[X],L).

ultimoElem(L,S):-invertir(L,T),primerElem(T,S).

sacaNult(L,N,R):-invertir(L,L1),sacaNpri(L1,N,R1),invertir(R1,R).

crearParedesEste(N,0):-!.
crearParedesEste(N,Cuenta):-not(pared(Cuenta,N)),asserta(pared(Cuenta,N)),Cuenta2 is Cuenta-1,crearParedesEste(N,Cuenta2).
crearParedesEste(N,Cuenta):-Cuenta2 is Cuenta-1,crearParedesEste(N,Cuenta2).

crearParedesSur(N,0):-!.
crearParedesSur(N,Cuenta):-not(pared(N,Cuenta)),asserta(pared(N,Cuenta)),Cuenta2 is Cuenta-1,crearParedesSur(N,Cuenta2).
crearParedesSur(N,Cuenta):-Cuenta2 is Cuenta-1,crearParedesSur(N,Cuenta2).
% Fin funciones genéricas

% Inicio funciones propias del problema
sumarPosicion(P,O,P1):-O=:=(-1),P1 is P-1,!.
sumarPosicion(P,O,P1):-O=:=1,P1 is P+1,!.

adyacenteCelda(X,Y,X1,Y):-sumarPosicion(X,-1,X1).
adyacenteCelda(X,Y,X1,Y):-sumarPosicion(X,1,X1).
adyacenteCelda(X,Y,X,Y1):-sumarPosicion(Y,-1,Y1).
adyacenteCelda(X,Y,X,Y1):-sumarPosicion(Y,1,Y1).

adyacenteCelda(X,Y,X1,Y,arriba):-sumarPosicion(X,-1,X1).
adyacenteCelda(X,Y,X1,Y,abajo):-sumarPosicion(X,1,X1).
adyacenteCelda(X,Y,X,Y1,izquierda):-sumarPosicion(Y,-1,Y1).
adyacenteCelda(X,Y,X,Y1,derecha):-sumarPosicion(Y,1,Y1).

adyacente(X1,Y,arriba,S):-composicionDelAgente([(X,Y,_)|_],S),sumarPosicion(X,-1,X1).
adyacente(X1,Y,abajo,S):-composicionDelAgente([(X,Y,_)|_],S),sumarPosicion(X,1,X1).
adyacente(X,Y1,izquierda,S):-composicionDelAgente([(X,Y,_)|_],S),sumarPosicion(Y,-1,Y1).
adyacente(X,Y1,derecha,S):-composicionDelAgente([(X,Y,_)|_],S),sumarPosicion(Y,1,Y1).

agregarCabeza(C,X,[X|C]).

agregarCola(C,X,R):-invertir(C,R1),agregarCabeza(R1,X,R2),invertir(R2,R).

quitarCola(C,R):-sacaNult(C,1,R).

avanzarCabeza(X,Y,norte,X1,Y):-sumarPosicion(X,-1,X1).
avanzarCabeza(X,Y,sur,X1,Y):-sumarPosicion(X,1,X1).
avanzarCabeza(X,Y,oeste,X,Y1):-sumarPosicion(Y,-1,Y1).
avanzarCabeza(X,Y,este,X,Y1):-sumarPosicion(Y,1,Y1).

girarCabeza(norte,oeste,izquierda).
girarCabeza(oeste,sur,izquierda).
girarCabeza(sur,este,izquierda).
girarCabeza(este,norte,izquierda).

girarCabeza(norte,este,derecha).
girarCabeza(este,sur,derecha).
girarCabeza(sur,oeste,derecha).
girarCabeza(oeste,norte,derecha).

nuevaCola(X,Y,norte,X1,Y):-sumarPosicion(X,1,X1).
nuevaCola(X,Y,sur,X1,Y):-sumarPosicion(X,-1,X1).
nuevaCola(X,Y,oeste,X,Y1):-sumarPosicion(Y,1,Y1).
nuevaCola(X,Y,este,X,Y1):-sumarPosicion(Y,-1,Y1).

% dxo= dirección por orientación o viceversa.
dxo(arriba,norte).
dxo(abajo,sur).
dxo(izquierda,oeste).
dxo(derecha,este).

quitarXYCero([],[]):-!.
quitarXYCero([(X,Y)|T],R):-X=:=0,quitarXYCero(T,R),!.
quitarXYCero([(X,Y)|T],R):-Y=:=0,quitarXYCero(T,R),!.
quitarXYCero([(X,Y)|T],[(X,Y)|R]):-quitarXYCero(T,R),!.

paredes(P):-findall((X,Y),pared(X,Y),L1),eliminaX(L1,(0,_),L2),eliminaX(L2,(_,0),P1),quitarXYCero(P1,P).

limiteDelMundo(N):-paredes(P),mayorValorDeLaLista(P,N).

tableroVacio(S):-limiteDelMundo(N),Vacios is N-1,VaciosTotal is Vacios*Vacios,
	findall((X,Y,S),vacia(X,Y,S),V),eliminaR(V,V1),cantidad(V1,CuentaVacios),CuentaVacios=:=VaciosTotal.

inferirDelOlor(S):-adyacente(Xn,Yn,arriba,S),not(pared(Xn,Yn)),not(vacia(Xn,Yn,S)),not(comida(Xn,Yn,S)),asserta(comida(Xn,Yn,S)).
inferirDelOlor(S):-adyacente(Xs,Ys,abajo,S),not(pared(Xs,Ys)),not(vacia(Xs,Ys,S)),not(comida(Xs,Ys,S)),asserta(comida(Xs,Ys,S)).
inferirDelOlor(S):-adyacente(Xo,Yo,izquierda,S),not(pared(Xo,Yo)),not(vacia(Xo,Yo,S)),not(comida(Xo,Yo,S)),asserta(comida(Xo,Yo,S)).
inferirDelOlor(S):-adyacente(Xe,Ye,derecha,S),not(pared(Xe,Ye)),not(vacia(Xe,Ye,S)),not(comida(Xe,Ye,S)),asserta(comida(Xe,Ye,S)).
% Fin funciones propias del problema
%% FIN FUNCIONES AUXILIARES %%

%% INICIO PERCEPCIONES %%
%% [hayParedEnFrente,hayOlor,hayComida,x,y,orientacion]

composicionDelAgente([(X,Y,O)],1):-percepcion([_,_,_,X,Y,O],1).

pared(0,_).
pared(_,0).

pared(X,Y):-percepcion([pared,_,_,_,_,norte],S),adyacente(X,Y,arriba,S),!.
pared(X,Y):-percepcion([pared,_,_,_,_,sur],S),adyacente(X,Y,abajo,S),!.
pared(X,Y):-percepcion([pared,_,_,_,_,oeste],S),adyacente(X,Y,izquierda,S),!.
pared(X,Y):-percepcion([pared,_,_,_,_,este],S),adyacente(X,Y,derecha,S),!.

comida(X,Y,S):-percepcion([_,_,comida,_,_,_],S),composicionDelAgente([(X,Y,_)|_],S).

vacia(X,Y,S):-percepcion([_,olor,_,_,_,_],S),composicionDelAgente([(X,Y,_)|_],S),inferirDelOlor(S).

vacia(X,Y,S):-percepcion([nada,nada,nada,_,_,_],S),composicionDelAgente([(X,Y,_)|_],S).
%% FIN PERCEPCIONES %%

%% INICIO REGLAS CAUSALES %%
conoce(X,Y,S):-vacia(X,Y,S),!.
conoce(X,Y,S):-comida(X,Y,S),!.
conoce(X,Y,_):-pared(X,Y),!.

seMuereSiCome(X,Y,norte):-sumarPosicion(X,1,X1),pared(X1,Y).
seMuereSiCome(X,Y,sur):-sumarPosicion(X,-1,X1),pared(X1,Y).
seMuereSiCome(X,Y,oeste):-sumarPosicion(Y,1,Y1),pared(X,Y1).
seMuereSiCome(X,Y,este):-sumarPosicion(Y,-1,Y1),pared(X,Y1).

parteDelAgenteEnFrenteAuxiliar(C,X,Y,norte):-sumarPosicion(X,-1,X1),pertenece((X1,Y,_),C).
parteDelAgenteEnFrenteAuxiliar(C,X,Y,sur):-sumarPosicion(X,1,X1),pertenece((X1,Y,_),C).
parteDelAgenteEnFrenteAuxiliar(C,X,Y,oeste):-sumarPosicion(Y,-1,Y1),pertenece((X,Y1,_),C).
parteDelAgenteEnFrenteAuxiliar(C,X,Y,este):-sumarPosicion(Y,1,Y1),pertenece((X,Y1,_),C).

parteDelAgenteEnFrente(S):-composicionDelAgente(C,S),!,primerElem(C,(X,Y,O)),parteDelAgenteEnFrenteAuxiliar(C,X,Y,O).

paredEnFrenteAuxiliar(X,Y,norte):-sumarPosicion(X,-1,X1),pared(X1,Y).
paredEnFrenteAuxiliar(X,Y,sur):-sumarPosicion(X,1,X1),pared(X1,Y).
paredEnFrenteAuxiliar(X,Y,oeste):-sumarPosicion(Y,-1,Y1),pared(X,Y1).
paredEnFrenteAuxiliar(X,Y,este):-sumarPosicion(Y,1,Y1),pared(X,Y1).

paredEnFrente(S):-composicionDelAgente([(X,Y,O)|_],S),paredEnFrenteAuxiliar(X,Y,O).

caminoADescubrir(O,S):-dxo(D,O),adyacente(X,Y,D,S),adyacenteCelda(X,Y,X2,Y2,D),not(conoce(X2,Y2,S)).
caminoAComida(O,S):-dxo(D,O),adyacente(X,Y,D,S),adyacenteCelda(X,Y,X2,Y2,D),comida(X2,Y2,S).

mundoTieneLimites(_):-limiteDelMundo(N),N>0,not(existenParedes(si)),crearParedesEste(N,N),crearParedesSur(N,N),asserta(existenParedes(si)),!.
%mundoTieneLimites(_):-limiteDelMundo(N),N>0,crearParedesEste(N,N),crearParedesSur(N,N),!.
mundoTieneLimites(_):-limiteDelMundo(N),N>0,!.

%% FIN REGLAS CAUSALES %%

%% INICIO AXIOMAS DE ESTADO SUCESOR %%
% si giro a la izquierda, como se modifica la comp. del agente? se cambia la orientación de la cabeza hacia la izquierda en 90 grados.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(girarIzquierda,S),composicionDelAgente([(X,Y,O)|R],S),
	girarCabeza(O,O1,izquierda),agregarCabeza(R,(X,Y,O1),C),
	asserta(composicionDelAgente(C,S1)).

% si giro a la derecha, como se modifica la comp. del agente? se cambia la orientación de la cabeza hacia la derecha en 90 grados.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(girarDerecha,S),composicionDelAgente([(X,Y,O)|R],S),
	girarCabeza(O,O1,derecha),agregarCabeza(R,(X,Y,O1),C),
	asserta(composicionDelAgente(C,S1)).

% si avanzo, cómo se modifica la comp. del agente? se quita la cola y se inserta la nueva cabeza.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(avanzar,S),composicionDelAgente(C,S),
	primerElem(C,(X,Y,O)),quitarCola(C,C1),avanzarCabeza(X,Y,O,X1,Y1),agregarCabeza(C1,(X1,Y1,O),C2),
	asserta(composicionDelAgente(C2,S1)).

% si como, cómo se modifica la comp. del agente? se agrega la nueva cola.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(comer,S),comida(X,Y,S),composicionDelAgente(C,S),primerElem(C,(X,Y,_)),
	ultimoElem(C,(X1,Y1,O)),nuevaCola(X1,Y1,O,X2,Y2),agregarCola(C,(X2,Y2,O),C1),
	asserta(composicionDelAgente(C1,S1)).

% si una celda estaba vacia? continua vacia.
est(S1):- S1 > 1,S is S1-1,vacia(X,Y,S),not(vacia(X,Y,S1)),asserta(vacia(X,Y,S1)).

% si una celda tenía comida y la comi? se vacía.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(comer,S),composicionDelAgente([(X,Y,_)|_],S),asserta(vacia(X,Y,S1)).

% si avance en una celda que tenía comida y no la comi? continua con comida.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(avanzar,S),composicionDelAgente([(X,Y,_)|_],S),comida(X,Y,S),asserta(comida(X,Y,S1)).

% si gire a la izquierda en una celda que tenía comida y no la comi? continua con comida.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(girarIzquierda,S),composicionDelAgente([(X,Y,_)|_],S),comida(X,Y,S),asserta(comida(X,Y,S1)).

% si gire a la derecha en una celda que tenía comida y no la comi? continua con comida.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(girarDerecha,S),composicionDelAgente([(X,Y,_)|_],S),comida(X,Y,S),asserta(comida(X,Y,S1)).

% si avanzo, la celda queda vacia si no hay comida, obvio.
est(S1):- S1 > 1,S is S1-1,accionEjecutada(avanzar,S),composicionDelAgente([(X,Y,_)|_],S),
	not(comida(X,Y,S1)),not(vacia(X,Y,S1)),
	asserta(vacia(X,Y,S1)).
%% FIN AXIOMAS DE ESTADO SUCESOR %%

%% INICIO VALORACION DE LAS ACCIONES %%
excelente(comer,S):-composicionDelAgente(C,S),!,primerElem(C,(X,Y,_)),comida(X,Y,S),ultimoElem(C,(X1,Y1,O)),not(seMuereSiCome(X1,Y1,O)).

muy_bueno(avanzar,S):-not(parteDelAgenteEnFrente(S)),not(paredEnFrente(S)),composicionDelAgente([(_,_,O)|_],S),caminoAComida(O,S).

muy_bueno(girarIzquierda,S):-composicionDelAgente([(_,_,O)|_],S),girarCabeza(O,O1,izquierda),caminoAComida(O1,S).
%muy_bueno(girarDerecha,S):-composicionDelAgente([(_,_,O)|_],S),girarCabeza(O,O1,derecha),caminoAComida(O1,S).

muy_bueno(avanzar,S):-not(parteDelAgenteEnFrente(S)),not(paredEnFrente(S)),composicionDelAgente([(_,_,O)|_],S),caminoADescubrir(O,S).

muy_bueno(girarDerecha,S):-composicionDelAgente([(_,_,O)|_],S),girarCabeza(O,O1,derecha),caminoADescubrir(O1,S).

bueno(avanzar,S):-not(parteDelAgenteEnFrente(S)),not(paredEnFrente(S)).
% hago esa distincion para que sea más aleatorio el comportamiento.
bueno(girarIzquierda,S):-parteDelAgenteEnFrente(S).
bueno(girarDerecha,S):-paredEnFrente(S).

% acá ya el agente muere..
malo(comer,S):-composicionDelAgente(C,S),primerElem(C,(X,Y,_)),comida(X,Y,S),ultimoElem(C,(X1,Y1,O)),seMuereSiCome(X1,Y1,O).

muy_malo(avanzar,S):-parteDelAgenteEnFrente(S),!.
muy_malo(avanzar,S):-paredEnFrente(S),!.

mejorAccion(X,S):-excelente(X,S),!.
mejorAccion(X,S):-muy_bueno(X,S),!.
mejorAccion(X,S):-bueno(X,S),!.
mejorAccion(X,S):-malo(X,S),!.
mejorAccion(X,S):-muy_malo(X,S),!,fail.
%% FIN VALORACION DE LAS ACCIONES %%

%% INICIO OBJETIVO %%

goalReached(S):-mundoTieneLimites(S),tableroVacio(S).

%% FIN OBJETIVO %%
