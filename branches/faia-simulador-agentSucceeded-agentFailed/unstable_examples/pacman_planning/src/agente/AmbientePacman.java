package agente;

import frsf.cidisi.faia.agent.Agent;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.environment.Environment;
import frsf.cidisi.faia.solver.PrologConnector;

/**
 * Esta clase es muy similar a su correspondiente en el ejemplo 'pacman', basado
 * en búsqueda. Es recomendable mirar los comentarios allí primero.
 */
public class AmbientePacman extends Environment {

    public AmbientePacman() {
        // Se instancia el estado del ambiente.
        this.environmentState = new EstadoAmbiente();
    }
    
    @Override
    public Perception getPercept(Agent agent) {
        // El ambiente crea una percepción que va a ser recibida por el Pacman.
    	// Al crearse la percepcion, esta también se inicializa automáticamente.
        PercepcionPacman p = new PercepcionPacman(agent, this);
        
        // Retorna la nueva percepción creada.-
        return p;
    }
    
    @Override
    public String toString() {
        return environmentState.toString();
    }

    // Este métodos de abajo, son internos de la clase AmbientePacman.
    public int getArriba(int pos) {
        return ((EstadoAmbiente) this.environmentState).getArriba(pos);
    }

    public int getIzquierda(int pos) {
        return ((EstadoAmbiente) this.environmentState).getIzquierda(pos);
    }

    public int getDerecha(int pos) {
        return ((EstadoAmbiente) this.environmentState).getDerecha(pos);
    }

    public int getAbajo(int pos) {
        return ((EstadoAmbiente) this.environmentState).getAbajo(pos);
    }
}
