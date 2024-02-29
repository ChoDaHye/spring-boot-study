package org.zerock.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 검색을 위한 클래스 VO
 */
@Getter
@Setter
public class Criteria {
    private String type;
    private String keyword;

    private int pageNum;          // 몇 페이지
    private int pageSize;         // 페이지 사이즈

    public Criteria() {
        this(1, 10);    // 처음 페이지는 1, 처음 페이지 사이즈는 10
    }

    public Criteria(int pageNum, int pageSize) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
    }

    // T, C, W, TC, TW, TWC
    // ["T"]
    // ["C"]
    // ["W"]
    // ["T","C"]
    // ["T","W"]
    // ["T","W","C"]
    public String[] getTypeArr() {
        return type == null ? new String[] {} : type.split("");
    }
}
