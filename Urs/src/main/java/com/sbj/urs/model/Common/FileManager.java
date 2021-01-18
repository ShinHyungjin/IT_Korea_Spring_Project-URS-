/*
 * 占쏙옙占싹곤옙 占쏙옙占시듸옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쏙옙틂占쏙옙占� 클占쏙옙占쏙옙
 * */
package com.sbj.urs.model.Common;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
@Component   /*component-scan의 대상중 하나로 만들기위해 */
public class FileManager {
	private static final Logger logger = LoggerFactory.getLogger(FileManager.class);
	private String saveStoreDir = "/resources/data/store"; //점포전용 사진 저장
	private String saveMenuDir = "/resources/data/menu"; //메뉴전용 사진 저장 
	private String saveCategoryDir = "/resources/data/category"; //카테고리 전용 사진 저장
	private String saveMemberDir = "/resources/data/member"; //멤버 전용 사진 저장
	
 
	
	//파일 삭제
	public static String getExtend(String path) {
		int lastIndex = path.lastIndexOf(".");
		String ext = path.substring(lastIndex+1, path.length());
		//System.out.println(ext);		
		return ext;
	}
	public static boolean deleteFile(String path) {
		File file = new File(path);
		return file.delete();
		
	}
	
	//파일 저장하기..
	public void saveFile(String realDir,MultipartFile multi) {
		try {
			multi.transferTo(new File(realDir));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	//占싱몌옙 占쏙옙占쏙옙 占쌓쏙옙트 占쌔븝옙占쏙옙 占쏙옙占쏙옙..
	/*
	public static void main(String[] args) {
		//   d:\photo\summer\2010\占쏙옙占쏙옙.占쏙옙占쏙옙占쏙옙.占쏘러.占쏙옙占쏙옙.占쏙옙占쏙옙.jpg
		String filename="d:\\photo\\summer\\2010\\占쏙옙占쏙옙.占쏙옙占쏙옙占쏙옙.占쏘러.占쏙옙占쏙옙.占쏙옙占쏙옙.jpg";
		getExtend(filename);
	}
	*/
}
