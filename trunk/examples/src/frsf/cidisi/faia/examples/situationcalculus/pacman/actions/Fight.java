/*
 * Copyright 2007-2009 Georgina Stegmayer, Milagros Gutiérrez, Jorge Roa,
 * Luis Ignacio Larrateguy y Milton Pividori.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package frsf.cidisi.faia.examples.situationcalculus.pacman.actions;

import frsf.cidisi.faia.agent.situationcalculus.SituationCalculusAction;
import frsf.cidisi.faia.state.AgentState;
import frsf.cidisi.faia.state.EnvironmentState;
import frsf.cidisi.faia.examples.situationcalculus.pacman.PacmanLogicEnvironmentState;
import frsf.cidisi.faia.examples.situationcalculus.pacman.PacmanLogicAgentState;
import frsf.cidisi.faia.examples.situationcalculus.pacman.PacmanLogicPerception;

public class Fight extends SituationCalculusAction {

    @Override
    public EnvironmentState execute(AgentState ast, EnvironmentState est) {
        PacmanLogicEnvironmentState environmentState =
                (PacmanLogicEnvironmentState) est;
        PacmanLogicAgentState agentState = ((PacmanLogicAgentState) ast);

        int row = environmentState.getAgentPosition()[0];
        int col = environmentState.getAgentPosition()[1];

        if ((environmentState.getWorld()[row][col] == 1) &&
                (environmentState.getAgentEnergy() > 30)) {
            environmentState.setWorld(row, col, PacmanLogicPerception.EMPTY_PERCEPTION);
            
            return environmentState;
        }

        return null;
    }

    @Override
    public String toString() {
        return "fight";
    }
}
