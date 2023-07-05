package com.bit.spring.model;

import lombok.Data;

@Data
public class MemberDTO {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String realName;
    private String address;
    private String detailAddress;
    private String phoneNumber;
    private String email;
    private String role;
}
