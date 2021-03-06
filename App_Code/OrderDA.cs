﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for OrderDA
/// </summary>
public class OrderDA
{
    public static string connStr1 = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    public static SqlConnection conn1 = new SqlConnection(connStr1);

    public static void AddNewOrder(Order theOrder)
    {

        try
        {
            conn1.Open();
            //the action that writes to Order table
            //insertCommand.ExecuteNonQuery();
            //get order number
            int ID;
            string insertStatement = "INSERT INTO ORDERS (Username, subtotal, discount, tax, total) values (@userName, @subtotal, @discount, @tax,@total);SELECT CAST(scope_identity() AS int)";
            //string insertStatement = "INSERT INTO ORDERS (Username, subtotal, tax, total) values (@userName, @subtotal,@tax,@total)";
            //string query2 = "Select @@Identity";
            //string selectStatement = "SELECT IDENT_CURRENT('OrderId') FROM Orders";
            using (SqlCommand insertCommand = new SqlCommand(insertStatement, conn1))
            {
                insertCommand.Parameters.AddWithValue("@userName", theOrder.UserName);
                insertCommand.Parameters.AddWithValue("@subtotal", theOrder.Subtotal);
                insertCommand.Parameters.AddWithValue("@discount", theOrder.Discount);
                insertCommand.Parameters.AddWithValue("@tax", theOrder.Tax);
                insertCommand.Parameters.AddWithValue("@total", theOrder.OrderTotal);

                //Just did this conn1.Open();
                //ID = (int)insertCommand.ExecuteScalar();
                //insertCommand.ExecuteNonQuery();
                //insertCommand.CommandText = query2;
                ID = (int)insertCommand.ExecuteScalar();
            }
            theOrder.OrderID = ID.ToString();// Convert.ToInt32(selectCommand.ExecuteScalar());


            /*save payment*/
            //first set it up          
            //string insertStatement2 = "INSERT INTO ORDERPAYMENT (order, cardNumber, expDate,CVV,billingStreet1,billingStreet2,billingCity,billingState,billingZip) values (@order, @cardNumber,@expDate, @CVV, @billingStreet1,@billingStreet2,@billingCity,@billingState,@billingZip)";
            string insertStatement2 = "INSERT INTO ORDERPAYMENT (OrdNo, cardNumber, expDate,CVV,billingStreet1,billingStreet2,billingCity,billingState,billingZip,cardName) values (@ordno, @cardNumber,@expDate, @CVV, @billingStreet1,@billingStreet2,@billingCity,@billingState,@billingZip,@cardName)";
            SqlCommand insertCommand2 = new SqlCommand(insertStatement2, conn1);
            //need to supply this one with the order number and use it
            insertCommand2.Parameters.AddWithValue("@ordno", theOrder.OrderID);
            insertCommand2.Parameters.AddWithValue("@cardNumber", theOrder.Card);
            insertCommand2.Parameters.AddWithValue("@expDate", theOrder.Exp);
            insertCommand2.Parameters.AddWithValue("@CVV", theOrder.Cvv);
            insertCommand2.Parameters.AddWithValue("@billingStreet1", theOrder.BillAddr1);
            insertCommand2.Parameters.AddWithValue("@billingStreet2", theOrder.BillAddr2);
            insertCommand2.Parameters.AddWithValue("@billingCity", theOrder.Billcity);
            insertCommand2.Parameters.AddWithValue("@billingState", theOrder.Billstate);
            insertCommand2.Parameters.AddWithValue("@billingZip", theOrder.Billzip);
            insertCommand2.Parameters.AddWithValue("@cardName", theOrder.PymtName);
            //then write
            insertCommand2.ExecuteNonQuery();

            /*save shipping details*/
            //first set it up
            //string insertStatement4 = "INSERT INTO ORDERSHIPPINGDETAILS (order, shipTo, Street1,Street2,City,State,Zip) values (@order, @shipTo, @Street1,@Street2,@City,@State,@Zip)";
            string insertStatement4 = "INSERT INTO ORDERSHIPPINGDETAILS (ordId,shipTo, Street1,Street2,City,State,Zip) values (@order, @shipTo, @Street1,@Street2,@City,@State,@Zip)";
            SqlCommand insertCommand4 = new SqlCommand(insertStatement4, conn1);
            insertCommand4.Parameters.AddWithValue("@order", theOrder.OrderID);
            insertCommand4.Parameters.AddWithValue("@shipTo", theOrder.ShipTo);
            insertCommand4.Parameters.AddWithValue("@Street1", theOrder.ShipToAdd1);
            insertCommand4.Parameters.AddWithValue("@Street2", theOrder.ShiptoAdd2);
            insertCommand4.Parameters.AddWithValue("@City", theOrder.ShipCity);
            insertCommand4.Parameters.AddWithValue("@State", theOrder.ShipSt);
            insertCommand4.Parameters.AddWithValue("@Zip", theOrder.ShipZip);
            //then write

            insertCommand4.ExecuteNonQuery();

            /* Save Order Details */
            WriteDetails(theOrder, ID);
            //int testid = ID; //just to see if it gets here
        }
        finally
        {
            conn1.Close();
        }

    }

    public static void DeleteOrder(int theOrderID)
    {
        string deleteString = "delete from Orders where OrderId = @orderID"; // the parameter values will be made later

        // now the command object
        SqlCommand deleteCommand = new SqlCommand(deleteString, conn1); // declares and instantiates a new sqlcommand, which takes 2 arguments, the command itself as a string, and the connection as a string

        deleteCommand.Parameters.AddWithValue("@orderID", theOrderID);

        try
        {
            conn1.Open(); // opens the connection to the database so that we can make sqlcommands
            deleteCommand.ExecuteNonQuery();
        }
        finally
        {
            conn1.Close(); // Closes the database, so that we aren't accidently interacting with it anymore
        }

    }

    public static void DeleteOrderDetails(int theOrderID, int thelineID)
    {
        string deleteString = "delete from OrderDetails where orderid=@orderid and lineID=@lineid"; // the parameter values will be made later

        // now the command object
        SqlCommand deleteCommand = new SqlCommand(deleteString, conn1); // declares and instantiates a new sqlcommand, which takes 2 arguments, the command itself as a string, and the connection as a string

        deleteCommand.Parameters.AddWithValue("@orderID", theOrderID);
        deleteCommand.Parameters.AddWithValue("@lineID", thelineID);
        try
        {
            conn1.Open(); // opens the connection to the database so that we can make sqlcommands
            deleteCommand.ExecuteNonQuery();
        }
        finally
        {
            conn1.Close(); // Closes the database, so that we aren't accidently interacting with it anymore
        }

    }

    public static void WriteDetails(Order theOrder, int orderID)
    {            /*save order details*/
                 //first set it up
                 //need to adapt this idea to looping through each CartItem
        string insertStatement3;
        

        //then write
        //foreach (CartItem i in theOrder.cartList)
        int index = 0;
        int line = 0;
        while (index != -1)
        {
            line = index + 1;
        
            insertStatement3 = "INSERT INTO ORDERDETAILS (OrderId, ProductId, LineID,Quantity, PriceEach,OrderDate) values (@orderid, @productid, @line ,@quantity, @priceeach,@orderDate)";
            SqlCommand insertCommand3 = new SqlCommand(insertStatement3, conn1);
            insertCommand3.Parameters.AddWithValue("@orderid", orderID);
            insertCommand3.Parameters.AddWithValue("@productid", theOrder.CartList.GetProdID(index));
            insertCommand3.Parameters.AddWithValue("@line", line);
            insertCommand3.Parameters.AddWithValue("@quantity", theOrder.CartList.GetQuantity(index));
            insertCommand3.Parameters.AddWithValue("@priceeach", theOrder.CartList.GetItemsPrice(index));
            insertCommand3.Parameters.AddWithValue("@orderDate", theOrder.OrderDate);

            insertCommand3.ExecuteNonQuery();

            index = theOrder.CartList.IndexAdvance(index);

        }


    }
    public static string ReorderInfo(int orderID, int lineID)
    {
        string prod="";

        string selectString = "select productid from orderdetails where orderid=@orderid and lineID=@lineid;";

        // now the command object
        SqlCommand selectCommand = new SqlCommand(selectString, conn1); // declares and instantiates a new sqlcommand, which takes 2 arguments, the command itself as a string, and the connection as a string

        selectCommand.Parameters.AddWithValue("@orderid", orderID); // declares what the parameters retrieve their information from. theStore is the passed PizzaStore object
        selectCommand.Parameters.AddWithValue("@lineid", lineID);
        try
        {
            conn1.Open(); 
            using (SqlDataReader reader = selectCommand.ExecuteReader())
            {
            // Check is the reader has any rows at all before starting to read.
                if (reader.HasRows)
                {
                // Read advances to the next row.
                    while (reader.Read())
                    {
                        //prod = reader.GetInt32(reader.GetOrdinal("ProductID")).ToString();
                        prod = reader.GetString(reader.GetOrdinal("ProductID"));
                    }
                }
             }
        }
        finally
        {
            conn1.Close(); // Closes the database, so that we aren't accidently interacting with it anymore
        }

        return prod;
    }

    public static Order OrderReceipt(string orderid)
        {
            Order currentOrder = new Order();

            string selectStatement = "SELECT * FROM Orders WHERE OrderId = @orderid";

            SqlCommand selectCommand = new SqlCommand(selectStatement, conn1);

            selectCommand.Parameters.AddWithValue("@orderid", orderid);
            try
            {
                conn1.Open();
                SqlDataReader reader = selectCommand.ExecuteReader(); // Retrieves a collection of whatever statement was executed

                while (reader.Read()) // While there is data to be read, the command is executed
                { //Orderdate = string // decimal subtotal; //decimal discount;//decimal tax;// decimal orderTotal;
  
                    currentOrder.OrderID = reader["OrderId"].ToString();
                    currentOrder.UserName = reader["Username"].ToString();
                    currentOrder.Subtotal = Convert.ToDecimal(reader["subtotal"].ToString());
                    currentOrder.Discount = Convert.ToDecimal(reader["discount"]);
                    currentOrder.Tax = Convert.ToDecimal(reader["tax"]);
                    currentOrder.OrderTotal = Convert.ToDecimal(reader["total"]);
                    currentOrder.OrderDate = (reader["OrderDate"]).ToString();
                }
                reader.Close();
            }
            finally
            {
                conn1.Close();  
            }
            return currentOrder;    
        }
  
    public static int GetProdQuantity(int theorderid, int thelineid)
        {

        int quant=0;

        string selectString = "select Quantity from orderdetails where orderid=@orderid and lineID=@lineid;";

        // now the command object
        SqlCommand selectCommand = new SqlCommand(selectString, conn1); // declares and instantiates a new sqlcommand, which takes 2 arguments, the command itself as a string, and the connection as a string

        selectCommand.Parameters.AddWithValue("@orderid", theorderid); // declares what the parameters retrieve their information from. theStore is the passed PizzaStore object
        selectCommand.Parameters.AddWithValue("@lineid", thelineid);
        try
        {
            conn1.Open();
            using (SqlDataReader reader = selectCommand.ExecuteReader())
            {
                // Check is the reader has any rows at all before starting to read.
                if (reader.HasRows)
                {
                    // Read advances to the next row.
                    while (reader.Read())
                    {
                        quant = reader.GetInt32(reader.GetOrdinal("Quantity"));                       
                    }
                }
            }
        }
        finally
        {
            conn1.Close(); // Closes the database, so that we aren't accidently interacting with it anymore
        }

        return quant;

    }

    public static void UpdateProductQuant(int prod, int quant)
        {
            try
            {
                conn1.Open();

                string updateStatement = "update products set OnHand+=@quant where productid=@prod ";


                SqlCommand updateCommand = new SqlCommand(updateStatement, conn1);
                updateCommand.Parameters.AddWithValue("@prod", prod);
                updateCommand.Parameters.AddWithValue("@quant", quant);

                updateCommand.ExecuteNonQuery();
            }
            finally
            {
                conn1.Close();
            }

        }
}