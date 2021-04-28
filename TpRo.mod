/*********************************************
 * OPL 12.8.0.0 Model
 * Author: ASUS
 * Creation Date: 23 avr. 2021 at 23:05:27
 *********************************************/

int NCity = ...;
range Cities = 1..NCity;

int qte[Cities][Cities] = ...;
 

int Dist[Cities][Cities] = ...;

float C[Cities][Cities][Cities][Cities];
// Calcul le C
execute {
	for(var i in Cities){
		for(var j in Cities){
			for(var k in Cities){
				for(var m in Cities){
					C[i][j][k][m] = D[i][k] + 0.8 * D[k][m] + D[m][j];
				}
			}
		}
	}
}



dvar boolean hub[Cities];

dvar boolean flow[Cities][Cities][Cities][Cities];
//Definir la fonction objectif
minimize sum(i in Cities, j in Cities, k in Cities, m in Cities) C[i][j][k][m] * qte[i][j] * flow[i][j][k][m];

subject to {
 // le nombre hub egal a 2
	sum(City in Cities) hub[City] == 2; 
	
	forall(i in Cities, j in Cities) {
		// la somme des flow egal a 1
		sum(k in Cities, m in Cities) flow[i][j][k][m] == 1;
	}
	
	forall(i in Cities, j in Cities, k in Cities, m in Cities) {
		flow[i][j][k][m] <= hub[k];
		//la somme des floc <= hub[k]
	}
	
	forall(i in Cities, j in Cities, k in Cities, m in Cities) {
		flow[i][j][k][m] <= hub[m];
		//la somme des floc <= hub[m]
	}		
}