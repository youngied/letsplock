package beans;

public class Plock {
	private int idx;
	private String title;
	private String image_url;
	private String description;
	private java.sql.Date c_date;
	private int down_num;
	private String block_data;
	private String category;
	private int views;
	
	public int getIdx() {
		return idx;
	}
	public String getTitle() {
		return title;
	}
	public String getImage_url() {
		return image_url;
	}
	public String getDescription() {
		return description;
	}
	public java.sql.Date getC_date() {
		return c_date;
	}
	public int getDown_num() {
		return down_num;
	}
	public String getBlock_data() {
		return block_data;
	}
	public String getCategory() {
		return category;
	}
	public int getViews() {
		return views;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setC_date(java.sql.Date c_date) {
		this.c_date = c_date;
	}
	public void setDown_num(int down_num) {
		this.down_num = down_num;
	}
	public void setBlock_data(String block_data) {
		this.block_data = block_data;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setViews(int views) {
		this.views = views;
	}

}
