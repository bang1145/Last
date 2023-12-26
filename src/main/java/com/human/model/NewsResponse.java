//package com.human.model;
//
//import java.util.List;
//
//import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
//import com.human.dto.NewsItem;
//
//@JsonIgnoreProperties(ignoreUnknown = true)
//public class NewsResponse {
//	private String lastBuildDate;
//    private List<NewsItem> items;
//
//    // Getter and Setter for lastBuildDate
//
//    public List<NewsItem> getItems() {
//        return items;
//    }
//
//    public void setItems(List<NewsItem> items) {
//        this.items = items;
//    }
//}
package com.human.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.human.dto.NewsItem;

@JsonIgnoreProperties(ignoreUnknown = true)
public class NewsResponse {
    private String lastBuildDate;
    private List<NewsItem> items;

    public String getLastBuildDate() {
        return lastBuildDate;
    }

    public void setLastBuildDate(String lastBuildDate) {
        this.lastBuildDate = lastBuildDate;
    }

    public List<NewsItem> getItems() {
        return items;
    }

    public void setItems(List<NewsItem> items) {
        this.items = items;
    }
}