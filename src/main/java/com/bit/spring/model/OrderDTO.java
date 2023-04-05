package com.bit.spring.model;

import lombok.Data;

@Data
public class OrderDTO {
    private int id;
    private int memberId;
    private int productId;
    private int productPrice;
    private int productCount;
    private String status;

}
