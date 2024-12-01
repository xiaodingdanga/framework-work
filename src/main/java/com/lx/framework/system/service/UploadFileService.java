package com.lx.framework.system.service;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface UploadFileService{
	/**
	 * 根据条件查询所有
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(String idarr[]);
	/**
	 * 上传文件保存
	 * @param filemap
	 */
	public void save(Map<String, Object> filemap);
	/**
	 * 根据ID删除
	 * @param id
	 */
	public void delete(String id);
	/**
	 * 根据ID查询
	 * @param id
	 * @return
	 */
	public Map<String, Object> findById(String id);
	
	/**
	 * 根据商品ID查询所有
	 * 
	 * @param paramap
	 * @return
	 */
	public List<Map<String, Object>> findAllByGoodsId(String goodsid);
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
//	public Map uploadFile(String createUser,String root,String businessPath,MultipartFile mulFile);
}
