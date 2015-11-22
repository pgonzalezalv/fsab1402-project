declare
fun {Count Q Db} % compte le nombre de personnes ayant repondu true et false a cette question Q parmis les person dans Db
   Count2
in 
   fun {Count2 Qu L Acc1 Acc2 Acc3 Acc4}
      case L of nil then triple(Qu Acc1 Acc2 Acc3 Acc4)
      []H|T andthen H.Qu==true then {Count2 Qu T H.1|Acc1 Acc2 H|Acc3 Acc4}
      []H|T andthen H.Qu==false then {Count2 Qu T Acc1 H.1|Acc2 Acc3 H|Acc4}
      end
   end
   {Count2 Q Db nil nil nil nil}
end
declare
fun {Nbtrue Q Db} % prend une question et regarde le nombre de true
   {Length {Count Q Db}.2}
end
declare
fun {Nbfalse Q Db} % prend une question et regarde le nombre de false
   {Length {Count Q Db}.3}
end
declare
fun {Choice Quest Db} % choisis la question ayant un nombre true/false equilibree
   Choice2 in 
   fun {Choice2 Question L Acc1 Acc2}
      case Question of nil then {Count Acc1 L}
      []H|T andthen {Abs {Nbtrue H L}-{Nbfalse H L}} < Acc2 then {Choice2 T L H {Abs {Nbtrue H L}-{Nbfalse H L}}}
      []H|T then {Choice2 T L Acc1 Acc2}
      end
   end
   {Choice2 Quest Db Quest.1 {Abs {Nbtrue Quest.1 Db}-{Nbfalse Quest.1 Db}}}
end
declare
fun {Remove Liste Question}
      case Liste of nil then nil
      []H|T andthen H==Question then T
      []H|T then H|{Remove T Question}
      end
end
declare
fun {Names Db}
    case Db of nil then nil
    []H|T then H.1|{Names T}
    end
end
declare
fun {BuildDecisionTree Db}
   Add ListeQuestion
in 
      fun {Add L Db}
	 if L==nil then leaf({Names Db})
	 elseif {Length Db}==1 then leaf({Names DB})
	 else local A={Choice L Db} in question(A.1 true:{Add {Remove L A.1} A.4}  false:{Add {Remove L A.1} A.5})	end
	 end
      end
   ListeQuestion={Arity Db.1}.2
   {Add ListeQuestion Db}
end
local ListOfPersons in
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
