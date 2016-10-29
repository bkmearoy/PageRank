/*
Author: 
		Bereket Tew
*/

%Command for compiling program
c:-['assignment3.pro'].

%Command for starting program
go:-
	countVertices(N),
	J is 1/N,
	foreach(vertex(V), set_rank(V, J)),
	loop(foreach(vertex(V), pageRank(V, N)),30),
	foreach(vertex(V), printRank(V)).

%For looping over the pagerank command multiple times
loop(_,0).
loop(F,Y):-
	call(F),
	Y1 is Y-1,
	loop(F,Y1).

%Counts the number of vertices
countVertices(N):-
	findall(V, vertex(V), Vs),
	length(Vs, N).

%Returns the number of outbound edges from a vertex
outboundEdges(V, O):-
	findall(E, edge(V,E), Vs),
	length(Vs, O).

%Calculates the pagerank
pageRank(V, N):-
	inboundVertices(V, S),
	R is (1-(85/100))/N + (85/100)*S,
	set_rank(V, R).

%Prints the page rank value for given vertex
printRank(V):-
	get_rank(V,J),
	write([V,J]).

%Getter and setter for ranks
set_rank(V, R):-
	vertex(V),
	retractall(pr(V,_)),
	asserta(pr(V,R)).
get_rank(V, R):-
	vertex(V),
	pr(V,R).

%Getter and setter for sum
setSum(T):-
	retractall(val(s,_)),
	asserta(val(s,T)).
getSum(T):-
	val(s,T).

%Along with findVal, calculates the sum of values for inbound vertices for the page rank formula
inboundVertices(V, S):-
	setSum(0),
	foreach(edge(E,V), findVal(E)),
	getSum(S).

findVal(V):-
	get_rank(V, R),
	outboundEdges(V, O),
	getSum(S),
	J is R/O + S,
	setSum(J).

%%%%%%%%%%
vertex(a).
vertex(b).
vertex(c).
vertex(d).
vertex(e).
vertex(f).
vertex(g).
vertex(h).
vertex(i).
vertex(j).
vertex(k).
%%%%%%%%%%
edge(a,b).
edge(a,c).
edge(a,d).
edge(a,e).
edge(a,f).
edge(a,g).
edge(a,h).
edge(a,i).
edge(a,j).
edge(a,k).

edge(b,c).

edge(c,b).

edge(d,a).
edge(d,b).

edge(e,b).
edge(e,d).
edge(e,f).

edge(f,b).
edge(f,e).

edge(g,b).
edge(g,e).

edge(h,b).
edge(h,e).

edge(i,b).
edge(i,e).

edge(j,e).

edge(k,e).
%%%%%%%%%%
/* Raw results
?- go.
[a,0.030291149524400485][b,0.38541164301072506][c,0.343811007905054][d,0.03918773150099732][e,0.08109395348810901][f,0.0391877315009019][g,0.01621111134593768][h,0.01621111134593768][i,0.01621111134593768][j,0.01621111134593768][k,0.01621111134593768]
true .
*/
/* Formatted results
?- go.
[a,0.030291149524400485]
[b,0.38541164301072506]
[c,0.343811007905054]
[d,0.03918773150099732]
[e,0.08109395348810901]
[f,0.0391877315009019]
[g,0.01621111134593768]
[h,0.01621111134593768]
[i,0.01621111134593768]
[j,0.01621111134593768]
[k,0.01621111134593768]
true .
*/