declare ProjectLib in
[ProjectLib] = {Link ["ProjectLib.ozf"]}

local
   ListOfPersons = {ProjectLib.loadDatabase file "database.txt"}

   fun {BuildDecisionTree DB}
      notimplemented
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
	 {Browse 'Pas donn�'}
	 Result = false
      end
      if Result == false then 
	 {Browse 'Aucune personne ne correspond � cette description'}
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
