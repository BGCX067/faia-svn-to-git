package agente;

import frsf.cidisi.faia.state.EnvironmentState;

/**
 * Esta clase es muy similar a su par correspondiente en el ejemplo
 * del 'pacman' (basado en Búsqueda). Es recomendable mirar los comentarios
 * allí primero.
 * Ver que esta clase es idéntica a la del ejemplo 'pacman', ya que el hecho
 * de que se utilice Cálculo Situacional en el agente, no hace que tengan
 * que cambiarse todas las clases, entre ellas la representación del
 * mundo real vista por el simulador.
 */
public class EstadoAmbiente extends EnvironmentState {

    private int[] mundo;
    private int tamaño_mundo = 3;

    public EstadoAmbiente() {
        mundo = new int[tamaño_mundo * tamaño_mundo];
        this.initState();
    }
    
    @Override
    public void initState() {

        for (int i = 0; i < mundo.length; i++) {
        	mundo[i] = PercepcionPacman.PERCEPCION_VACIO;
        }
        
        mundo[0] = PercepcionPacman.PERCEPCION_COMIDA;
        mundo[3] = PercepcionPacman.PERCEPCION_ENEMIGO;
        mundo[8] = PercepcionPacman.PERCEPCION_ENEMIGO;
        mundo[7] = PercepcionPacman.PERCEPCION_COMIDA;
    }
    
    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        int pos = 0;
        
        str.append("[ \n");
        for (int fil = 0; fil < this.tamaño_mundo; fil++) {
            str.append("[ ");
            for (int col = 0; col < this.tamaño_mundo; col++) {
            	str.append(mundo[pos] + " ");
            	pos++;
            }
            str.append(" ]\n");
        }
        str.append(" ]");

        return str.toString();
    }

    // Estos métodos son internos de la clase EstadoAmbiente.
//    public int[][] getMundo() {
//        return mundo;
//    }
//
//    public void setMundo(int[][] mundo) {
//        this.mundo = mundo;
//    }
//
//    public void setMundo(int fil, int col, int valor) {
//        this.mundo[fil][col] = valor;
//    }
    
    public void setMundo(int pos, int valor) {
    	this.mundo[pos] = valor;
    }
    
    public int getMundo(int pos) {
    	return this.mundo[pos];
    }

    public int getArriba(int pos) {
        if (pos >= 0 && pos < this.tamaño_mundo) {
            return mundo[pos + this.tamaño_mundo * (this.tamaño_mundo - 1)];
        }
        return mundo[pos - this.tamaño_mundo];
    }

    public int getIzquierda(int pos) {
    	if (pos % this.tamaño_mundo == 0) {
            return mundo[pos + (this.tamaño_mundo - 1)];
        }
        return mundo[pos - 1];
    }

    public int getDerecha(int pos) {
    	if (pos % this.tamaño_mundo == this.tamaño_mundo - 1) {
            return mundo[pos - (this.tamaño_mundo - 1)];
        }
        return mundo[pos + 1];
    }

    public int getAbajo(int pos) {
    	if (pos < this.tamaño_mundo * this.tamaño_mundo &&
    			pos >= this.tamaño_mundo * (this.tamaño_mundo - 1)) {
            return mundo[pos - this.tamaño_mundo * (this.tamaño_mundo - 1)];
        }
        return mundo[pos + this.tamaño_mundo];
    }
}
