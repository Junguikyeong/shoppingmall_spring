package com.bit.spring.service;

import com.bit.spring.model.MemberDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderService {

    private final String NAMESPACE = "mapper.OrderMapper";

    private SqlSession session;

    @Autowired
    public OrderService(SqlSession session) {
        this.session = session;
    }

    public MemberDTO order(int memberId,int cartId){
        session.insert(NAMESPACE + ".insert", cartId);
        return session.selectOne(NAMESPACE +".selectOne", memberId);
    }
}
