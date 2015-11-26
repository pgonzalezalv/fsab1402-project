declare
fun {GameDriver Tree}
   Result
in
   case Tree
   of leaf(Ans) then
Result = {ProjectLib.found Ans}
   [] question(Quest false:F true:T) andthen {ProjectLib.askQuestion Quest} == true then
Result = {GameDriver T}
   [] question(Quest false:F true:T) andthen {ProjectLib.askQuestion Quest} == false then
Result = {GameDriver F}
   end
   if Result == false then
{Browse 'Aucune personne ne correspond a cette description'}
   end
   unit
end
