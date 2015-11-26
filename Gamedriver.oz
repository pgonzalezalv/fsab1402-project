
declare
fun {GameDriver Tree}
   Result
in
   case Tree of leaf(A) then Result={ProjectLib.found A}
   []H|T question(A true:T false:F) andthen {ProjectLib.askQuestion A}==true then {GameDriver T}
   []H|T question(A true:T false:F) andthen {ProjectLib.askQuestion A}==false then {GameDriver F}
   end
   if Result == false then {Browse ‘Aucune personne ne correspond à cette description’}
   end
   unit
end