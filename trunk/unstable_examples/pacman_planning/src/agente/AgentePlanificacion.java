package agente;

import java.util.logging.Level;
import java.util.logging.Logger;

import frsf.cidisi.faia.agent.Action;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.agent.planning.PlanningAction;
import frsf.cidisi.faia.agent.planning.PlanningBasedAgent;
import frsf.cidisi.faia.exceptions.PrologConnectorException;
import frsf.cidisi.faia.solver.planning.Planning;
import frsf.cidisi.faia.state.AgentState;

public class AgentePlanificacion extends PlanningBasedAgent {
	
	public AgentePlanificacion() throws PrologConnectorException {
    	EstadoPacman estado = new EstadoPacman();
    	this.setAgentState(estado);
    }
	
	@Override
	public void see(Perception p) {
		this.getAgentState().updateState(p);
	}

	@Override
	public Action selectAction() {
        Planning planning = new Planning();
        this.setSolver(planning);

        // Se ejecuta el proceso de seleccion de la accion mas adecuada.
        Action accionSeleccionada = null;
        try {
            accionSeleccionada =
                    this.getSolver().solve(new Object[]{this});
        } catch (Exception ex) {
            Logger.getLogger(AgentePlanificacion.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Retorna la accion seleccionada.
        return accionSeleccionada;
	}
	
	@Override
	public EstadoPacman getAgentState() {
		EstadoPacman estado = (EstadoPacman) super.getAgentState();
		
		return estado;
	}

//	@Override
//	public void tell(PlanningAction action) {
//		EstadoPacman estado = this.getAgentState();
//		
//		estado.
//	}

}
