package model;

import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;

public class TMPalabra extends AbstractTableModel {

    private List<Palabra> lista= new ArrayList<>();

    public TMPalabra(List<Palabra> lista) {
        this.lista = lista;
    }

    @Override
    public int getRowCount() {
        return lista.size();

    }

    @Override
    public int getColumnCount() {
        return 2;
    }

    @Override
    public String getColumnName(int column) {
        if (column == 1) {
            return "Nombre";
        }
        if (column == 2) {
            return "Significado";

        }else{
            return null;
        }

    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {

        Palabra p = lista.get(rowIndex);

        if (columnIndex == 1) {
            return p.getNombre();
        }
        if (columnIndex == 2) {
            return p.getSignificado();

        }else{
            return null;
        }

    }
}
