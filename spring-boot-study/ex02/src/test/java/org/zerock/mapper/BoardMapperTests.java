package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.zerock.config.DBConfig;
import org.zerock.domain.BoardVO;

import java.util.HashMap;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {DBConfig.class})
@Log4j
public class BoardMapperTests {
  
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
//		System.out.println("aaaaa");
//		log.info("bbbbb");
		mapper.getList().forEach(board -> log.info("abc: " + board));
	}

	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		mapper.insert(board);

		log.info(board);
	}

	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setWriter("newbie");
		mapper.insertSelectKey(board);

		log.info(board);
	}

	@Test
	public void testRead() {
		BoardVO boardVO = mapper.read(2L);
		log.info(boardVO);
	}

	@Test
	public void testDelete() {
		log.info("DELETE COUNT: " + mapper.delete(3L));
	}

	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		// 실행전 존재하는 번호인지 확인할 것
		board.setBno(4L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");

		int count = mapper.update(board);
		log.info("UPDATE COUNT: " + count);
	}

	@Test
	public void mybatisDynamic1Test() {
		HashMap<String, String> map = new HashMap<>();
		map.put("T", "TTTT");
		map.put("C", "CCCC");

		mapper.getDynamicMybatis(map);
	}
}
