package agente;

import viborita.Avanzar;
import viborita.Comer;
import viborita.GirarDerecha;
import viborita.GirarIzquierda;
import frsf.cidisi.faia.agent.Action;
import frsf.cidisi.faia.solver.ActionFactory;

public class CalculusAccion extends ActionFactory {

    private static CalculusAccion instancia;

    private CalculusAccion() {
    }

    public static CalculusAccion getInstance() {
        if (instancia == null) {
            instancia = new CalculusAccion();
        }
        return instancia;
    }

    @Override
    public Action makeActionFromString(String stringAction) {
        if (stringAction.equals("avanzar")) {
            return new Avanzar();
        } else if (stringAction.equals("comer")) {
            return new Comer();
        } else if (stringAction.equals("girarIzquierda")) {
            return new GirarIzquierda();
        } else if (stringAction.equals("girarDerecha")) {
            return new GirarDerecha();
        }
        return null;
    }
}
