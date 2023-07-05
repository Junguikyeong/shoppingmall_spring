package com.bit.spring.service;

import com.bit.spring.model.CartDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.swing.plaf.PanelUI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartService {
    private final String NAMESPACE = "mapper.CartMapper";

    private SqlSession session;

    @Autowired
    public CartService(SqlSession session) {
        this.session = session;
    }

    public void orderCount(CartDTO cartDTO) {
        session.insert(NAMESPACE + ".orderCount", cartDTO);
    }

    public void countUp(CartDTO attempt) {
        int count = session.selectOne(NAMESPACE + ".count", attempt);

        if (count == 0) {
            session.insert(NAMESPACE + ".put", attempt);
        } else {
            CartDTO cartDTO = session.selectOne(NAMESPACE + ".selectOne", attempt);
            session.update(NAMESPACE + ".countUp", cartDTO);
        }
    }

    public void countUpByValue(CartDTO attempt, int value) {
        CartDTO cartDTO = session.selectOne(NAMESPACE + ".selectOne", attempt);
        Map<String, Object> params = new HashMap<>();
        params.put("cartDTO", cartDTO);
        params.put("value", value);
        session.update(NAMESPACE + ".countUpByValue", params);
    }

    public CartDTO selectOne(CartDTO cartDTO) {
        return session.selectOne(NAMESPACE + ".selectOne", cartDTO);
    }

    public List<CartDTO> selectAll(int memberId) {
        return session.selectList(NAMESPACE + ".selectCartList", memberId);
    }

    public void delete(int memberId, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("productId", productId);
        session.delete(NAMESPACE + ".delete", params);
    }

    public void deleteAll(int memberId) {
        session.delete(NAMESPACE + ".deleteAll", memberId);
    }

    public void creditCountUp(int memberId, int[] creditProductId) {
//        System.out.println("서비스 진입성공");

//        for (int i : creditProductId) {
//            Map<String, Object> params = new HashMap<>();
//            params.put("memberId",memberId);
//            params.put("productId",creditProductId[i]);
//            System.out.println(i);
//
//            CartDTO cartDTO = session.selectOne(NAMESPACE + ".selectOne",params);
//
//            System.out.println("서비스 후처리 진입성공");
//            session.update(NAMESPACE + ".creditCountUp", cartDTO);
//        }


    }


}
