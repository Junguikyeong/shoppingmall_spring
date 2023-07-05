package com.bit.spring.service;

import com.bit.spring.model.ProductDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductService {
    private final String NAMESPACE = "mapper.ProductMapper";
    private final int PAGE_SIZE = 9;
    private SqlSession session;

    @Autowired
    public ProductService(SqlSession session) {
        this.session = session;
    }

    public List<ProductDTO> selectAll(int pageNo) {
        HashMap<String, Integer> params = new HashMap<>();
        params.put("start", (pageNo - 1) * PAGE_SIZE);
        params.put("size", PAGE_SIZE);

        return session.selectList(NAMESPACE + ".selectAll", params);
    }

    public ProductDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public void register(ProductDTO productDTO) {
        session.insert(NAMESPACE + ".register", productDTO);
    }

    public int selectLastPage() {
        int count = session.selectOne(NAMESPACE + ".count");
        int total = count / PAGE_SIZE;
        if (count % PAGE_SIZE != 0) {
            total++;
        }
        return total;
    }

    public void update(ProductDTO attempt) {
        session.update(NAMESPACE + ".update", attempt);
    }

    public void delete(int id) {
        session.insert(NAMESPACE + ".delete", id);
    }

    public Map<String, Object> selectByKeyword(String keyword, int pageNo) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("start", (pageNo - 1) * PAGE_SIZE);
        params.put("size", PAGE_SIZE);
        params.put("keyword", keyword);

        result.put("list", session.selectList(NAMESPACE + ".selectByKeyword", params));
        result.put("totalPage", countSearchResult(keyword));
        return result;
    }

    public Map<String, Object> selectByCategory(String category, int pageNo) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("start", (pageNo - 1) * PAGE_SIZE);
        params.put("size", PAGE_SIZE);
        params.put("category", category);

        result.put("list", session.selectList(NAMESPACE + ".selectByCategory", params));
        result.put("totalPage", countSearchResult(category));
        return result;
    }

    public int countSearchResult(String keyword) {
        int temp = session.selectOne(NAMESPACE + ".countSearchResult", keyword);
        int totalPage = temp / PAGE_SIZE;
        if (temp % PAGE_SIZE != 0) {
            totalPage++;
        }
        return totalPage;
    }


}
