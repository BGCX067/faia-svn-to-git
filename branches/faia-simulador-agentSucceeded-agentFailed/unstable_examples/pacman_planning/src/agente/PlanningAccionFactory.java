package agente;

import agente.acciones.Comer;
import agente.acciones.Avanzar;
import agente.acciones.Descubrir;
import agente.acciones.Pelear;
import frsf.cidisi.faia.agent.Action;
import frsf.cidisi.faia.solver.ActionFactory;

/**
 * Cuando el Solver (en este caso la clase Calculus) pide la mejor acción
 * al agente (ver el método solve()), recibe de la base de conocimiento
 * un string que representa a la acción elegida. Sin embargo, el método
 * solve debe devolver un *objeto* Action.
 * Esta clase es utilizada para transformar un string en un objeto acción, y
 * debe ser implementada por el usuario.
 * Se utiliza el patrón Singleton.
 */
public class PlanningAccionFactory extends ActionFactory {
	
    private static PlanningAccionFactory instancia;

    private PlanningAccionFactory() {
    }

    public static PlanningAccionFactory getInstance() {
        if (instancia == null) {
            instancia = new PlanningAccionFactory();
        }
        return instancia;
    }

    /**
     * El método es sencillo: recibe un string y devuelve un objeto
     * Action, dependiendo del valor de ese string.
     */
    @Override
    public Action stringToAction(String stringAction) {
    	if (stringAction.startsWith("avanzar")) {
            return new Avanzar();
    	} else if (stringAction.startsWith("descubrir")) {
    		return new Descubrir();
        } else if (stringAction.startsWith("comer")) {
            return new Comer();
        } else if (stringAction.startsWith("pelear")) {
            return new Pelear();
        }
        return null;
    }

    /** Retornamos el string que utilizamos en 'base_conocimiento.pl'
     * (el archivo prolog) en el predicado mejorAccion cuando se ha
     * cumplido el objetivo.
     * Esta es la línea donde, en el ejemplo, se utiliza una acción
     * tipo 'noAccion' para indicar que hemos llegado al objetivo:
     * 
     *   mejorAccion(noAccion,S):-cumplioObjetivo(S),!.
     *   
     */
    @Override
    public String endActionString() {
        return "end";
    }
}
