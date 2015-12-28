package agente;

import frsf.cidisi.faia.exceptions.PrologConnectorException;
import frsf.cidisi.faia.simulator.GoalBasedAgentSimulator;
import frsf.cidisi.faia.simulator.SituationCalculusBasedAgentSimulator;
import frsf.cidisi.faia.simulator.PlanningBasedAgentSimulator;

public class Pacman {

    /**
     * @param args
     */
    public static void main(String[] args) throws PrologConnectorException {
        AgentePlanificacion pacman = new AgentePlanificacion();

        AmbientePacman ambiente = new AmbientePacman();

        PlanningBasedAgentSimulator simu = new PlanningBasedAgentSimulator(ambiente, pacman);

        simu.start();
    }
}
