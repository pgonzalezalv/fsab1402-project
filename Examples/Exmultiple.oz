declare ProjectLib in
[ProjectLib] = {Link ["ProjectLib.ozf"]}

local
   ListOfPersons = {ProjectLib.loadDatabase file "dbmultiple.txt"}
   fun {BuildDecisionTree DB}
      notimplemented
   end

   fun {GameDriver Tree}
      Result
   in
      if {ProjectLib.askQuestion 'A-t-il des cheveux longs ?'} then
	 HairColor = {ProjectLib.askQuestion 'De quelle couleur sont les cheveux ?'}
      in
	 if HairColor  == black then
	    if {ProjectLib.askQuestion 'Est-il blanc de peau ?'} then
	       Result = {ProjectLib.found ['Axel Witsel' 'Marouane Fellaini']}
	    else
	       Result = {ProjectLib.found ['Romelu Lukaku']}
	    end
	 else
	    if HairColor == brown
	    then
	       if {ProjectLib.askQuestion 'A-t-il une barbe ?'} then
		  if {ProjectLib.askQuestion 'Voit-on ses dents ?'} then
		     Result = {ProjectLib.found ['Nicolas Lombaerts']}
		  else
		     Result = {ProjectLib.found ['Guillaume Gillet']}
		  end
	       else
		  Result = {ProjectLib.found ['Daniel Van Buyten']}
	       end
	    else
	       Result = false
	    end
	 end
      else
	 {Browse 'Pas donné'}
	 Result = false
      end
      if Result == false then 
	 {Browse 'Aucune personne ne correspond à cette description'}
      end
      
   %% Toujours retourner unit
      unit
   end
      
in
   %% Lancer le jeu
   {ProjectLib.play opts(builder:BuildDecisionTree
			 persons:ListOfPersons
			 driver:GameDriver
			 %allowUnknown:true %% Décommenter pour ajouter le bouton "Je ne sais pas"
			 %oopsButton:true %% Décommenter pour ajouter le bouton "Oups, j'ai fait une erreur"
			 %missingPlayer:true %% Décommenter pour ajouter un bouton "Aucune de ces personnes"
			)}
end
