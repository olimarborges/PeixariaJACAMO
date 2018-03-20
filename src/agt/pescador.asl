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

+!g1t2_jogar_redes 
	<-
	.print("jogando as redes nos cardumes...");
	jogar_redes; //fun��o do artefato Barco
	.
	
+!g1t2_recolher_redes
	: quantMaxCarga(CapaMaxArm,QuantPeixes) & capacRede(Capac) & (Capac+QuantPeixes)>CapaMaxArm & play(_,_,ArtGrup) 
	<-
	.print("recolhendo as redes para ir em dire��o ao Porto..."); 		
	//Instanciando esquema 03 da equipe de Navega��o
	//.nth(0,Grupo,ArtGrup);
	.concat("descarrPeixes",ArtGrup, SchemeName);
	addScheme(SchemeName);
	.

+!g1t2_recolher_redes
	: quantMaxCarga(CapaMaxArm,QuantPeixes) & qtPeixesDisponivel(QtRestante) & QtRestante<=0 & play(_,_,ArtGrup) 
	<-
	.print("recolhendo as redes para ir em dire��o ao Porto..."); 		
	//Instanciando esquema 03 da equipe de Navega��o
	//.nth(0,Grupo,ArtGrup);
	.concat("descarrPeixes",ArtGrup, SchemeName);
	addScheme(SchemeName);
	.	
	
+!g1t2_recolher_redes 
	: quantMaxCarga(_,QuantPeixes) & groups(Grupo)
	<- 
	.print("recolhendo as redes com os peixes pescados...");
	lookupArtifact(oceano, ArtId); //busca o identificador do artefato Oceano
	recolher_redes(ArtId); //fun��o do artefato Barco
	
	//consuta na base de cren�as do agente
	?quantMaxCarga(_,QuantTotalPeixes);
	
	.print("Quantidade de peixes pescados neste lan�amento de redes: ", QuantTotalPeixes-QuantPeixes);
	!g1t2_recolher_redes;
	.
	
/* other plans */