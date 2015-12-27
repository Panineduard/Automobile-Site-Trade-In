package dao;

import modelClass.Dealer;

import java.sql.*;

/**
 * Created by Эдуард on 30.08.15.
 */
public class InputDB_Data {
    private static String ADDRES = "jdbc:postgresql://localhost:5432/ALL_Cars";
    private static String NAME = "postgres";
    private static String PASWORD = "123";
    private static Connection getDbConnection() {
        Connection dbConnection = null;
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        try {
            dbConnection = DriverManager.getConnection(ADDRES, NAME, PASWORD);
            return dbConnection;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return dbConnection;
    }
//    public boolean inputDealer(Dealer dealer)throws SQLException{
//
//            boolean flagRepeat = true;
//
//            Connection dbConnection = getDbConnection();
//            String searchSQL = "SELECT 1 FROM \"dealer\" WHERE iddealer = ?;"; //"SELECT 1 FROM \"People\" where userid = ?;"
//            PreparedStatement ps4 =dbConnection.prepareStatement(searchSQL);
//          //  ps4.setInt(1,dealer.getIdDealer());
//            ResultSet resultSet = ps4.executeQuery();
//
//            while (resultSet.next()) {
//                System.out.println("User already exists!");
//                flagRepeat = false;
//            }
//            if (flagRepeat) {
//                PreparedStatement ps = dbConnection.prepareStatement("INSERT INTO \"dealer\" (numberdealer,iddealer,namedealer)" +
//                        "VALUES (?,?,?)");
//                ps.setInt(1, dealer.getNumberDealer());
//               // ps.setInt(2, dealer.getIdDealer());
//                ps.setString(3, dealer.getNameDealer());
//                ps.execute();
//                ps.close();
//                System.out.println("Successfully added!");
//            }
//            dbConnection.close();
//            resultSet.close();
//            ps4.close();
//            return flagRepeat;
//    }

}
