/*
Marie-Marie van der Beek - XXXX 1300
Pablo Gonzalez Alvarez - 5243 1300
*/
declare ProjectLib
Path = "/home/pablo/Documents/fsab1402/fsab1402-project/"
% Path = "Users/marie-marie/Documents/UCL université/Q3(2015)/informatique 2/fsab1402-project/" 
[ProjectLib] = {Link [Path#"ProjectLib.ozf"]}
local
   ListOfPersons = {ProjectLib.loadDatabase file Path#"database.txt"}

% @pre: takes a database DB as input argument
% @post:
   fun {BuildDecisionTree DB}
      Count NbTrue NbFalse Choice Remove Names Add ListeQuestion
   in
% @pre: takes a question Q and a database DB as input arguments
% @post: returns the number of persons in DB that answered true or false to Q
      fun {Count Q DB}
	 fun {CountAux Qu L Acc1 Acc2 Acc3 Acc4}
	    case L
	    of nil then
	       triple(Qu Acc1 Acc2 Acc3 Acc4)
	    [] H|T andthen H.Qu==true then
	       {CountAux Qu T H.1|Acc1 Acc2 H|Acc3 Acc4}
	    [] H|T andthen H.Qu==false then
	       {CountAux Qu T Acc1 H.1|Acc2 Acc3 H|Acc4}
	    end
	 end
      in
	 {CountAux Q DB nil nil nil nil}
      end

% @pre: takes a question Q and a database DB as input arguments
% @post: returns the number of true
      fun {NbTrue Q DB}
	 {Length {Count Q DB}.2}
      end
% @pre: takes a question Q and a database DB as input arguments
% @post: returns the number of false
      fun {NbFalse Q DB}
	 {Length {Count Q DB}.3}
      end

% @pre: takes a question Quest and a database DB as input arguments
% @post: returns a question with a number of true/false
      fun {Choice Quest DB}
	 ChoiceAux in
	 fun {ChoiceAux Question L Acc1 Acc2}
	    case Question
	    of nil then
	       {Count Acc1 L}
	    [] H|T andthen {Abs {NbTrue H L}-{NbFalse H L}} < Acc2 then
	       {ChoiceAux T L H {Abs {NbTrue H L}-{NbFalse H L}}}
	    [] H|T then
	       {ChoiceAux T L Acc1 Acc2}
	    end
	 end
	 {ChoiceAux Quest DB Quest.1 {Abs {NbTrue Quest.1 DB}-{NbFalse Quest.1 DB}}}
      end
% @pre: takes a list List and question Question as input arguments
% @post: returns List without Question
      fun {Remove List Question}
	 case List
	 of nil then
	    nil
	 [] H|T andthen H==Question then
	    T
	 [] H|T then
	    H|{Remove T Question}
	 end
      end

% @pre: takes a database DB as input argument
% @post: returns the persons name from DB
      fun {Names DB}
	 case DB
	 of nil then
	    nil
	 [] H|T then
	    H.1|{Names T}
	 end
      end

% @pre: takes a list L and a database DB as input arguments
% @post: returns DB with L
      fun {Add L DB}
	 if L==nil then
	    leaf({Names DB})
	 elseif {Length DB}==1 then
	    leaf({Names DB})
	 elseif DB == nil then
	    leaf(nil)
	 else
	    local
	       A={Choice L DB}
	    in
	       question(A.1 true:{Add {Remove L A.1} A.4}  false:{Add {Remove L A.1} A.5})
	    end
	 end
      end
      ListeQuestion={Arity DB.1}.2
      {Add ListeQuestion DB}
   end

   fun {GameDriver Tree}
      Result
   in
      if {ProjectLib.askQuestion 'A-t-il des cheveux longs ?'} then
	 if {ProjectLib.askQuestion 'A-t-il des cheveux noirs ?'} then
	    if {ProjectLib.askQuestion 'Est-il blanc de peau ?'} then
	       Result = {ProjectLib.found ['Axel Witsel' 'Marouane Fellaini']}
	    else
	       Result = {ProjectLib.found ['Romelu Lukaku']}
	    end
	 else
	    if {ProjectLib.askQuestion 'A-t-il une barbe ?'} then
	       if {ProjectLib.askQuestion 'Voit-on ses dents ?'} then
		  Result = {ProjectLib.found ['Nicolas Lombaerts']}
	       else
		  Result = {ProjectLib.found ['Guillaume Gillet']}
	       end
	    else
	       Result = {ProjectLib.found ['Daniel Van Buyten']}
	    end
	 end
      else
	 {Browse 'Pas donne'}
	 Result = false
      end
      if Result == false then
	 {Browse 'Aucune personne ne correspond a cette description'}
      end

      %% Toujours retourner unit
      unit
   end

in
   %% Lancer le jeu
   {ProjectLib.play opts(builder:BuildDecisionTree
			 persons:ListOfPersons
			 driver:GameDriver
			 %allowUnknown:true %% D�commenter pour ajouter le bouton "Je ne sais pas"
			 %oopsButton:true %% D�commenter pour ajouter le bouton "Oups, j'ai fait une erreur"
			)}
end
