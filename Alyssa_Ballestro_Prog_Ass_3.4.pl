% Alyssa Ballestro
% 9/29/2024
%Programming Languages

% Lineage (Facts)
parent(abraham, isaac).
parent(isaac, israel).
parent(israel, judah).
parent(israel,jospeh).
parent(judah, perez).
parent(judah, zerah).
parent(perez, hezron).
parent(hezron, ram).
parent(ram, amminadab).
parent(amminadab, nahshon).
parent(nahshon, salmon).
parent(salmon, boaz).
parent(boaz, obed).
parent(obed, jesse).
parent(jesse, david).
parent(david, solomon).
parent(solomon, rehoboam).
parent(rehoboam, abijah).
parent(abijah, asa).
parent(asa, jehoshaphat).
parent(jehoshaphat, joram).
parent(joram, uzziah).
parent(uzziah, jotham).
parent(jotham, ahaz).
parent(ahaz, hezekiah).
parent(hezekiah, manasseh).
parent(manasseh, amon).
parent(amon, josiah).
parent(josiah, jeconiah).
parent(jeconiah, shealtiel).
parent(shealtiel, zerubbabel).
parent(zerubbabel, abihud).
parent(abihud, eliakim).
parent(eliakim, azor).
parent(azor, zadok).
parent(zadok, akim).
parent(akim, elihud).
parent(elihud, eleazar).
parent(eleazar, matthan).
parent(matthan, jacob).
parent(jacob, joseph).
parent(joseph, jesus).

% Gender
male(abraham).
male(isaac).
male(israel).
male(judah).
male(perez).
male(zerah).
male(hezron).
male(ram).
male(amminadab).
male(nahshon).
male(salmon).
male(boaz).
male(obed).
male(jesse).
male(david).
male(solomon).
male(rehoboam).
male(abijah).
male(asa).
male(jehoshaphat).
male(joram).
male(uzziah).
male(jotham).
male(ahaz).
male(hezekiah).
male(manasseh).
male(amon).
male(josiah).
male(jeconiah).
male(shealtiel).
male(zerubbabel).
male(abihud).
male(eliakim).
male(azor).
male(zadok).
male(akim).
male(elihud).
male(eleazar).
male(matthan).
male(jacob).
male(joseph).
male(jesus).
female(sarah).
female(rebekah).
female(rachel).
female(rahab).
female(ruth).
female(bathsheba).
female(mary).

%Rules

%Makes the first letter capitalized and returns as a whole word(atom)
capitalize_atom(Atom, Capitalized) :-
    (   var(Atom)
    ->  format('Atom not in the system, please try inputting as a string using apostrophes for the query.~n'),
        fail  % Explicitly fail the goal if Atom is unbound
    ;   atom_chars(Atom, CharList),         % Convert the atom to a list of characters
        capitalize_first(CharList, CapitalizedCharList), % Capitalize the first letter
        atom_chars(Capitalized, CapitalizedCharList)  % Convert back to an atom
    ).
% Helper to capitalize the first character
capitalize_first([First | Rest], [UpperFirst | Rest]) :-
    upcase_atom(First, UpperFirst).      % Capitalize the first character
% Makes all the letters downcase
downcase_name(Name, Downcase) :-
    (   var(Name)
    ->  format('ERROR: Data Not Initialized.~n')
    ;   downcase_atom(Name, Downcase)  % Only call downcase_atom if Name is instantiated
    ).

%Parent-Related Rules

% Determine who is the father of who
father(Father, Son) :-
    parent(Father, Son),
    male(Son).
    % Determine who is the grandfather of who
grandpa(Grandpa, Grandson) :-
    parent(Grandpa, Parent),
    parent(Parent, Grandson),
    male(Grandpa).
% Determine who is the son of who
son(Son, Parent) :-
    parent(Parent, Son),
    male(Son).

% Determine who is the mother of who
mother(Mother, Son) :-
    parent(Mother, Son),
    female(Mother).
% Determine if  sharing parents (siblings)
sibling(X, Y) :-
    parent(Parent, X),
    parent(Parent, Y),
    X \= Y.

% Print Rules

% Find out if the father
is_father(X, Y) :-
    downcase_name(X, LowerX),
    downcase_name(Y, LowerY),
    capitalize_atom(LowerX, PrintX),
    capitalize_atom(LowerY, PrintY),
    ( father(LowerX, LowerY) ->
        format('~w is the father of ~w.~n', [PrintX, PrintY])
    ;   format('~w is not the father of ~w.~n', [PrintX, PrintY])
    ).
% Find out if the mother
is_mother(X, Y) :-
    downcase_name(X, LowerX),
    downcase_name(Y, LowerY),
    capitalize_atom(LowerX, PrintX),
    capitalize_atom(LowerY, PrintY),
    ( mother(LowerX, LowerY) ->
        format('~w is the mother of ~w.~n', [PrintX, PrintY])
    ;   format('~w is not the mother of ~w.~n', [PrintX, PrintY])
    ).
% Find out if the sibling
is_sib(X, Y) :-
    downcase_name(X, LowerX),
    downcase_name(Y, LowerY),
    capitalize_atom(LowerX, PrintX),
    capitalize_atom(LowerY, PrintY),
    ( sibling(LowerX, LowerY) ->
        format('~w is a sibling of ~w.~n', [PrintX, PrintY])
    ;   format('~w is not a sibling of ~w.~n', [PrintX, PrintY])
    ).
% Find out if the grandpa
is_g_pa(X, Y) :-
    downcase_name(X, LowerX),
    downcase_name(Y, LowerY),
    capitalize_atom(LowerX, PrintX),
    capitalize_atom(LowerY, PrintY),
    ( grandfather(LowerX, LowerY) ->
        format('~w is the grandfather of ~w.~n', [PrintX, PrintY])
    ;   format('~w is not the grandfather of ~w.~n', [PrintX, PrintY])
    ).
% Find out if the son
is_son(X, Y) :-
    downcase_name(X, LowerX),
    downcase_name(Y, LowerY),
    capitalize_atom(LowerX, PrintX),
    capitalize_atom(LowerY, PrintY),
    ( son(LowerX, LowerY) ->
        format('~w is a son of ~w.~n', [PrintX, PrintY])
    ;   format('~w is not a son of ~w.~n', [PrintX, PrintY])
    ).
% Find all women in lineage
list_women :-
    female(Woman),
    capitalize_atom(Woman, PrintW),
    format('~w is a woman.~n', [PrintW]),
    fail.
list_women.

% Find all siblings in their pairs
list_siblings_all :-
    sibling(X, Y),
    capitalize_atom(X, PrintX),
    capitalize_atom(Y, PrintY),
    format('~w and ~w are siblings.~n', [PrintX, PrintY]),
    fail.
