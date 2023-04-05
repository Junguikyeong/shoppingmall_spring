package com.bit.spring.model;

import lombok.Data;

@Data
public class CartDTO {
    private int id;
    private int memberId;
    private int productId;
    private int productCount;
    private int creditId;
    private int creditDefaultId;

    private String productName;
    private String productCategory;
    private int productPrice;
    private String productImgPath;
}
