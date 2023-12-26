//package com.human.dto;
//
//import com.fasterxml.jackson.annotation.JsonProperty;
//
//public class NewsItem {
//	 private String title;
//	 private String link;
//	 private String image;
//	 @JsonProperty("originallink")
//	 private String originallink;
//	public String getTitle() {
//		return title;
//	}
//	public void setTitle(String title) {
//		this.title = title;
//	}
//	public String getLink() {
//		return link;
//	}
//	public void setLink(String link) {
//		this.link = link;
//	}
//	public String getImage() {
//		return image;
//	}
//	public void setImage(String image) {
//		this.image = image;
//	}
//	@Override
//	public String toString() {
//		return "NewsItem [title=" + title + ", link=" + link + ", image=" + image + "]";
//	}
//	 
//	
//}
package com.human.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class NewsItem {
    private String title;
    private String link;
    private String image;

    @JsonProperty("originallink")
    private String originallink;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getOriginallink() {
        return originallink;
    }

    public void setOriginallink(String originallink) {
        this.originallink = originallink;
    }
}