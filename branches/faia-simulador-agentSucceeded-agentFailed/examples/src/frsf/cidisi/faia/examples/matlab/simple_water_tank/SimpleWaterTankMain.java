package frsf.cidisi.faia.examples.matlab.simple_water_tank;

import frsf.cidisi.faia.simulator.ReactiveBasedAgentSimulator;

public class SimpleWaterTankMain {

    public static void main(String[] args) {
        SimpleWaterTankAgent agent = new SimpleWaterTankAgent();

        SimpleWaterTankEnvironment environment =
                new SimpleWaterTankEnvironment();

        TimeBasedSimulator simulator =
                new TimeBasedSimulator(environment, agent);

        simulator.start();
    }
}
