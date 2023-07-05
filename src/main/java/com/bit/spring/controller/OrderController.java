package com.bit.spring.controller;

import com.bit.spring.model.CartDTO;
import com.bit.spring.model.MemberDTO;
import com.bit.spring.service.CartService;
import com.bit.spring.service.MemberService;
import com.bit.spring.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/order/")
public class OrderController {
    OrderService orderService;
    CartService cartService;
    MemberService memberService;

    @Autowired
    public OrderController(OrderService orderService,CartService cartService,MemberService memberService) {
        this.orderService = orderService;
        this.cartService = cartService;
        this.memberService = memberService;
    }

    @GetMapping("show")
    public String showOrder(Model model,int id) {
//        System.out.println(id);

        List<CartDTO> c = cartService.selectAll(id);

        model.addAttribute("list", c);
        return "/order/show";
    }

    @PostMapping("creditComplete")
    public String credit(int memberId){
        cartService.deleteAll(memberId);
        return "/order/creditComplete";
    }


}
