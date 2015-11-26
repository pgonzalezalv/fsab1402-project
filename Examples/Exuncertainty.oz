declare ProjectLib in
[ProjectLib] = {Link ["ProjectLib.ozf"]}

local
   ListOfPersons = {ProjectLib.loadDatabase file "dbuncertainty.txt"}
   fun {BuildDecisionTree DB}
      notimplemented
   end

   fun {GameDriver Tree}
      Result
   in
      if {ProjectLib.askQuestion 'A-t-il des cheveux longs ?'} then
	 if {ProjectLib.askQuestion 'A-t-il des cheveux noirs ?'} then
	    if {ProjectLib.askQuestion 'Est-il blanc de peau ?'} then
	       if {ProjectLib.askQuestion 'Voit-on son front ?'} then
		  Result = {ProjectLib.found ['Thibaut Courtois' 'Axel Witsel' 'Steven Defour']}
	       else
		  Result = {ProjectLib.found ['Thibaut Courtois' 'Marouane Fellaini' 'Steven Defour']}
	       end
	    else
	       Result = {ProjectLib.found ['Romelu Lukaku' 'Axel Witsel']}
	    end
	 else
	    if {ProjectLib.askQuestion 'A-t-il une barbe ?'} then
	       if {ProjectLib.askQuestion 'Voit-on ses dents ?'} then
		  Result = {ProjectLib.found ['Nicolas Lombaerts' 'Sébastien Pocognoli']}
	       else
		  Result = {ProjectLib.found ['Guillaume Gillet']}
	       end
	    else
	       Result = {ProjectLib.found ['Daniel Van Buyten' 'Nicolas Lombaerts' 'Sébastien Pocognoli']}
	    end
	 end
      else
	 Result = {ProjectLib.found ['Thibaut Courtois' 'Eden Hazard' 'Dries Mertens' 'Vincent Kompany' 'Toby Alderweireld' 'Axel Witsel' 'Jan Vertonghen' 'Steven Defour' 'Nacer Chadli' 'Kevin De Bruyne' 'Timmy Simons' 'Moussa Dembele' 'Kevin Mirallas' 'Zakaria Bakkali' 'Christian Benteke' 'Guillaume Gillet' 'Thomas Vermaelen' 'Sébastien Pocognoli' 'Laurent Ciman' 'Simon Mignolet']}
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
