package frsf.cidisi.faia.examples.matlab.simple_water_tank;

import frsf.cidisi.faia.agent.Action;
import java.util.Hashtable;
import frsf.cidisi.faia.agent.Agent;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.environment.MatlabEnvironment;

public class SimpleWaterTankEnvironment extends MatlabEnvironment {

    private static final double TANK_AREA = 40.0;
    private static final double UNLOAD_RESTRICTION = 0.5; // TODO: Quiza traducir "Restricción de descarga"

    public SimpleWaterTankEnvironment() {
        super();

        this.environmentState = new SimpleWaterTankEnvironmentState();
    }

    @Override
    public SimpleWaterTankEnvironmentState getEnvironmentState() {
        return (SimpleWaterTankEnvironmentState) super.getEnvironmentState();
    }

    @Override
    public Perception getPercept() {
        WaterTankPerception perception = new WaterTankPerception();

        Hashtable<String, double[][]> simulationReturn;

        // Start simulation
        simulationReturn = this.startSimulation();

        double[][] h = simulationReturn.get("h");

        SimpleWaterTankEnvironmentState environmentState =
                this.getEnvironmentState();

        environmentState.setTankHeight(h[h.length - 1][0]);
        // Change start and end time for the next simulation
        environmentState.nextTime();

        perception.setTankHeight(this.getEnvironmentState().getTankHeight());
        perception.setTime(this.getEnvironmentState().getStartTime());
        perception.setVolumeFlow(this.getEnvironmentState().getVolumeFlow());

        return perception;
    }

    public double getTankHeight() {
        return this.getEnvironmentState().getTankHeight();
    }

    @Override
    public String getMatlabProjectPath() {
        return "matlab_modelo_tanques";
    }

    @Override
    public String toString() {
        return this.getEnvironmentState().toString();
    }

    @Override
    public Object[] getMatlabFunctionParameters() {
        SimpleWaterTankEnvironmentState environmentState =
                this.getEnvironmentState();

        return new Object[]{
                    TANK_AREA,
                    UNLOAD_RESTRICTION,
                    environmentState.getTankHeight(),
                    environmentState.getVolumeFlow(),
                    environmentState.getStartTime(),
                    environmentState.getEndTime()
                };
    }

    @Override
    protected String getMatlabFunctionName() {
        return "TK_1_L";
    }

    @Override
    protected Object[] getMatlabFunctionReturnVariables() {
        return new Object[]{
                    "t",
                    "h"
                };
    }
}
