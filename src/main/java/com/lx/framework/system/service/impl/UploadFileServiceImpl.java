package com.lx.framework.system.service.impl;

import com.lx.framework.system.dao.UploadFileDao;
import com.lx.framework.system.service.UploadFileService;
import com.lx.framework.utils.util;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class UploadFileServiceImpl implements UploadFileService {

	Logger log = LogManager.getLogger(UploadFileServiceImpl.class.getName());

	@Resource
	private UploadFileDao uploadFileDao;

	/**
	 * 根据条件查询所有
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByParam(String idarr[]) {
		return uploadFileDao.findAllByParam(idarr);
	}

	/**
	 * 上传文件保存
	 * 
	 * @param filemap
	 */
	public void save(Map<String, Object> filemap) {
		uploadFileDao.save(filemap);
	}

	/**
	 * 根据ID删除
	 * 
	 * @param id
	 */
	public void delete(String id) {
		uploadFileDao.delete(id);
	}

	/**
	 * 根据ID查询
	 * 
	 * @param id
	 * @return
	 */
	public Map<String, Object> findById(String id) {
		return uploadFileDao.findById(id);
	}

	/**
	 * 根据商品ID查询所有
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByGoodsId(String goodsid) {
		return uploadFileDao.findAllByGoodsId(goodsid);
	}
	/**
	 * 上传单个文件
	 * @param root:跟路径
	 * @param businessPath：业务路径
	 * @param fiLeMap：上传文件
	 * @return
	 * fullUrl:文件全路徑
	   businessUrl：業務路徑
	   fileName：文件名称
	   fileType：文件mini类型
	   fileSize：文件大小单位byte
	   fileExt：文件後綴名
	 */
//	public Map uploadFile(String customerId,String root,String businessPath,MultipartFile mulFile){
//		Map map = null;
//		try {
//
//	    	File file = new File(root+businessPath);
//	        //判断文件夹是否存在,如果不存在则创建文件夹
//	       	if(!file.exists()){
//	       		file.mkdirs();
//	        }
//	        if(mulFile!=null){
//	        	int index =1;
//	                MultipartFile f = mulFile;
//	                if(f!=null&&!f.isEmpty()){
//	                	map = new HashMap();
//	                	String fileType = f.getContentType();//获取文件MIME类型
//	                    String originalName = f.getOriginalFilename();//获取上传文件的原名
//	                    long fileSize = f.getSize();//获取文件的字节大小，单位byte
//	                    String suffix=originalName.substring(originalName.lastIndexOf("."));//文件後綴名
//
//	                    String fileName = UUID.randomUUID().toString().replaceAll("-","")+suffix;//物理文件名
//
//	                    //保存文件
//	                    File newFile = new File(root+businessPath+fileName);
//	                    f.transferTo(newFile);
//	                    map.put("CreateId", customerId);
//	                    map.put("rootUrl", root);
//	                    map.put("fileUrl", FileUtil.rootPath+businessPath+fileName);
//	                    map.put("fileName", fileName+suffix);
//	                    map.put("orgName", originalName);
//	                    map.put("fileSize", fileSize);
//	                    map.put("ext", suffix);
//
//	                    String id = save1(map);
//	                    map.put("id",id);
//	                }
//	        }
//		}catch (Exception e) {
//			e.printStackTrace();
//			e.getMessage();
//		}
//		return map;
//	}
	/**
	 * 保存
	 * @param paramap
	 */
	public String save1(Map<String,Object> paramap){
		//保存的ID
		String id=util.getUuid();
		if(null!=paramap.get("id")){
			id=paramap.get("id").toString();
		}
		String fileName=paramap.get("fileName").toString();
		String rootUrl=paramap.get("rootUrl").toString();
		String fileUrl=paramap.get("fileUrl").toString();
		String orgName=paramap.get("orgName").toString();
		String remark=null==paramap.get("remark")?"":paramap.get("remark").toString();
		String ext=paramap.get("ext").toString();
		String CreateId=paramap.get("CreateId").toString();
		String CreateTime =util.datetostring(new Date(), "yyyy-MM-dd hh:mm:ss");
		String fileSize=paramap.get("fileSize").toString();
		
		paramap.put("id",id);
		paramap.put("fileName",fileName);
		paramap.put("rootUrl",rootUrl);
		paramap.put("fileUrl",fileUrl);
		paramap.put("orgName",orgName);
		paramap.put("remark",remark);
		paramap.put("fileSize",fileSize);
		paramap.put("ext",ext);
		paramap.put("CreateId",CreateId);
		paramap.put("CreateTime",CreateTime);
		uploadFileDao.save(paramap);
		return id;
	}
}
