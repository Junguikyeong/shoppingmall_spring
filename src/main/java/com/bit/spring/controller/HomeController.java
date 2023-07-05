package com.bit.spring.controller;

import com.bit.spring.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    MemberService memberService;

    @Autowired
    public HomeController(MemberService memberService){
        this.memberService = memberService;
    }

    @RequestMapping("/")
    public String showIndex() {
        return "index";
    }
}
