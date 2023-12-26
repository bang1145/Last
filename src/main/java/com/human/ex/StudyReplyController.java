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

import com.human.dto.StudyDto;
import com.human.dto.StudyReplyDto;
import com.human.model.StudyReplyService;
import com.human.vo.StudyPageMaker;

@RestController
@RequestMapping("/studyreplies")
public class StudyReplyController {
	@Autowired
	private StudyReplyService service; /* reply 비즈니스 로직 처리하려 주입 */

	// 글에 전체 댓글
	@RequestMapping(value = "/all/{sId}", method = RequestMethod.GET)
	public ResponseEntity<List<StudyReplyDto>> list(@PathVariable("sId") Integer sId) {
		ResponseEntity<List<StudyReplyDto>> entity = null;

		try {

			entity = new ResponseEntity<>(service.listReply(sId), HttpStatus.OK); /* httpStatus 는 상태정보 */

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody StudyReplyDto dto, Model model) {
		ResponseEntity<String> entity = null;
		try {
			if ("COMMENT".equals(dto.getCommentType())) {
				// 댓글 등록 로직
				service.addReply(dto);

			} else if ("REPLY".equals(dto.getCommentType())) {
				// 대댓글 등록 로직

				StudyReplyDto parentDto = service.read(dto.getsRId());

				int parentSGroup = parentDto.getsGroup();
				int parentSStep = parentDto.getsStep();
				int parentSIndent = parentDto.getsIndent();

				// 대댓글 순서 조정
				service.stepReply(parentSGroup, parentSStep);

				// 대댓글 정보 설정
				dto.setsIndent(parentSIndent + 1);
				dto.setsStep(parentSStep + 1);

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
	@RequestMapping(value = "/{sRId}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("sRId") Integer sRId, @RequestBody StudyReplyDto dto) {

		ResponseEntity<String> entity = null;
		try {
			dto.setsRId(sRId);
			service.modifyReply(dto);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 댓글 삭제
	@RequestMapping(value = "/{sRId}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("sRId") Integer sRId) {

		ResponseEntity<String> entity = null;
		try {
			service.removeReply(sRId);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 아마도 페이지..?
	@RequestMapping(value = "/{sId}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("sId") Integer sId,
			@PathVariable("page") Integer page) {

		ResponseEntity<Map<String, Object>> entity = null;

		try {
			StudyPageMaker spm = new StudyPageMaker();
			spm.setPage(page);

			Map<String, Object> map = new HashMap<String, Object>();
			List<StudyReplyDto> list = service.listReplyPage(sId, spm);

			map.put("list", list);

			int replyCount = service.count(sId);
			spm.setTotalCount(replyCount);

			map.put("StudyPageMaker", spm);

			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
