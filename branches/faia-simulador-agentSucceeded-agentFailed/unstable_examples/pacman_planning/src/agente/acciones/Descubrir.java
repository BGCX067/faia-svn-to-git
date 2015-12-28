package agente.acciones;

import frsf.cidisi.faia.agent.planning.PlanningAction;
import frsf.cidisi.faia.state.AgentState;
import frsf.cidisi.faia.state.EnvironmentState;

public class Descubrir extends PlanningAction {
	
	@Override
	public EnvironmentState execute(AgentState ast, EnvironmentState est) {
		return est;
	}

	@Override
	public String toString() {
		return "Descubrir";
	}

}
