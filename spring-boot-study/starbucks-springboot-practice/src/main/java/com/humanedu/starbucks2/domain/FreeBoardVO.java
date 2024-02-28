package com.humanedu.starbucks2.domain;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
@Getter
@Setter
public class FreeBoardVO {
    private int num;
    private String id;
    private String pw;
    private String name;
    private String hp;
    private String email;
    private String hompy;
    private String subject;
    private String content;
    private Integer hit;
    //private LocalDate regDate;
    private String regDate;
    private String file1Path;
    private String file2Path;
}
