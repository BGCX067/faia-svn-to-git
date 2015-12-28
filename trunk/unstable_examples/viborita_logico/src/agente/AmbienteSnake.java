package agente;

import calculador.Calculador;
import frsf.cidisi.faia.agent.Agent;
import frsf.cidisi.faia.agent.Perception;
import frsf.cidisi.faia.environment.Environment;

public class AmbienteSnake extends Environment {

    private Calculador calculador;

    public AmbienteSnake(Calculador calculador) {
        this.calculador = calculador;
        this.environmentState = new EstadoAmbiente(this.calculador);
    }

    @Override
    public Perception getPercept(Agent agent) {
        //		 El ambiente crea una percepción que va a ser recibida por el Snake.- 
        PercepcionSnake p = new PercepcionSnake();

        // Es necesario realizar un "cast" para acceder a los métodos del agente Snake.- 
        //AgenteSnake snake = (AgenteCalculus)agent;

        // Asigna las percepciones en los sensores.-
        p.setSensorNorte(this.getNorte());
        p.setSensorOeste(this.getOeste());
        p.setSensorEste(this.getEste());
        p.setSensorSur(this.getSur());

        // Retorna la nueva percepción creada.-
        return p;
    }

    public int getNorte() {
        return ((EstadoAmbiente) this.environmentState).getNorte();
    }

    public int getOeste() {
        return ((EstadoAmbiente) this.environmentState).getOeste();
    }

    public int getEste() {
        return ((EstadoAmbiente) this.environmentState).getEste();
    }

    public int getSur() {
        return ((EstadoAmbiente) this.environmentState).getSur();
    }

    public String toString() {
        return environmentState.toString();
    }
}
