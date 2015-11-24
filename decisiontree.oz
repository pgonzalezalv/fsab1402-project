declare
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
% @post: returns a question with a nomber of true/false
   fun {Choice Quest DB} % choisis la question ayant un nombre true/false equilibree
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

local
   ListOfPerson
in
   ListOfPersons =[
		   person('Thibaut Courtois'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Eden Hazard'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Dries Mertens'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Vincent Kompany'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':false
			 )
		   person('Toby Alderweireld'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Romelu Lukaku'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':false
			 )
		   person('Daniel Van Buyten'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Axel Witsel'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Jan Vertonghen'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Steven Defour'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Nacer Chadli'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':false
			 )
		   person('Kevin De Bruyne'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Timmy Simons'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Moussa Dembele'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':false
			 )
		   person('Marouane Fellaini'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Nicolas Lombaerts'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Kevin Mirallas'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Zakaria Bakkali'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':false
			 )
		   person('Christian Benteke'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':true
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':false
			 )
		   person('Guillaume Gillet'
			  'A-t-il des cheveux longs ?':true
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Thomas Vermaelen'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Sébastien Pocognoli'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )
		   person('Laurent Ciman'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':true
			  'A-t-il une moustache ?':true
			  'Voit-on ses dents ?':false
			  'Est-il blanc de peau ?':true
			 )
		   person('Simon Mignolet'
			  'A-t-il des cheveux longs ?':false
			  'A-t-il des cheveux noirs ?':false
			  'A-t-il une barbe ?':false
			  'A-t-il une moustache ?':false
			  'Voit-on ses dents ?':true
			  'Est-il blanc de peau ?':true
			 )]
   {Browse {BuildDecisionTree ListOfPersons}}
end
