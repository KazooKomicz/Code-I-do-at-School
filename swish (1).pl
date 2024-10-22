% Alyssa Ballestro
% 10/4/2024
% Programming Languages
% Murder Mystery

% Define characters
character(aaron).
character(betty).
character(clara).
character(duane).
character(edwin).
character(flora).

% Define occupations
doctor(aaron).
doctor(betty).
doctor(duane).
lawyer(clara).
lawyer(edwin).
lawyer(flora).

% Define relationships
sister(betty, aaron).
sister(clara, aaron).
brother(duane, flora).
brother(edwin, flora).

% Define genders
male(aaron).
male(duane).
male(edwin).
female(betty).
female(clara).
female(flora).

% Define helper predicates for relationships
related(X, Y) :- sister(Y, X); sister(X, Y); brother(Y, X); brother(X, Y).
same_sex(X, Y) :- male(X), male(Y); female(X), female(Y).
different_sex(X, Y) :- (male(X), female(Y)); (female(X), male(Y)).

% Solution rule to check all clues simultaneously and strictly enforce them
solution(K, V) :-
    character(K),
    character(V),
    K \= V,  % Ensure that killer and victim are not the same
    % Clue A: If related, the killer must be male
    ( related(K, V) -> male(K) ; true ),

    % Clue B: If not related, the killer must be a doctor
    ( \+ related(K, V) -> doctor(K) ; true ),

    % Clue C: If the killer and the victim had the same occupation, the victim must be male
    ( doctor(K), doctor(V) -> male(V) ;
      lawyer(K), lawyer(V) -> male(V) ;
      true ),

    % Clue D: If the killer and the victim had different occupations, the victim must be female
    ( doctor(K), lawyer(V) -> female(V) ;
      lawyer(K), doctor(V) -> female(V) ;
      true ),

    % Clue E: If they are the same sex, the killer must be a lawyer
    ( same_sex(K, V) -> lawyer(K) ; true ),

    % Clue F: If they are different sexes, the victim must be a doctor
    ( different_sex(K, V) -> doctor(V) ; true ),
    !.  % Cut to prevent backtracking

solution(_, _) :- fail.

% Predicate to print the solution
print_solution :-
    solution(K, V),
    format('The killer is ~w and the victim is ~w.~n', [V, K]).

% Menu to display clues
menu :-
    writeln('The sisters of Aaron Green were/are Betty and Clara;
             the brothers of his girlfriend, Flora Brown, were Duane and Edwin.
             Their occupations were/are as follows:
             Doctors: Aaron, Betty, Duane.
             Lawyers: Clara, Edwin, Flora.
             One of the six killed one of the other five.'),
    writeln(''),
    writeln('Clue A: If the killer and the victim were related, the killer was a man. (type "killer_male(K,V).")'),
    writeln('Clue B: If the killer and the victim were not related, the killer was a doctor. (type "killer_doctor(K,V).")'),
    writeln('Clue C: If the killer and the victim had the same occupation, the victim was a man. (type "victim_male(K,V).")'),
    writeln('Clue D: If the killer and the victim had different occupations, the victim was a woman. ("victim_female(K,V).")'),
    writeln('Clue E: If the killer and the victim were of the same sex, the killer was a lawyer. (type "killer_lawyer(K,V).")'),
    writeln('Clue F: If the killer and victim were different sexes, the victim was a doctor. (type "victim_doctor(K,V).")'),
    writeln(''),
    writeln('Type "menu." to see the clues list again.'),
    writeln('To guess who the killer and the victim are type "user_guess."').

% Rating guesses
guess_count(1) :-
    writeln('Congratulations! You got it in 1 guess! You are a true detective!').
guess_count(2) :-
    writeln('Well done! You solved it in 2 guesses!').
guess_count(3) :-
    writeln('Good job! You solved it in 3 guesses!').
guess_count(4) :-
    writeln('Sorry, you couldn\'t solve the mystery in 3 guesses. Better luck next time!').

% User guesses

% Function to start the guessing process
user_guess :-
    write('Welcome to the Murder Mystery Game! ("menu." for clues)'), nl,
    write('You have three attempts to guess the killer and the victim.'), nl,
    write('Good luck!'), nl,
    user_guess(1).

user_guess(1) :-
    write('Make your first guess (format: \'victim-killer\'): '),
    read(Guess),
    split_guess(Guess, Killer, Victim),
    ( solution(Killer, Victim) -> guess_count(1);
        user_guess(2)).

user_guess(2) :-
    write('Make your second guess (format:  \'victim-killer\'): '),
    read(Guess),
    split_guess(Guess, Killer, Victim),
    ( solution(Killer, Victim) -> guess_count(2);
        user_guess(3)).

user_guess(3) :-
    write('Make your third guess (format:  \'victim-killer\'): '),
    read(Guess),
    split_guess(Guess, Killer, Victim),
    ( solution(Killer, Victim) -> guess_count(3);
        guess_count(4)).

% Helper function to split the input string into killer and victim
split_guess(Guess, Killer, Victim) :-
    split_string(Guess, "-", "", [KillerString, VictimString]),
    atom_string(Killer, KillerString),
    atom_string(Victim, VictimString).

