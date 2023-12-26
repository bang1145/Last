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

import com.human.dto.BoardDto;
import com.human.dto.ReplyDto;
import com.human.model.ReplyService;
import com.human.vo.PageMaker;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	@Autowired
	private ReplyService service; /*reply 비즈니스 로직 처리하려 주입*/
	
	// 글에 전체 댓글
	@RequestMapping(value="/all/{bId}",method=RequestMethod.GET)
	public ResponseEntity<List<ReplyDto>> list(@PathVariable("bId") Integer bId){
		ResponseEntity<List<ReplyDto>> entity=null;

	    try {
	     
	    	entity = new ResponseEntity<>(service.listReply(bId), HttpStatus.OK); /*httpStatus 는 상태정보*/

	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
		return entity;
	}

	//댓글 등록
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyDto dto, Model model) {
	    ResponseEntity<String> entity = null;
	    try {
	        if ("COMMENT".equals(dto.getCommentType())) {
	            // 댓글 등록 로직
	            service.addReply(dto);
	            
	        } else if ("REPLY".equals(dto.getCommentType())) {
	            // 대댓글 등록 로직
	        	
	        	ReplyDto parentDto = service.read(dto.getrId());
	        	
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
	
	
	//댓글 수정
	  @RequestMapping(value = "/{rId}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	  public ResponseEntity<String> update(@PathVariable("rId") Integer rId, @RequestBody ReplyDto dto) {

	    ResponseEntity<String> entity = null;
	    try {
	      dto.setrId(rId);
	      service.modifyReply(dto);

	      entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	  }

	  
	  //댓글 삭제
	  @RequestMapping(value = "/{rId}", method = RequestMethod.DELETE)
	  public ResponseEntity<String> remove(@PathVariable("rId") Integer rId) {

	    ResponseEntity<String> entity = null;
	    try {
	      service.removeReply(rId);
	      entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	  }

	  
	  // 아마도 페이지..?
	  @RequestMapping(value = "/{bId}/{page}", method = RequestMethod.GET)
	  public ResponseEntity<Map<String, Object>> listPage(
	      @PathVariable("bId") Integer bId,
	      @PathVariable("page") Integer page) {

	    ResponseEntity<Map<String, Object>> entity = null;
	    
	    try {
	      PageMaker pm = new PageMaker();
	      pm.setPage(page);


	      Map<String, Object> map = new HashMap<String, Object>();
	      List<ReplyDto> list = service.listReplyPage(bId, pm);

	      map.put("list", list);

	      int replyCount = service.count(bId);
	      pm.setTotalCount(replyCount);

	      map.put("pageMaker", pm);

	      entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	  }
}
	  













