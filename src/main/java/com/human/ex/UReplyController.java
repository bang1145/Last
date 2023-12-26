package com.human.ex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.human.dto.UBoardDto;
import com.human.dto.UReplyDto;
import com.human.model.UReplyService;
import com.human.vo.UPageMaker;

@RestController
@RequestMapping("/ureplies")
public class UReplyController {
	@Autowired
	private UReplyService service; /* reply 비즈니스 로직 처리하려 주입 */

	// 글에 전체 댓글
	@RequestMapping(value = "/all/{id}", method = RequestMethod.GET)
	public ResponseEntity<List<UReplyDto>> list(@PathVariable("id") Integer id) {
		ResponseEntity<List<UReplyDto>> entity = null;

		try {
			entity = new ResponseEntity<>(service.listReply(id), HttpStatus.OK); /* httpStatus 는 상태정보 */

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody UReplyDto dto, Model model) {
		ResponseEntity<String> entity = null;
		try {
			if ("COMMENT".equals(dto.getCommentType())) {
				// 댓글 등록 로직
				service.addReply(dto);

			} else if ("REPLY".equals(dto.getCommentType())) {
				// 대댓글 등록 로직

				UReplyDto parentDto = service.read(dto.getUrId());

				int parentRGroup = parentDto.getrGroup();
				int parentRStep = parentDto.getrStep();
				int parentRIndent = parentDto.getrIndent();

				// 대댓글 순서 조정
				service.stepReply(parentRGroup, parentRStep);

				// 대댓글 정보 설정
				dto.setrIndent(parentRIndent + 1);
				dto.setrStep(parentRStep + 1);

				service.createReply(dto);
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 수정
	@RequestMapping(value = "/{urId}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("urId") Integer urId, @RequestBody UReplyDto dto) {

		ResponseEntity<String> entity = null;
		try {
			// 댓글 ID로 해당 댓글 정보를 가져옴
			UReplyDto originalReply = service.read(urId);

			// 글 생성 시 등록한 비밀번호와 요청으로 받은 비밀번호 비교
			if (originalReply != null && originalReply.getrPw().equals(dto.getrPw())) {
				dto.setUrId(urId);
				service.modifyReply(dto);
				entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			} else {
				entity = new ResponseEntity<>("ERROR", HttpStatus.UNAUTHORIZED);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 삭제
	@RequestMapping(value = "/{urId}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("urId") Integer urId, @RequestBody UReplyDto dto) {
		ResponseEntity<String> entity = null;

		try {
			// 댓글 ID로 해당 댓글 정보를 가져옴
			UReplyDto originalReply = service.read(urId);

			// 글 생성 시 등록한 비밀번호와 요청으로 받은 비밀번호 비교
			if (originalReply != null && originalReply.getrPw().equals(dto.getrPw())) {
				service.removeReply(urId, dto.getrPw());
				entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			} else {
				// 비밀번호 불일치 시 에러 응답
				entity = new ResponseEntity<>("ERROR", HttpStatus.UNAUTHORIZED);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/{id}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("id") Integer id, @PathVariable("page") Integer page) {

		ResponseEntity<Map<String, Object>> entity = null;

		try {			
			UPageMaker pm = new UPageMaker();
			pm.setPage(page);

			Map<String, Object> map = new HashMap<String, Object>();
			List<UReplyDto> list = service.listReplyPage(id, pm);

			map.put("list", list);

			int replyCount = service.count(id);
			pm.setTotalCount(replyCount);

			map.put("uPageMaker", pm);

			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}