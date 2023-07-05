package com.bit.spring.controller;

import com.bit.spring.model.MemberDTO;
import com.bit.spring.model.ProductDTO;
import com.bit.spring.service.CartService;
import com.bit.spring.service.ProductService;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/product/")
public class ProductController {

    ProductService productService;
    CartService cartService;

    @Autowired
    public ProductController(ProductService productService, CartService cartService) {
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("showAll/{pageNo}")
    public String showAll(Authentication authentication, Model model, @PathVariable int pageNo) {
        model.addAttribute("list", productService.selectAll(pageNo));
        model.addAttribute("paging", setPages(pageNo, productService.selectLastPage()));
        model.addAttribute("pagingAddr", "/product/showAll");

        return "/product/showAll";
    }

    @GetMapping("showOne/{id}")
    public String showOne(RedirectAttributes redirectAttributes, Model model, @PathVariable int id) {

        ProductDTO p = productService.selectOne(id);
        if (p == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 상품입니다.");
            return "redirect:/product/showAll/1";
        }

        model.addAttribute("product", p);

        return "/product/showOne";
    }

    @GetMapping("search/{pageNo}")
    public String search(String keyword, Model model, @PathVariable int pageNo) {
//        System.out.println(boardService.selectByKeyword(keyword, pageNo));
        Map<String, Object> map = productService.selectByKeyword(keyword, pageNo);

        model.addAttribute("list", map.get("list"));

        model.addAttribute("pagingAddr", "/product/search");
        model.addAttribute("keyword", keyword);
        model.addAttribute("paging", setPages(pageNo, productService.countSearchResult(keyword)));

        return "/product/showAll";
    }

    @GetMapping("searchCategory/{pageNo}")
    public String searchCategory(String category, Model model, @PathVariable int pageNo) {
        Map<String, Object> map = productService.selectByCategory(category, pageNo);

        model.addAttribute("list", map.get("list"));

        model.addAttribute("pagingAddr", "/product/search");
        model.addAttribute("category", category);
        model.addAttribute("paging", setPages(pageNo, productService.countSearchResult(category)));

        return "/product/showAll";
    }

    private HashMap<String, Integer> setPages(int pageNo, int totalPage) {
        HashMap<String, Integer> paging = new HashMap<>();

        int start = 0;
        int end = 0;

        if (totalPage < 5) {
            start = 1;
            end = totalPage;
        } else if (pageNo < 3) {
            start = 1;
            end = 5;
        } else if (pageNo > totalPage - 3) {
            start = totalPage - 4;
            end = totalPage;
        } else {
            start = pageNo - 2;
            end = pageNo + 2;
        }

        paging.put("start", start);
        paging.put("end", end);
        paging.put("totalPage", totalPage);
        paging.put("currentPage", pageNo);

        return paging;
    }

    @GetMapping("register")
    public String showUpsert() {
        return "/product/upsert";
    }

    @GetMapping("update")
    public String update(Model model, int id) {
        ProductDTO productDTO = productService.selectOne(id);

        model.addAttribute("productDTO", productDTO);

        return "/product/upsert";
    }

    @PostMapping("upsert")
    public String upsert(HttpSession session, String attemptId, ProductDTO productDTO) {
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
//        System.out.println(productDTO);
//        System.out.println(attemptId);

        if (attemptId.matches("^\\d+$")) {

            ProductDTO origin = productService.selectOne(productDTO.getId());
            origin.setName(productDTO.getName());
            origin.setCategory(productDTO.getCategory());
            origin.setPrice(productDTO.getPrice());
            origin.setDescription(productDTO.getDescription());
            productService.update(origin);
        } else {
            productDTO.setRegisteredMemberId(logIn.getId());
            productService.register(productDTO);
        }

        return "/product/showOne" + productDTO.getId();
    }

    @ResponseBody
    @GetMapping("selectOne")
    public ProductDTO selectOne(int productId, int productCount) {
//        System.out.println("컨트롤러 접근성공");
        JsonObject result = new JsonObject();
        ProductDTO p = productService.selectOne(productId);
        int totalAmount = p.getPrice() * productCount;

        result.addProperty("name", p.getName());
        result.addProperty("category", p.getCategory());
        result.addProperty("imgPath", p.getImgPath());
        result.addProperty("totalAmount", totalAmount);

        return productService.selectOne(productId);
    }

    private static final String fileDir = "C:/Users/BT-05/IdeaProjcet/shoppingmall_spring/web/upload";
//    private static final String fileDir = "/home/tomcat/apache-tomcat-9.0.71/webapps/ROOT/upload/";

    @PostMapping("upload")
    public String saveFile(int id, String name, String category, int price, int stock, String description, int registeredMemberId, @RequestParam("uploadFile") MultipartFile file) throws IOException {
        if (!file.getOriginalFilename().isEmpty()) {
            file.transferTo(new File(fileDir, file.getOriginalFilename()));

            String realPath = "\\upload\\" + file.getOriginalFilename();
            System.out.println(realPath);

            if (id == -1) {
                ProductDTO productDTO = new ProductDTO();
                productDTO.setName(name);
                productDTO.setCategory(category);
                productDTO.setPrice(price);
                productDTO.setStock(stock);
                productDTO.setDescription(description);
                productDTO.setRegisteredMemberId(registeredMemberId);
                productDTO.setImgPath(realPath);

                System.out.println(productDTO);

                productService.register(productDTO);
            } else {
                ProductDTO productDTO = productService.selectOne(id);

                productDTO.setName(name);
                productDTO.setCategory(category);
                productDTO.setPrice(price);
                productDTO.setStock(stock);
                productDTO.setDescription(description);
                productDTO.setRegisteredMemberId(registeredMemberId);
                productDTO.setImgPath(realPath);

                System.out.println("수정진행중");

                productService.update(productDTO);
            }
        } else {
            System.out.println("띠용??");
        }

        return "redirect:/product/showAll/1";
    }

    @GetMapping("delete")
    public String delete(int id) {
        productService.delete(id);
        return "redirect:/product/showAll/1";
    }

}
