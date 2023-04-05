package com.bit.spring.model;

import lombok.Data;

import java.util.Date;

@Data
public class ProductDTO {
    private int id;
    private String name;
    private String category;
    private int price;
    private int stock;
    private String description;
    private String registerNickname;
    private int registeredMemberId;
    private Date entryDate;
    private String imgPath;

}
