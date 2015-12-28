package agente;

import java.awt.Point;
import java.util.Iterator;
import java.util.Vector;

import calculador.Calculador;
import calculador.Pair;
import frsf.cidisi.faia.state.EnvironmentState;

public class EstadoAmbiente extends EnvironmentState {

    private int[][] mundo;
    private int orientacionDeLaCabeza;
    private Vector<Point> composicionDelAgente;
    private Calculador calculador;

    EstadoAmbiente(int[][] m, int orientacion, Vector<Point> composicionDelAgente) {
        this.mundo = m;
        this.orientacionDeLaCabeza = orientacion;
        this.composicionDelAgente = composicionDelAgente;
    }

    EstadoAmbiente(Calculador calculador) {
        this.calculador = calculador;
        this.initState();
    }

    public int[][] getMundo() {
        return mundo;
    }

    public void setMundo(int[][] mundo) {
        this.mundo = mundo;
    }

    public void setMundo(int fil, int col, int valor) {
        this.mundo[fil][col] = valor;
    }

    public Object clone() {
        int[][] nuevoMundo = new int[mundo.length][mundo.length];

        for (int fil = 0; fil < this.mundo.length; fil++) {
            for (int col = 0; col < this.mundo.length; col++) {
                nuevoMundo[fil][col] = this.mundo[fil][col];
            }
        }
        EstadoAmbiente nuevoEstado = new EstadoAmbiente(nuevoMundo, this.orientacionDeLaCabeza, this.composicionDelAgente);

        return nuevoEstado;
    }

    public void initState() {
        Pair dimensiones = calculador.getDimensiones();

        this.mundo = new int[dimensiones.x()][dimensiones.y()];

        for (int fil = 0; fil < this.mundo.length; fil++) {
            for (int col = 0; col < this.mundo.length; col++) {
                this.mundo[fil][col] = PercepcionSnake.NO_HAY_NADA;
            }
        }
        Iterator itComida = calculador.getComida().iterator();

        while (itComida.hasNext()) {
            Pair comida = (Pair) itComida.next();

            this.mundo[comida.x() - 1][comida.y() - 1] = PercepcionSnake.COMIDA;
        }

        Pair posicionInicial = calculador.getPosicionInicial();
        this.mundo[posicionInicial.x() - 1][posicionInicial.y() - 1] = PercepcionSnake.PARTE_DEL_AGENTE;

        // Por defecto el agente arranca mirando al Este.
        this.orientacionDeLaCabeza = EstadoSnake.ESTE;

        this.composicionDelAgente = new Vector<Point>();
        this.composicionDelAgente.add(new Point(posicionInicial.x() - 1, posicionInicial.y() - 1));
    }

    public int getNorte() {
        if (this.getCabezaAgente().getX() == 0) {
            return PercepcionSnake.LIMITE_DEL_MUNDO;
        } else {
            return this.mundo[(int) this.getCabezaAgente().getX() - 1][(int) this.getCabezaAgente().getY()];
        }
    }

    public int getOeste() {
        if (this.getCabezaAgente().getY() == 0) {
            return PercepcionSnake.LIMITE_DEL_MUNDO;
        } else {
            return this.mundo[(int) this.getCabezaAgente().getX()][(int) this.getCabezaAgente().getY() - 1];
        }
    }

    public int getEste() {
        if (this.getCabezaAgente().getY() == this.mundo.length - 1) {
            return PercepcionSnake.LIMITE_DEL_MUNDO;
        } else {
            return this.mundo[(int) this.getCabezaAgente().getX()][(int) this.getCabezaAgente().getY() + 1];
        }
    }

    public int getSur() {
        if (this.getCabezaAgente().getX() == this.mundo.length - 1) {
            return PercepcionSnake.LIMITE_DEL_MUNDO;
        } else {
            return this.mundo[(int) this.getCabezaAgente().getX() + 1][(int) this.getCabezaAgente().getY()];
        }
    }

    private Point getCabezaAgente() {
        return this.composicionDelAgente.firstElement();
    }

    public String toString() {
        String str = "";

        str = str + "[ \n";
        for (int fil = 0; fil < this.mundo.length; fil++) {
            str = str + "[ ";
            for (int col = 0; col < this.mundo.length; col++) {
                str = str + this.mundo[fil][col] + " ";
            }
            str = str + " ]\n";
        }
        str = str + " ]";

        return str;
    }

    public boolean equals(Object obj) {

        return true;
    }

    public void moverAlNorte() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX() - 1,
                (int) this.composicionDelAgente.firstElement().getY()), 0);

        Point puntoABorrar = this.composicionDelAgente.remove(this.composicionDelAgente.size() - 1);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
        this.mundo[(int) puntoABorrar.getX()][(int) puntoABorrar.getY()] = EstadoSnake.NO_HAY_NADA;
    }

    public void moverAlSur() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX() + 1,
                (int) this.composicionDelAgente.firstElement().getY()), 0);

        Point puntoABorrar = this.composicionDelAgente.remove(this.composicionDelAgente.size() - 1);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
        this.mundo[(int) puntoABorrar.getX()][(int) puntoABorrar.getY()] = EstadoSnake.NO_HAY_NADA;
    }

    public void moverAlEste() {
        // TODO Ver que pasa si se choca una pared.....??
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX(),
                (int) this.composicionDelAgente.firstElement().getY() + 1), 0);

        Point puntoABorrar = this.composicionDelAgente.remove(this.composicionDelAgente.size() - 1);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
        this.mundo[(int) puntoABorrar.getX()][(int) puntoABorrar.getY()] = EstadoSnake.NO_HAY_NADA;
    }

    public void moverAlOeste() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX(),
                (int) this.composicionDelAgente.firstElement().getY() - 1), 0);

        Point puntoABorrar = this.composicionDelAgente.remove(this.composicionDelAgente.size() - 1);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
        this.mundo[(int) puntoABorrar.getX()][(int) puntoABorrar.getY()] = EstadoSnake.NO_HAY_NADA;
    }

    public int getOrientacionDeLaCabeza() {
        return orientacionDeLaCabeza;
    }

    public void setOrientacionDeLaCabeza(int orientacionDeLaCabeza) {
        this.orientacionDeLaCabeza = orientacionDeLaCabeza;
    }

    public void comerAlNorte() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX() - 1,
                (int) this.composicionDelAgente.firstElement().getY()), 0);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
    }

    public void comerAlSur() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX() + 1,
                (int) this.composicionDelAgente.firstElement().getY()), 0);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
    }

    public void comerAlEste() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX(),
                (int) this.composicionDelAgente.firstElement().getY() + 1), 0);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
    }

    public void comerAlOeste() {
        this.composicionDelAgente.insertElementAt(new Point(
                (int) this.composicionDelAgente.firstElement().getX(),
                (int) this.composicionDelAgente.firstElement().getY() - 1), 0);

        this.mundo[(int) this.composicionDelAgente.firstElement().getX()][(int) this.composicionDelAgente.firstElement().getY()] = EstadoSnake.PARTE_DEL_AGENTE;
    }
}
