package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

@Controller
@RequestMapping("/member")
public class IndexController {
    @Autowired
    private MemberService memberService;

    /**
     * Description: 회원가입 페이지
     * @return 회원가입 view page
     */
    @GetMapping("/join")
    public String join() {
        return "member/join";
    }

    /**
     * Desc: 실제 회원가입 프로세스
     * @return 로그인 redirect page
     */
    @PostMapping("/joinProc")
    public String joinProc(MemberVO memberVO) {
        System.out.println("회원가입 진행: " + memberVO);

        memberService.putMember(memberVO);

        return "redirect:/login";
    }

    /**
     * Desc: 로그인 페이지
     * @return 로그인 view page
     */
    @GetMapping("/login")
    public String login() {
        return "member/login";
    }

    @Secured("ROLE_ADMIN")  // @EnableGlobalMethodSecurity(securedEnabled = true)이 설정되어야 적용됨
    @GetMapping("/info")
    @ResponseBody   // @Controller로 선언된 클래스의 메소드에서 response로 json값을 받을 때 사용
    public String info() {
        return "멤버정보";
    }

    @PreAuthorize("hasRole('ROLE_MANAGER') or hasRole('ROLE_ADMIN')")
    // @PreAuthorize("isAuthenticated()")   // 로그인 인증을 받았는 경우에만 실행
    @GetMapping("/data")
    @ResponseBody   // @Controller로 선언된 클래스의 메소드에서 response로 json값을 받을 때 사용
    public String data() {
        return "데이터정보";
    }

}
