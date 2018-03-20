{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }

/* application domain goals */

+play(Name,_,ArtGrup) 
	: .my_name(Name)
	<-	
	lookupArtifact(ArtGrup, ArtId);
	focus(ArtId);
	.print("Focando no Barco: ", ArtGrup ,"...");
	.

+!g1t1_puxar_ancora <- 
	.print("puxando ancora para iniciar a navegacao em mar aberto...");
	puxar_ancora; //função do artefato Barco
	.

+!g1t3_soltar_ancora <- 
	.print("soltar ancora para iniciar a parada...");
	soltar_ancora; //função do artefato Barco
	.

+!g1t3_retir_peixes <- 
	.print("retirando peixes do Barco...");
	lookupArtifact(porto, ArtId); //busca o identificador do artefato Porto
	colocar_peixes_porto(ArtId); //função do artefato Barco
	.

/* other plans */