package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Data {

    private Conexion con;
    private ResultSet rs;

    public Data() throws ClassNotFoundException, SQLException {
        con = new Conexion("bdPalabras");
    }

    // iniciar Sesión
    public String getNombre(String run, String password) throws SQLException {
        String nombre = null;

        String select = "SELECT nombre FROM usuario WHERE run = '" + run + "' AND password = '" + password + "';";
        ResultSet rs = con.ejecutar(select);

        // while(rs.next){} --> 
        if (rs.next()) {
            nombre = rs.getString(1);
        }
        con.close();

        return nombre;
    }

    public void validateRun(Usuario u) throws SQLException {

        String select;

        select = "CALL existeuser('" + u.getRun() + "','" + u.getNombre() + "','" + u.getPassword() + "');";
        ResultSet rs = con.ejecutar(select);
    }

    public void createUser(Usuario u) throws SQLException {
        String insert = "INSERT INTO usuario VALUES(NULL,'" + u.getRun() + "','" + u.getNombre() + "','" + u.getPassword() + "');";
        con.ejecutar(insert);
    }

    public void crearPalabra(Palabra p) throws SQLException {
        con.ejecutar("INSERT INTO significado VALUES(NULL,'" + p.getSignificado() + "');");
        con.ejecutar("INSERT INTO palabra VALUES(NULL,'" + p.getNombre() + "',(SELECT MAX(id) FROM significado));");
    }

    public List<Palabra> getPalabras() throws SQLException {

        Palabra p;
        List<Palabra> listaPalabras = new ArrayList();
        
        rs = con.ejecutar("SELECT descripcionSignificado, nombre "
                + "FROM significado "
                + "INNER JOIN palabra ON significado.id = palabra.fk_significado;");
        while (rs.next()) {
            p = new Palabra();
            p.setNombre(rs.getString(1));
            p.setSignificado(rs.getString(2));
            listaPalabras.add(p);
        }
        return listaPalabras;
    }

}
