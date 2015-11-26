declare
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
