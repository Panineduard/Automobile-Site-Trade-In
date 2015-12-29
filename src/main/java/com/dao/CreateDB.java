package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Эдуард on 12.08.15.
 */
public class CreateDB {
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
    private static void createDb() throws SQLException {
        String createDb="                CREATE TABLE \"dealer\"(" +
                "                        numberDealer INTEGER NOT NULL ," +
                "                        idDealer INTEGER NOT NULL , CONSTRAINT \"persAc\"PRIMARY KEY (idDealer)," +
                "                        nameDealer VARCHAR (60)  NOT NULL );"+
                
                                        "CREATE TABLE \"Login\"(" +
                "                        userName VARCHAR (30)NOT NULL ," +
                "                        idDeal INTEGER NOT NULL ," +
                "                        CONSTRAINT \"log\" PRIMARY KEY (idDeal)," +
                "                        CONSTRAINT \"perID\" FOREIGN KEY (idDeal) REFERENCES \"dealer\" (idDealer)," +
                "                        Password VARCHAR (50)NOT NULL ); "+
//
//
                "                        CREATE TABLE \"Contact_person\"(" +
                "                        userID INTEGER NOT NULL, CONSTRAINT \"PeopleId\"  PRIMARY KEY (userID), " +
                "                        name VARCHAR(30) NOT NULL, " +
                "                        firstname VARCHAR(30) NOT NULL," +
                "                        lastname VARCHAR(30) NOT NULL," +
                "                        phone VARCHAR(50) NOT NULL," +
                "                        Email VARCHAR(50));" +

                "                        CREATE TABLE \"Cars\"("  +
                "                        carID INTEGER NOT NULL, CONSTRAINT \"carId\"  PRIMARY KEY (carID)," +
                "                        brand VARCHAR(30) NOT NULL, " +
                "                        model VARCHAR(30) NOT NULL," +
                "                        engine_Capacity VARCHAR(30) NOT NULL," +
                "                        releaseDate VARCHAR(50) NOT NULL," +
                "                        price FLOAT Not null," +
                "                        mileage INTEGER," +
                "                        description VARCHAR(50) );" +

                "                        CREATE TABLE \"Adress\"(" +
                "                        idDealer1 INTEGER NOT NULL ,CONSTRAINT \"delID\" PRIMARY KEY (idDealer1)," +
                "                        CONSTRAINT \"flID\"FOREIGN KEY (idDealer1) REFERENCES \"dealer\" (idDealer)" +
                "                        MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE ," +
                "                        street VARCHAR (30)NOT NULL ," +
                "                        city VARCHAR (30)NOT NULL ," +
                "                        namberHouse INTEGER NOT NULL );"
                 ;
        Connection connection = getDbConnection();
        Statement st = connection.createStatement();
        st.execute(createDb);
        st.close();
        connection.close();


    }
    public static void main(String...args) throws SQLException {
        createDb();

    }
}
