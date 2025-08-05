package com.donut.prokindonutsweb.common;

import com.donut.prokindonutsweb.common.mapper.UserInfoMapper;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserInfoUtil {
    private final UserInfoMapper userInfoMapper;

    public String getWarehouseCode(CustomUserDetails user) {
        String memberCode = user.getMemberCode();
        return userInfoMapper.getWarehouseCode(memberCode);
    }

    public String getMemberCode(CustomUserDetails user) {
        return user.getMemberCode();
    }
}
