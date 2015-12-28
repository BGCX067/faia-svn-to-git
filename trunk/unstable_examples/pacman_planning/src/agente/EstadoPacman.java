package agente;

import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.exceptions.PrologConnectorException;
import frsf.cidisi.faia.solver.ActionFactory;
import frsf.cidisi.faia.solver.planning.PlanningBasedAgentState;

import java.util.Hashtable;

public class EstadoPacman extends PlanningBasedAgentState {

	public EstadoPacman() throws PrologConnectorException {
		super("pacman.pl");
		
		this.initState();
	}
	
	@Override
	public void updateState(Perception p) {
		PercepcionPacman pp = (PercepcionPacman) p;
		
		for (String estado : pp.toPrologPredicates())
			this.addInitState(estado);
	}

	@Override
	public void initState() {
		this.addInitState("en(4)");
		// TODO: Falta setear la energía.
	}
	
	public int getPosicion() {
		String consulta = "en(X)";
		Hashtable[] resultado = this.query(consulta);
		int pos = Integer.parseInt(resultado[0].get("X").toString());
		
		return pos;
	}
	
	public int getTamañoMundo() {
		String consulta = "tamaño_mundo(X)";
		Hashtable[] resultado = this.plainQuery(consulta);
		int tam = Integer.parseInt(resultado[0].get("X").toString());
		
		return tam;
	}
	
	public int getEstadoPosicion(int pos) {
		// Veo si hay comida en la posición
		String consulta = "comida(" + pos + ")";
		if (this.queryHasSolution(consulta)) return PercepcionPacman.PERCEPCION_COMIDA;
		
		consulta = "enemigo(" + pos + ")";
		if (this.queryHasSolution(consulta)) return PercepcionPacman.PERCEPCION_ENEMIGO;
		
		consulta = "vacio(" + pos + ")";
		if (this.queryHasSolution(consulta)) return PercepcionPacman.PERCEPCION_VACIO;
		
		consulta = "desconocido(" + pos + ")";
		if (this.queryHasSolution(consulta)) return PercepcionPacman.PERCEPCION_DESCONOCIDO;
		
		// No se debería llegar a esta setencia.
		return Integer.MIN_VALUE;
	}
	
	/**
	 * Dada una posición, devuelve la celda superior a la misma.
	 * @param pos
	 * @return
	 */
	public int getCeldaArriba(int pos) {
		String consulta = "adyacenteArriba(" + pos + ",X).";
		Hashtable[] resultado = this.plainQuery(consulta);
		int arriba = Integer.parseInt(resultado[0].get("X").toString());
		
		return arriba;
	}
	
	/**
	 * Dada una posición, devuelve la celda inferior a la misma.
	 * @param pos
	 * @return
	 */
	public int getCeldaAbajo(int pos) {
		String consulta = "adyacenteAbajo(" + pos + ",X).";
		Hashtable[] resultado = this.plainQuery(consulta);
		int abajo = Integer.parseInt(resultado[0].get("X").toString());
		
		return abajo;
	}
	
	/**
	 * Dada una posición, devuelve la celda que se encuentra a
	 * la derecha de la misma.
	 * @param pos
	 * @return
	 */
	public int getCeldaDerecha(int pos) {
		String consulta = "adyacenteDerecha(" + pos + ",X).";
		Hashtable[] resultado = this.plainQuery(consulta);
		int derecha = Integer.parseInt(resultado[0].get("X").toString());
		
		return derecha;
	}
	
//	public void accionEjecutada(PlanningAction accion) {
//		this.prologConnector.executeNonQuery(query)
//	}
	
	/**
	 * Dada una posición, devuelve la celda que se encuentra a
	 * la izquierda de la misma.
	 * @param pos
	 * @return
	 */
	public int getCeldaIzquierda(int pos) {
		String consulta = "adyacenteIzquierda(" + pos + ",X).";
		Hashtable[] resultado = this.plainQuery(consulta);
		int izquierda = Integer.parseInt(resultado[0].get("X").toString());
		
		return izquierda;
	}
	
	@Override
	public String getBestActionPredicate() {
		return "obtenerAccion";
	}
	
	@Override
	public String getExecuteActionPredicate() {
		return "ejecutarAccion";
	}
	
	@Override
	public ActionFactory getActionFactory() {
		return PlanningAccionFactory.getInstance();
	}

	@Override
	public String toString() {
		StringBuilder str = new StringBuilder();
		int pos = 0;

        str.append(" posicion=\"" + this.getPosicion() + "\"");
        //str = str + " energia=\"" + this.getEnergia() + "\"\n";

        str.append("mundo=\"[ \n");
        for (int fil = 0; fil < this.getTamañoMundo(); fil++) {
            str.append("[ ");
            for (int col = 0; col < this.getTamañoMundo(); col++) {

                if (this.getPosicion() == pos)
                    str.append("P" + " ");
                else {
	                if (this.getEstadoPosicion(pos) == PercepcionPacman.PERCEPCION_DESCONOCIDO) {
	                    str.append("* ");
	                } else {
	                    str.append(this.getEstadoPosicion(pos) + " ");
	                }
                }
                
                pos++;
            }
            str.append(" ]\n");
        }
        str.append(" ]\"");

        return str.toString();
	}
}
