package agente;

import java.util.Vector;

import frsf.cidisi.faia.agent.Agent;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.environment.Environment;

public class PercepcionPacman extends Perception {

    public static final int PERCEPCION_DESCONOCIDO = -1;
    public static final int PERCEPCION_VACIO = 0;
    public static final int PERCEPCION_ENEMIGO = 1;
    public static final int PERCEPCION_COMIDA = 2;
    private int sensorIzquierda;
    private int posIzquierda;
    private int sensorArriba;
    private int posArriba;
    private int sensorDerecha;
    private int posDerecha;
    private int sensorAbajo;
    private int posAbajo;
    private int energia;
    private int posPacman;

//    public PercepcionPacman() {
//        energia = 50;
//    }

    public PercepcionPacman(Agent agent, Environment environment) {
        super(agent, environment);
    }

    public void initPerception(Agent agent, Environment environment) {
        AgentePlanificacion pacman = (AgentePlanificacion) agent;
        EstadoPacman estadoPacman = pacman.getAgentState();
        AmbientePacman ambiente = (AmbientePacman) environment;

        this.posPacman = pacman.getAgentState().getPosicion();
        
        // TODO: Falta la energía
        
        this.sensorArriba = ambiente.getArriba(this.posPacman);
        this.posArriba = estadoPacman.getCeldaArriba(this.posPacman);
        
        this.sensorIzquierda = ambiente.getIzquierda(this.posPacman);
        this.posIzquierda = estadoPacman.getCeldaIzquierda(this.posPacman);
        
        this.sensorDerecha = ambiente.getDerecha(this.posPacman);
        this.posDerecha = estadoPacman.getCeldaDerecha(this.posPacman);
        
        this.sensorAbajo = ambiente.getAbajo(this.posPacman);
        this.posAbajo = estadoPacman.getCeldaAbajo(this.posPacman);
    }

    public int getSensorIzquierda() {
        return sensorIzquierda;
    }

    public void setSensorIzquierda(int sensorIzquierda) {
        this.sensorIzquierda = sensorIzquierda;
    }

    public int getSensorArriba() {
        return sensorArriba;
    }

    public void setSensorArriba(int sensorArriba) {
        this.sensorArriba = sensorArriba;
    }

    public int getSensorDerecha() {
        return sensorDerecha;
    }

    public void setSensorDerecha(int sensorDerecha) {
        this.sensorDerecha = sensorDerecha;
    }

    public int getSensorAbajo() {
        return sensorAbajo;
    }

    public void setSensorAbajo(int sensorAbajo) {
        this.sensorAbajo = sensorAbajo;
    }

    public int getEnergia() {
        return energia;
    }

    public void setEnergia(int energia) {
        this.energia = energia;
    }

    private String convertirEstadoCelda(int estadoCelda) {
        String resultado = null;

        switch (estadoCelda) {
            case PercepcionPacman.PERCEPCION_COMIDA:
                resultado = "comida";
                break;
            case PercepcionPacman.PERCEPCION_ENEMIGO:
                resultado = "enemigo";
                break;
            case PercepcionPacman.PERCEPCION_VACIO:
                resultado = "vacio";
                break;
        }

        return resultado;
    }

    public Vector<String> toPrologPredicates() {
    	Vector<String> resultados = new Vector<String>();
        
        // Celdas adyacentes
        resultados.add(this.convertirEstadoCelda(this.sensorArriba) + "(" +
        		this.posArriba +
        		")");
        
        resultados.add(this.convertirEstadoCelda(this.sensorDerecha) + "(" +
        		this.posDerecha +
        		")");
        
        resultados.add(this.convertirEstadoCelda(this.sensorAbajo) + "(" +
        		this.posAbajo +
        		")");
        
        resultados.add(this.convertirEstadoCelda(this.sensorIzquierda) + "(" +
        		this.posIzquierda +
        		")");

        // TODO: Energía del agente
//        cadena.append(this.getEnergia());
//        cadena.append(",");

        return resultados;
    }
}
