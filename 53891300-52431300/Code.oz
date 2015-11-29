/*
Marie-Marie van der Beek - 5389 1300
Pablo Gonzalez Alvarez - 5243 1300
*/
local ProjectLib
   [ProjectLib] = {Link ["ProjectLib.ozf"]}
in
   local
      ListOfPersons = {ProjectLib.loadDatabase file "database.txt"}

   % @pre: takes a database DB as input argument
   % @post: returns a decision tree
      fun {BuildDecisionTree DB}

      % @pre: takes a list L and a database DB as input arguments
      % @post: returns DB with L
	 fun {Add List DB}
	    if List == nil then
	       leaf({Names DB})
	    elseif {Length DB} == 1 then
	       leaf({Names DB})
	    else
	       A = {Choice List DB}
	    in
	       if {CountBoolean A.1 DB true} == 0 orelse {CountBoolean A.1 DB false} == 0 then
		  leaf({Names DB})
	       else
		  question(A.1 true:{Add {Remove List A.1} A.2}  false:{Add {Remove List A.1} A.3} 'unknown':{Add {Remove List A.1} DB})
	       end
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

      % @pre: takes a question Quest and a database DB as input arguments
      % @post: returns a question with a number of true/false
	 fun {Choice Quest DB}

	    fun {ChoiceAux Question List Quest Tol}
	       case Question
	       of nil then
		  {Count Quest List}
	       [] H|T andthen
		  Diff = {Abs {CountBoolean H List true} - {CountBoolean H List false}}
	       in
		  Diff < Tol then
		  {ChoiceAux T List H Diff}
	       [] H|T then
		  {ChoiceAux T List Quest Tol}
	       end
	    end

	 in
	    {ChoiceAux Quest DB Quest.1 {Abs {CountBoolean Quest.1 DB true}-{CountBoolean Quest.1 DB false}}}
	 end

      % @pre: takes a question Quest and a database DB as input arguments
      % @post: returns the number of persons in DB that answered true or false to Quest
	 fun {Count Quest DB}
	    fun {CountAux Quest List DBTrue DBFalse}
	       case List
	       of nil then
		  triple(Quest DBTrue DBFalse)
	       [] H|T andthen H.Quest==true then
		  {CountAux Quest T H|DBTrue DBFalse}
	       [] H|T andthen H.Quest==false then
		  {CountAux Quest T DBTrue H|DBFalse}
	       end
	    end
	 in
	    {CountAux Quest DB nil nil}
	 end

      % @pre: takes a question Quest, a database DB, and a boolean Bool as input arguments
      % @post: returns the number of Bool of the Quest in the DB
	 fun {CountBoolean Quest DB Bool}
	    case Bool
	    of true then
	       {Length {Count Quest DB}.2}
	    [] false then
	       {Length {Count Quest DB}.3}
	    end
	 end

      % @pre: takes a list List and question Quest as input arguments
      % @post: returns List without Quest
	 fun {Remove List Quest}
	    case List
	    of nil then
	       nil
	    [] H|T andthen H==Quest then
	       T
	    [] H|T then
	       H|{Remove T Quest}
	    end
	 end

	 ListeQuestion = {Arity DB.1}.2

      in
	 {Add ListeQuestion DB}
      end

   % @pre: takes a decision tree Tree as input argument
   % @post: returns a result Result
      fun {GameDriver Tree}
	 Result
	 fun {GameDriverOops Tree PreviousTree}
	    case Tree
	    of leaf(Ans) then
	       {ProjectLib.found Ans}
	    [] question(Quest false:F true:T 'unknown':U) then
	       Answer = {ProjectLib.askQuestion Quest}
	    in
	       case Answer
	       of true then
		  {GameDriverOops T Tree|PreviousTree}
	       [] false then
		  {GameDriverOops F Tree|PreviousTree}
	       [] 'unknown' then
		  {GameDriverOops U Tree|PreviousTree}
	       [] 'oops' andthen PreviousTree == nil then
		  {GameDriverOops Tree PreviousTree}
	       [] 'oops' then
		  {GameDriverOops PreviousTree.1 PreviousTree.2}
	       end
	    end

	 end
      in
	 Result = {GameDriverOops Tree nil}
	 if Result == false then
	    {Browse 'Aucune personne ne correspond a cette description'}
	 end
	 unit
      end

   in
      %% Lancer le jeu
      {ProjectLib.play opts(builder:BuildDecisionTree
			    persons:ListOfPersons
			    driver:GameDriver
			    allowUnknown:true %% D�commenter pour ajouter le bouton "Je ne sais pas"
			    oopsButton:true %% D�commenter pour ajouter le bouton "Oups, j'ai fait une erreur"
			   )}
   end
end
