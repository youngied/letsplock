package beans;

import java.sql.*;
import java.util.*;

public class LetsgoBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1:3306/letsplock";
	
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "letsplock", "letsgo02!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(conn != null) {
			try {
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	void updateViews(int idx) {
		String sql = "update plock set views=views+1 where idx=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// get main list or searching list
	public ArrayList<beans.Plock> getPlockList(String search) {
		connect();
		ArrayList<beans.Plock> datas = new ArrayList<beans.Plock>();

		String sql = "select * from plock";
		
		if(search != null && !search.equals("") ) {	//searching list
            sql += " WHERE title LIKE '%" + search.trim() + "%' order by idx";
        } else { // main list
            sql += " order by idx";
        }
		//System.out.println(sql);

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				beans.Plock Plock = new beans.Plock();

				Plock.setIdx(rs.getInt("idx"));
				Plock.setTitle(rs.getString("title"));
				Plock.setImage_url(rs.getString("image_url"));
				Plock.setDescription(rs.getString("description"));
				Plock.setC_date(rs.getDate("c_date"));
				Plock.setDown_num(rs.getInt("down_num"));
				Plock.setBlock_data(rs.getString("block_data"));
				Plock.setCategory(rs.getString("category"));
				Plock.setViews(rs.getInt("views"));
				datas.add(Plock);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}
	
	//get detail plock (selectedPlock)
	public beans.Plock getPlock(int idx) {
		connect();
		beans.Plock selectedPlock = new beans.Plock();
		String sql = "select * from plock where idx=? order by idx";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				selectedPlock.setIdx(rs.getInt("idx"));
				selectedPlock.setTitle(rs.getString("title"));
				selectedPlock.setImage_url(rs.getString("image_url"));
				selectedPlock.setDescription(rs.getString("description"));
				selectedPlock.setC_date(rs.getDate("c_date"));
				selectedPlock.setDown_num(rs.getInt("down_num"));
				selectedPlock.setBlock_data(rs.getString("block_data"));
				selectedPlock.setCategory(rs.getString("category"));
				selectedPlock.setViews(rs.getInt("views"));
			}
			rs.close();
			
			updateViews(idx);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return selectedPlock;
	}

	public boolean insertPlock(String title, String image_url, String block_data, String device) {
		connect();

		String sql = "insert into plock (title,image_url,block_data,device) values (?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, image_url);
			pstmt.setString(3, block_data);
			pstmt.setString(4, device);	//영효 : device 추가

			pstmt.executeUpdate();

			/*
			 * pstmt = conn.prepareStatement(sql2); pstmt.setString(1,
			 * f.getName_Plock()); ResultSet rs = pstmt.executeQuery(); int
			 * tmpId_Plock = 0; if (rs.next()) { tmpId_Plock =
			 * rs.getInt("id_Plock"); }
			 * 
			 * pstmt = conn.prepareStatement(sql3); pstmt.setInt(1,
			 * tmpId_Plock); pstmt.executeUpdate();
			 */

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	
	
}
