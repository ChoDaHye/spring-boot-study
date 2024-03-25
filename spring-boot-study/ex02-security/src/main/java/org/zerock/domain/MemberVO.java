package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
    private int mno;
    private String username;
    private String password;
    private String email;
    private String role;
    private Timestamp createDate;
}
