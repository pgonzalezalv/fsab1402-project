fun {Count Q Db} % compte le nombre de personnes ayant repondu true et false a cette question Q parmis les person dans Db
   Count2
in 
   fun {Count2 Qu L Acc1 Acc2}
      case L of nil then triple(Qu Acc1 Acc2)
      []H|T andthen H.Qu==true then {Count2 Qu T H.1|Acc1 Acc2}
      []H|T andthen H.Qu==false then {Count2 Qu T Acc1 H.1|Acc2}
      end
   end
   {Count2 Q Db nil nil}
end

fun {Nbtrue Q Db} % prend une question et regarde le nombre de true
   {Length {Count Q Db}.2}
end
fun {Nbfalse Q Db} % prend une question et regarde le nombre de false
   {Length {Count Q Db}.3}
end
fun {Choice Quest Db}%choisis la question ayant un nombre true/false equilibree
   Choice2 in 
   fun {Choice2 Question L Acc1 Acc2}
      case Question of nil then {Count Acc1 L}
      []H|T andthen {Abs {Nbtrue H L}-{Nbfalse H L}} < Acc2 then {Choice2 T L H {Abs {Nbtrue H L}-{Nbfalse H L}}}
      []H|T then {Choice2 T L Acc1 Acc2}
      end
   end
   {Choice2 Quest Db Quest.1 {Abs {Nbtrue Quest.1 Db}-{Nbfalse Quest.1 Db}}}
end


