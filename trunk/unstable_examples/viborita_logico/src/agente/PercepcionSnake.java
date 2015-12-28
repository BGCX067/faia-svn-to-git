package agente;

import frsf.cidisi.faia.agent.Agent;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.environment.Environment;

public class PercepcionSnake extends Perception {

    public static int NO_HAY_NADA = 0;
    public static int LIMITE_DEL_MUNDO = 1;
    public static int COMIDA = 2;
    public static int PARTE_DEL_AGENTE = 3;
    public static int DESCONOCIDO = -1;
    private int sensorOeste;
    private int sensorNorte;
    private int sensorEste;
    private int sensorSur;

    public PercepcionSnake() {
    }

    public PercepcionSnake(Agent agent, Environment environment) {
        super(agent, environment);
    }

    @Override
    public void initPerception(Agent agent, Environment environment) {
        AmbienteSnake ambiente = (AmbienteSnake) environment;

        this.setSensorNorte(ambiente.getNorte());
        this.setSensorOeste(ambiente.getOeste());
        this.setSensorEste(ambiente.getEste());
        this.setSensorSur(ambiente.getSur());
    }

    public int getSensorSur() {
        return sensorSur;
    }

    public void setSensorSur(int sensorAbajo) {
        this.sensorSur = sensorAbajo;
    }

    public int getSensorNorte() {
        return sensorNorte;
    }

    public void setSensorNorte(int sensorArriba) {
        this.sensorNorte = sensorArriba;
    }

    public int getSensorEste() {
        return sensorEste;
    }

    public void setSensorEste(int sensorDerecha) {
        this.sensorEste = sensorDerecha;
    }

    public int getSensorOeste() {
        return sensorOeste;
    }

    public void setSensorOeste(int sensorIzquierda) {
        this.sensorOeste = sensorIzquierda;
    }
}
