package com.human.ex;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.dto.ReplyDto;
import com.human.model.BoardService;
import com.human.model.UploadService;

@Controller
public class UploadController {
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	@Inject
	private UploadService um;

	// 이후 작업
	@ResponseBody
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjax(@RequestParam("file") MultipartFile[] files, Integer bId) throws Exception {
		
		System.out.println(bId);
		
		// 여러 파일 뜨게 하려고 List 생성
		List<String> savedNames=new ArrayList<>();
		List<String> uploadedFileNames = new ArrayList<>();

		// getOriginalFilename랑 currentTimeMillis는 원래 있는 매서드
		for (MultipartFile file : files) {
			System.out.println("originalName: " + file.getOriginalFilename());
			String savedName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        savedNames.add(savedName);
		
		// SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD_HHMMSS_");
		SimpleDateFormat formatter = new SimpleDateFormat("YYYYMM");
		Calendar now = Calendar.getInstance();

		String yearPath = formatter.format(now.getTime());
		String savedPath = uploadPath + "////" + yearPath; // 지정된 경로 설정

		System.out.println(savedPath);
		File makeFolder = new File(savedPath);
		// folderPath의 디렉토리가 존재하지 않을경우 디렉토리 생성.
		if (!makeFolder.exists()) {
			makeFolder.mkdir();
			System.out.println("폴더를 생성합니다.");
		}
		// 파일저장
		File target = new File(savedPath, savedName);
		FileCopyUtils.copy(file.getBytes(), target);
	
		String formatName = savedName.substring(savedName.lastIndexOf(".") + 1).toUpperCase();
		System.out.println(formatName);
		String uploadedFileName = null;
		
		if (formatName.equals("JPG") || formatName.equals("PNG") || formatName.equals("GIF")) {
			uploadedFileName = makeThumbnail(savedPath, yearPath, savedName);
		} else {
			uploadedFileName = "////" + yearPath + "////" + savedName;
		}
//		System.out.println(uploadedFileName);
		
		 uploadedFileNames.add(uploadedFileName);
		 um.addFile(uploadedFileName, bId);
		}
		 
		return new ResponseEntity<>(String.join(",", uploadedFileNames), HttpStatus.CREATED);
	}

	
	
	private static String makeThumbnail(String savedPath, String yearPath, String fileName) throws Exception {

		BufferedImage sourceImg = ImageIO.read(new File(savedPath, fileName));

		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

		String thumbnailName = savedPath + "/" + "s_" + fileName;

		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

		ImageIO.write(destImg, formatName.toUpperCase(), newFile);

		return "/" + yearPath + "/" + thumbnailName.substring(savedPath.length() + 1);
	}

	@ResponseBody
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) throws Exception {
		System.out.println("delete file: " + fileName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
		if (formatName.equals("JPG") || formatName.equals("PNG") || formatName.equals("GIF")) {
			System.out.println(uploadPath + fileName.replace("s_", ""));
			new File(uploadPath + fileName.replace("s_", "")).delete();
		} else {
		}
		new File(uploadPath + fileName).delete();
		um.deleteFile(fileName);
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	@ResponseBody
	@RequestMapping("/allFile")
	public ResponseEntity<List<String>> allFile(Integer bId) throws Exception {
		
//		@RequestMapping(value="/all/{bId}",method=RequestMethod.GET)
//		public ResponseEntity<List<ReplyDTO>> list(@PathVariable("bId") Integer bId){
//			ResponseEntity<List<ReplyDTO>> entity=null;
//
//		    try {
//		     
//		    	entity = new ResponseEntity<>(rm.listReply(bId), HttpStatus.OK);
//
//		    } catch (Exception e) {
//		      e.printStackTrace();
//		      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
//		    }
//			return entity;
//		}
		ResponseEntity<List<String>> entity=null;
//		List<String> list=new ArrayList<String>();
//		list.add("aa");
//		list.add("aa");
//		list.add("aa");
		System.out.println(bId);
		
	    try {
	    	entity = new ResponseEntity<>(um.getFiles(bId), HttpStatus.OK); //이게 원래꺼
//	    	 List<String> files = um.getFiles(bId);
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }

		return entity;	
	}

	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		System.out.println("displayFileE: " + fileName);
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1).toUpperCase();
			MediaType mType = null;
			if (formatName.equals("JPG")) {
				mType = MediaType.IMAGE_JPEG;
			} else if (formatName.equals("GIF")) {
				mType = MediaType.IMAGE_JPEG;
			} else if (formatName.equals("PNG")) {
				mType = MediaType.IMAGE_JPEG;
			}
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath + fileName);
			if (fileName.contains("s_")) {
				headers.setContentType(mType);
				System.out.println("displayFileE: 2" + fileName);
			} else {
				System.out.println("displayFileE: 3" + fileName);
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition",
						"attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
}
