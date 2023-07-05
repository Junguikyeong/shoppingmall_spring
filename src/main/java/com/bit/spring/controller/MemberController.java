package com.bit.spring.controller;

import com.bit.spring.model.MemberDTO;
import com.bit.spring.model.ProductDTO;
import com.bit.spring.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/")
public class MemberController {
    MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("auth")
    public String showAuth(HttpSession session, Model model) {
        model.addAttribute("loginFailMsg", session.getAttribute("loginFailMsg"));
        return "/member/auth";
    }

    @GetMapping("register")
    public String showRegister() {
        return "member/upsert";
    }

    @PostMapping("register")
    public String register(MemberDTO attempt, Model model) {
        memberService.encrypt(attempt);
        if (memberService.register(attempt)) {
            model.addAttribute("message", "회원가입성공! 로그인하세요");
            return "redirect:/";
        } else {
            model.addAttribute("message", "중복된 아이디로 가입할 수 없습니다. 다시 입력해주세요");
            return "member/upsert";
        }
    }

//    @GetMapping("update")
//    public String update(Model model, int id) {
//        ProductDTO productDTO = mem.selectOne(id);
//
//        model.addAttribute("productDTO", productDTO);
//
//        return "/product/upsert";
//    }

    @GetMapping("wishList")
    public String showWishList() {
        return "/member/wishList";
    }

    @GetMapping("shoppingCart")
    public String showShoppingCart() {
        return "/member/shoppingCart";
    }
}
