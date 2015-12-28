package jmatlink;

public class Prueba {
private static double ultimoCaudalElegido = 1;
	
	public static void main(String[] args) {
		
		JMatLink engine = new JMatLink();
		engine.engOpen("matlab -nosplash -nojvm");
		engine.engEvalString("cd '/home/miltondp/Facultad/becas/faia/trabajo_2009/jorge_vega/modelo_tanques2'");
		
		int tiempoInicial = 0;
		int paso = 3;
		int tiempoFinal = tiempoInicial + paso;
		
		double altura = 5;
		double caudalElegido;
		
		double[][] t;
		double[][] h;
		
		while  (tiempoFinal < 60) {
			
			caudalElegido = obtenerCaudal(altura);
			
			engine.engEvalString("[t,h] = TK_1_L(40,.5,"+altura+","+caudalElegido+","+tiempoInicial+","+tiempoFinal+");");
	
			t = engine.engGetArray("t");
			h = engine.engGetArray("h");
			
			System.out.println(" ti: " + tiempoInicial + " ## tf: " + tiempoFinal);
			System.out.println("   altura actual: " + altura);
			System.out.println("   caudal elegido: " + caudalElegido);
			System.out.println();
			
			altura = h[h.length-1][0];
			tiempoInicial = tiempoFinal;
			tiempoFinal = tiempoInicial + paso;
		}
		
		engine.engClose(); 
	}
	
	public static double obtenerCaudal(double h) {
		if (h > 30)
			ultimoCaudalElegido *= 0.90;
		else if (h < 30)
			ultimoCaudalElegido *= 1.10;
		
		return ultimoCaudalElegido;
	}
}
