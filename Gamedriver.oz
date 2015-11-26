declare
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
