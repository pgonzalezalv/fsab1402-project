declare
fun {GameDriver Tree}
   Result
in
   case Tree
   of leaf(Ans) then
      Result = {ProjectLib.found Ans}
   [] question(Quest false:F true:T 'unknown':U) then
      Answer = {ProjectLib.askQuestion Quest}
   in
      case Answer
      of true then
	 Result = {GameDriver T}
      [] false then
	 Result = {GameDriver F}
      [] 'unknown' then
	 Result = {GameDriver U}
      end
   end
   if Result == false then
      {Browse 'Aucune personne ne correspond a cette description'}
   end
   unit
end
