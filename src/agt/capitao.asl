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
	!criarEsquema(ArtGrup);
	.

+!criarEsquema(ArtGrup)
	<-  
	.concat("procPeixes",ArtGrup, Scheme1Name);
	createScheme(Scheme1Name, g1t1ProcurarPeixesSch, Sch1ArtId);
	
	.concat("realizarPescaria",ArtGrup, Scheme2Name);
	createScheme(Scheme2Name, g1t2RealizarPescariaSch, Sch2ArtId);
	
	.concat("descarrPeixes",ArtGrup, Scheme3Name);
	createScheme(Scheme3Name, g1t3DescarrPeixesPortoSch, Sch3ArtId);
	
	//Instanciando esquema 01 da equipe de Navegação
	addScheme(Scheme1Name);
	.	
     	
+!g1t1_ligar_motor <- 
	.print("ligando os motores para iniciar a navegacao em mar aberto...");
	ligar_motores; //função do artefato Barco
	.

+!g1t1_localizar_cardume 
	: groups(Grupo) & play(_,_,ArtGrup)
	<- 
	.print("se preparando para localizar os cardumes no mar...");
	piloto_automatico;	//função do artefato Barco
	.print("cardume encontrado...");
	
	//Instanciando esquema 02 da equipe de Navegação
	//.nth(0,Grupo,ArtGrup);
	.concat("realizarPescaria",ArtGrup, SchemeName);
	addScheme(SchemeName);
	.
	
+!g1t3_nav_porto <- 
	.print("navegando em direção ao Porto para descarregar...");
	navegando_para_porto; //função do artefato Barco
	.
	
+!g1t3_desligar_motores <- 
	.print("desligando os motores...");
	desligar_motores; //função do artefato Barco
	.

/* other plans */