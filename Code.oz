/*
Marie-Marie van der Beek - XXXX 1300
Pablo Gonzalez Alvarez - 5243 1300
*/
declare ProjectLib
Path = "/home/pablo/Documents/fsab1402/fsab1402-project/"
% Path = "Users/marie-marie/Documents/UCL université/Q3(2015)/informatique 2/fsab1402-project/"
[ProjectLib] = {Link [Path#"ProjectLib.ozf"]}
local
   ListOfPersons = {ProjectLib.loadDatabase file Path#"/Databases/database.txt"}

   % @pre: takes a database DB as input argument
   % @post:
   fun {BuildDecisionTree DB}
      Count CountBoolean Choice Remove Names Add ListeQuestion
   in
   % @pre: takes a question Quest and a database DB as input arguments
   % @post: returns the number of persons in DB that answered true or false to Quest
      fun {Count Quest DB}
         fun {CountAux Qu L DBTrue DBFalse}
   	 case L
   	 of nil then
   	    triple(Qu DBTrue DBFalse)
   	 [] H|T andthen H.Qu==true then
   	    {CountAux Qu T H|DBTrue DBFalse}
   	 [] H|T andthen H.Qu==false then
   	    {CountAux Qu T DBTrue H|DBFalse}
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

   % @pre: takes a question Quest and a database DB as input arguments
   % @post: returns a question with a number of true/false
      fun {Choice Quest DB}
         fun {ChoiceAux Question L Quest Acc2}
   	 case Question
   	 of nil then
   	    {Count Quest L}
   	 [] H|T andthen {Abs {CountBoolean H L true}-{CountBoolean H L false}} < Acc2 then
   	    {ChoiceAux T L H {Abs {CountBoolean H L true}-{CountBoolean H L false}}}
   	 [] H|T then
   	    {ChoiceAux T L Quest Acc2}
   	 end
         end
      in
         {ChoiceAux Quest DB Quest.1 {Abs {CountBoolean Quest.1 DB true}-{CountBoolean Quest.1 DB false}}}
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
         if L == nil then
   	 leaf({Names DB})
         elseif {Length DB} == 1 then
   	 leaf({Names DB})
         else
   	 A = {Choice L DB}
         in
   	 if {CountBoolean A.1 DB true} == 0 orelse {CountBoolean A.1 DB false} == 0 then
   	    leaf({Names DB})
   	 else
   	    question(A.1 true:{Add {Remove L A.1} A.2}  false:{Add {Remove L A.1} A.3} 'unknown':{Add {Remove L A.1} DB})
   	 end
         end
      end
      ListeQuestion={Arity DB.1}.2
      {Add ListeQuestion DB}
   end

   fun {GameDriver Tree}
      Result
   in
      case Tree
      of leaf(Ans) then
	 Result = {ProjectLib.found Ans}
      [] question(Quest false:F true:T) then
	 Answer = {ProjectLib.askQuestion Quest}
      in
	 if Answer == true then
	    Result = {GameDriver T}
	 else
	    Result = {GameDriver F}
	 end
      end
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
			 %allowUnknown:true %% D�commenter pour ajouter le bouton "Je ne sais pas"
			 %oopsButton:true %% D�commenter pour ajouter le bouton "Oups, j'ai fait une erreur"
			)}
end
