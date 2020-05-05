import java.sql.*;
import java.util.Date;
import java.util.Arrays;
import java.util.List;

public class Assignment2 {

   // A connection to the database
   Connection connection;

   // Can use if you wish: seat letters
   List<String> seatLetters = Arrays.asList("A", "B", "C", "D", "E", "F");

   Assignment2() throws SQLException {
      try {
         Class.forName("org.postgresql.Driver");
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      }
   }

  /**
   * Connects and sets the search path.
   *
   * Establishes a connection to be used for this session, assigning it to
   * the instance variable 'connection'.  In addition, sets the search
   * path to 'air_travel, public'.
   *
   * @param  url       the url for the database
   * @param  username  the username to connect to the database
   * @param  password  the password to connect to the database
   * @return           true if connecting is successful, false otherwise
   */
   public boolean connectDB(String URL, String username, String password) {
      // Implement this method!
      try {
         connection = DriverManager.getConnection(URL, username, password);
         PreparedStatement setPath = connection.prepareStatement("SET search_path TO air_travel;");
         setPath.execute();
         return true;
      } catch (SQLException ex) {
         return false;
      }
   }

  /**
   * Closes the database connection.
   *
   * @return true if the closing was successful, false otherwise
   */
   public boolean disconnectDB() {
      // Implement this method!
      try {
         connection.close();
         return true;
      } catch (SQLException ex) {
         return false;
      }
   }
   
   /* ======================= Airline-related methods ======================= */

   /**
    * Attempts to book a flight for a passenger in a particular seat class. 
    * Does so by inserting a row into the Booking table.
    *
    * Read handout for information on how seats are booked.
    * Returns false if seat can't be booked, or if passenger or flight cannot be found.
    *
    * 
    * @param  passID     id of the passenger
    * @param  flightID   id of the flight
    * @param  seatClass  the class of the seat (economy, business, or first) 
    * @return            true if the booking was successful, false otherwise. 
    */
   public boolean bookSeat(int passID, int flightID, String seatClass) {
      // Implement this method!
      try{
         boolean successful =  false ;
         int cCapacity = classCapacity(flightID , seatClass);
         int curRow = cCapacity/6;
         int curLetter = cCapacity%6;
         int fMax = mCapacity(flightID,"first");
         int bMax = mCapacity(flightID,"business");
         int eMax = mCapacity(flightID,"economy");

         //starting row numbers 
         int fcRows = 1;
         int bcRows = (int) (Math.ceil(((double) 1)/6) + Math.ceil(((double) mCapacity(flightID , "first"))/6));
         int ecRows = (int) (Math.ceil(((double) 1)/6) + Math.ceil(((double) mCapacity(flightID , "business"))/6) + Math.ceil(((double) mCapacity(flightID , "first"))/6));

         // ----------- booking data -------------
         int id = bookingId() + 1;
         int price = getPrice(flightID,seatClass);
         Timestamp dt = getCurrentTimeStamp();
         int row = 0;
         String letter = "";

         if(seatClass == "first"){
            if(cCapacity < fMax){
               row = fcRows + (int) cCapacity/6;
               letter = seatLetters.get(cCapacity % 6);
               insert(id,passID,flightID,dt,price,seatClass,row,letter,false);

               successful = true;
            }
         } else if(seatClass == "business"){
            if(cCapacity < bMax){
               row = bcRows + (int) cCapacity/6;
               letter = seatLetters.get(cCapacity % 6);
               insert(id,passID,flightID,dt,price,seatClass,row,letter,false);
               successful = true;
            }
         } else if(seatClass == "economy"){
            if(cCapacity < eMax){
               row = ecRows + (int) cCapacity/6;
               letter = seatLetters.get(cCapacity % 6);
               insert(id,passID,flightID,dt,price,seatClass,row,letter,false);
               successful = true;
            }
            else if(cCapacity < eMax + 10){
               row = 0; // NEED TO CHANGE TO NULL
               letter = " ";// NEED TO CHANGE TO NULL
               insert(id,passID,flightID,dt,price,seatClass,row,letter,true);
               successful =true;
            }
         }
      return successful;
   } catch(Exception e){
      System.err.println("Exception." + "<Message>:" + e.getMessage());
      return false;
   }
   }


   /**
    * Attempts to upgrade overbooked economy passengers to business class
    * or first class (in that order until each seat class is filled).
    * Does so by altering the database records for the bookings such that the
    * seat and seat_class are updated if an upgrade can be processed.
    *
    * Upgrades should happen in order of earliest booking timestamp first.
    *
    * If economy passengers left over without a seat (i.e. more than 10 overbooked passengers or not enough higher class seats), 
    * remove their bookings from the database.
    * 
    * @param  flightID  The flight to upgrade passengers in.
    * @return           the number of passengers upgraded, or -1 if an error occured.
    */
   public int upgrade(int flightID) {
      // Implement this method!
      try {
         int eCount = classCapacity(flightID , "economy");
         int eMax = mCapacity(flightID, "economy");
         int overbooked = eCount - eMax;
         int upgraded = 0;

         int bLeft = mCapacity(flightID, "business") - classCapacity(flightID , "business");
         int fLeft = mCapacity(flightID, "first") - classCapacity(flightID , "first");
         
         while (bLeft > 0 && overbooked > 0) {
            // function to take earliest economy booking with null seat and change it to a business booking
            upgradeSeat(flightID, "business");
            bLeft -= 1;
            overbooked -= 1;
            upgraded += 1;
         }

         while (fLeft > 0 && overbooked > 0) {
            // function to take earliest economy booking with null seat and change it to a first class booking
            upgradeSeat(flightID, "first");
            fLeft -= 1;
            overbooked -= 1;
            upgraded += 1;
         }

         removeOverbooked(flightID); // function to remove any records from that flightID with seat row/letter as null
         return upgraded;
      } catch(Exception e) {
         System.err.println("Exception. " + "<Message>: " + e.getMessage());
      }
      return -1;
   }


   /* ----------------------- Helper functions below  ------------------------- */

    // A helpful function for adding a timestamp to new bookings.
    // Example of setting a timestamp in a PreparedStatement:
    // ps.setTimestamp(1, getCurrentTimeStamp());

    /**
    * Returns a SQL Timestamp object of the current time.
    * 
    * @return           Timestamp of current time.
    */
   private java.sql.Timestamp getCurrentTimeStamp() {
      java.util.Date now = new java.util.Date();
      return new java.sql.Timestamp(now.getTime());
   }

   // Add more helper functions below if desired.

   //finds current number of booked seats in that class in a flight
   public int classCapacity(int flightID, String seatClass ){
      int count = -1;
      try{
         //executing query
         String q = "select count(*) from booking where flight_id = ? and seat_class = ?::seat_class;";
         PreparedStatement s = connection.prepareStatement(q);
         s.setInt(1,flightID);
         s.setString(2,seatClass);
         ResultSet countResult = s.executeQuery();
         while (countResult.next()) {            
            count = countResult.getInt("count");
        }
      }catch(SQLException e){
         System.err.println("SQL Exception." + "<Message>:" + e.getMessage());
      }
      return count;
   }

      // finds the capacity of the plane for that seat class
   public int mCapacity(int flightID, String seatClass) {
         try {
             String q = "WITH t_nums AS" +
                         "(SELECT plane AS tail_number FROM flight WHERE id = ?)" +
                         "SELECT capacity_" + seatClass + " AS cap FROM t_nums NATURAL JOIN plane;";
     
                 // returns the specified capacity of that plane type
             PreparedStatement s = connection.prepareStatement(q);
             s.setInt(1,flightID);
             ResultSet cap = s.executeQuery();
             int capacity = 0;
             while (cap.next()) {
                 capacity = cap.getInt("cap");
             }
             return capacity;
         } catch(SQLException e) {
             System.err.println("SQL Exception." + "<Message>:" + e.getMessage()); 
         }
         return -1;
   }
   
   // finds last booking id
   public int bookingId(){
      int id = -1;
      try {
         String q = "select id from booking order by id  desc limit 1 ;";
         PreparedStatement s = connection.prepareStatement(q);
         ResultSet cap = s.executeQuery();
         while (cap.next()) {
             id = cap.getInt("id");
         }
     } catch(SQLException e) {
         System.err.println("SQL Exception." + "<Message>:" + e.getMessage()); 
     }
     return id;
   }

   public int getPrice(int flightID, String seatClass) {
      try {
         String q = "SELECT " + seatClass + " AS price FROM price WHERE flight_id =?;";
         PreparedStatement s = connection.prepareStatement(q);
         s.setInt(1,flightID);
         ResultSet p = s.executeQuery();
         int price = -1;

         while (p.next()) {
            price = p.getInt("price");
         }
         return price;

      } catch(SQLException e) {
         System.err.println("SQL Exception." + "<Message>:" + e.getMessage()); 
      }
      return -1;
   }

   // inserts into the booking table;
   public void insert(int id, int pass_id, int flight_id, Timestamp datetime, int price,
                        String seat_class,int seat_row, String seat_letter, boolean isOverbooked){
         try{
            String q = "INSERT  INTO booking values(?,?,?,?,?,?::seat_class,?,?);";
            PreparedStatement s = connection.prepareStatement(q);
            s.setInt(1,id);
            s.setInt(2,pass_id);
            s.setInt(3,flight_id);
            s.setTimestamp( 4,getCurrentTimeStamp() );
            s.setInt(5,price);
            s.setString(6,seat_class);
            if (!isOverbooked) {
               s.setInt(7,seat_row);
               s.setString(8,seat_letter);
            } else {
               String letter = (String) null;
               s.setNull(7,java.sql.Types.INTEGER);
               s.setString(8,letter);
            }
            s.executeUpdate();
         }
         catch(SQLException e) {
             System.err.println("SQL Exception." + "<Message>:" + e.getMessage()); 
         }
         
   }

   public void removeOverbooked(int flightID) {
      try {
         String q = " DELETE FROM booking WHERE flight_id = ? and row is NULL and letter is NULL;";
         PreparedStatement s = connection.prepareStatement(q);
         s.setInt(1, flightID);
         s.executeUpdate();
      } catch(SQLException e) {
         System.err.println("SQL Exception. " + "<Message>: " + e.getMessage()); 
      }
   }

   public void upgradeSeat(int flightID, String seatClass) {
      try {
         int seatsUsed = classCapacity(flightID , seatClass);
         int row = 0;
         if (seatClass == "first") {
            row = (int) (Math.ceil(((double) seatsUsed + 1)/6));
         } else if (seatClass == "business") {
            row = (int) (Math.ceil(((double) seatsUsed + 1)/6) + Math.ceil(((double) mCapacity(flightID , "first"))/6));
         }
         String col = seatLetters.get(seatsUsed%6);
         String q = "UPDATE booking SET seat_class = ?::seat_class, row = ?, letter = ?" +
         " WHERE datetime = (SELECT datetime FROM booking WHERE flight_id = ? and row is NULL and letter is NULL ORDER BY datetime LIMIT 1);";
         PreparedStatement s = connection.prepareStatement(q);
         s.setString(1, seatClass);
         s.setInt(2, row);
         s.setString(3, col);
         s.setInt(4, flightID);
         s.setInt(5, flightID);
         s.executeUpdate();
      } catch (SQLException e) {
         System.err.println("SQL Exception. " + "<Message>: " + e.getMessage()); 
      }
   }

  /* ----------------------- Main method below  ------------------------- */

   public static void main(String[] args) {
      try{
         Assignment2 a2 = new Assignment2(); 
         boolean connectdb = a2.connectDB("jdbc:postgresql://localhost:5432/csc343h-menonpr7?currentSchema=air_travel", "menonpr7", ""); 
         System.out.println("Running the code!");
            
         a2.disconnectDB();
      }
      catch(SQLException se){
         return;
      }
   }
}
