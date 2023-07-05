package com.bit.spring.service;

import com.bit.spring.model.MemberCustomDetails;
import com.bit.spring.model.MemberDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService implements UserDetailsService {
    private final String NAMESPACE = "mapper.MemberMapper";
    private SqlSession session;
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public MemberService(SqlSession session, BCryptPasswordEncoder passwordEncoder) {
        this.session = session;
        this.passwordEncoder = passwordEncoder;
    }

    public boolean validate(String username) {
        return session.selectOne(NAMESPACE + ".validate", username) == null;
    }

    public boolean register(MemberDTO attempt) {
        if (validate(attempt.getUsername())) {
            session.insert(NAMESPACE + ".register", attempt);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        MemberDTO member = session.selectOne(NAMESPACE + ".validate", s);
        if (member != null) {
            return new MemberCustomDetails(member);
        }
        return null;
    }

    public List<MemberDTO> selectAll() {
        return session.selectList(NAMESPACE + ".selectAll");
    }

    public MemberDTO selectOne(int id){
        return session.selectOne(NAMESPACE+".selectOne",id);
    }

    public void update(MemberDTO attempt) {
        session.update(NAMESPACE + ".update", attempt);
    }

    //        비밀번호 암호화하기
    //        memberService.encrypt();
    public void encrypt(MemberDTO m) {
        m.setPassword((passwordEncoder.encode(m.getPassword())));
        update(m);
    }
}
