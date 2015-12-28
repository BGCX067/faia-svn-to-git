package frsf.cidisi.faia.examples.matlab.simple_water_tank;

import frsf.cidisi.faia.agent.Action;
import frsf.cidisi.faia.examples.matlab.simple_water_tank.actions.ChangeVolumeFlow;
import frsf.cidisi.faia.solver.Solve;

public class ReactiveSolver extends Solve {

    @Override
    public void showSolution() {
        // TODO Auto-generated method stub
    }

    @Override
    public Action solve(Object[] params) throws Exception {
        SimpleWaterTankAgentState estadoTanque =
                (SimpleWaterTankAgentState) params[0];

        double newVolumeFlow =
                estadoTanque.getVolumeFlow();

        if (estadoTanque.getTankHeight() > 30) {
            newVolumeFlow = 0.50 + newVolumeFlow * 0.90;
        } else if (estadoTanque.getTankHeight() < 30) {
            newVolumeFlow = 0.50 + newVolumeFlow * 1.10;
        }

        Action action = new ChangeVolumeFlow(newVolumeFlow);

        return action;
    }
}
