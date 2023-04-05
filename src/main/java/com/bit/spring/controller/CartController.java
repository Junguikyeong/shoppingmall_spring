package com.bit.spring.controller;

import com.bit.spring.model.CartDTO;
import com.bit.spring.service.CartService;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart/")
public class CartController {
    CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @ResponseBody
    @PostMapping("countUp")
    public JsonObject countUp(int memberId, int productId) {
        JsonObject result = new JsonObject();

        CartDTO cartDTO = new CartDTO();
        cartDTO.setMemberId(memberId);
        cartDTO.setProductId(productId);

        cartService.countUp(cartDTO);
        cartDTO = cartService.selectOne(cartDTO);

        if (cartDTO.getProductCount() <= 10) {
            result.addProperty("result", "success");
            result.addProperty("count", cartDTO.getProductCount());
        } else {
            cartService.countUpByValue(cartDTO, 10);
            result.addProperty("result", "fail");
        }

//        System.out.println(result);

        return result;
    }

    @ResponseBody
    @PostMapping("countUpByValue")
    public JsonObject countUpByValue(int memberId, int productId, int value) {

        CartDTO cartDTO = new CartDTO();
        cartDTO.setMemberId(memberId);
        cartDTO.setProductId(productId);

        cartService.countUpByValue(cartDTO, value);

        JsonObject result = new JsonObject();
        result.addProperty("result", "success");

        cartDTO = cartService.selectOne(cartDTO);
//        System.out.println(cartDTO);
        result.addProperty("count", cartDTO.getProductCount());

//        System.out.println(result);

        return result;
    }


    @GetMapping("show")
    public String showCartList(Model model, int id) {
        List<CartDTO> c = cartService.selectAll(id);

        model.addAttribute("list", c);

        return "/cart/show";
    }

    @ResponseBody
    @GetMapping("delete")
    public String productDelete(Model model, int memberId, int productId) {
        cartService.delete(memberId, productId);

        return "/cart/show";
    }

    @PostMapping("credit")
    public String creditCountUp(Model model, int memberId, int[] creditProductId) {
        cartService.creditCountUp(memberId, creditProductId);
//        System.out.println("컨트롤러 진입성공");

        return "redirect:/order/show?id="+memberId;
    }

}