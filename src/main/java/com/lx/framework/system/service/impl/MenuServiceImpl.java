package com.lx.framework.system.service.impl;

import com.lx.framework.utils.util;
import com.lx.framework.system.dao.ButtonDao;
import com.lx.framework.system.dao.MenuDao;
import com.lx.framework.system.dao.PermDao;
import com.lx.framework.system.service.MenuService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly=false,rollbackFor=Exception.class)
public class MenuServiceImpl implements MenuService{
	Logger log = LogManager.getLogger(MenuServiceImpl.class.getName());
	@Resource
	private MenuDao menuDao;
	@Resource
	private PermDao permDao;
	@Resource
	private ButtonDao buttonDao;
	@Resource
	private JdbcTemplate jdbcTemplate;
	/**
	 * 根据ID查询实例
	 * @param paramap
	 * @return
	 */
	public Map<String,Object> findById(String id){
		return menuDao.findById(id);
	}
	/**
	 * 验证名称是否重复
	 * @param paramap
	 * @return
	 */
	public boolean checkName(Map<String,Object> paramap){
		return menuDao.checkName(paramap);
	}
	/**
	 * 保存
	 * @param paramap
	 */
	public void save(Map<String,Object> paramap){
		//保存的ID
		String id=util.getUuid();
		String pid=paramap.get("pid").equals("")?"0":paramap.get("pid").toString();//父级ID
		String code=id;
		if(!pid.equals("0")){//非顶级节点
			//根据父级ID查询父级实例
			Map<String,Object> pmap=menuDao.findById(pid);
			//父级编码
			String pcode=pmap.get("code")==null?"":pmap.get("code").toString();
			code=pcode+","+id;
			//父级子节点个数
			int childnum=Integer.parseInt(pmap.get("childnum").toString());
			pmap.put("childnum", childnum+1);
			menuDao.update(pmap);
		}
		paramap.put("id",id);
		paramap.put("pid",pid);
		int maxsort=menuDao.getMaxSort(pid);
		paramap.put("sort",maxsort+5);
		paramap.put("childnum",0);
		paramap.put("code", code);
		menuDao.save(paramap);
	}
	/**
	 * 更新
	 * @param paramap
	 */
	public void update(Map<String,Object> paramap){
		//原数据
		String id=paramap.get("id").toString();
		Map<String,Object> oldmap=menuDao.findById(id);
		oldmap.put("name",paramap.get("name").toString());
		oldmap.put("url",paramap.get("url").toString());
		oldmap.put("isshow",paramap.get("isshow").toString());
		String oldcode=oldmap.get("code").toString();//原编码code
		//新父级ID
		String newpid=paramap.get("pid").equals("")?"0":paramap.get("pid").toString();
		//原父级ID
		String oldpid=oldmap.get("pid").toString();
		String newcode="";//新编码code
		if(!newpid.equals(oldpid)){//父级菜单变更
			//菜单变更
			if(!newpid.equals("0")){
				//新父级菜单
				Map<String,Object> newp=menuDao.findById(newpid);
				int newchildnum=Integer.parseInt(newp.get("childnum").toString());
				newp.put("childnum",newchildnum+1);
				newcode=newp.get("code").toString();//新父级编码code
				menuDao.update(newp);
				newcode=newcode+","+id;
			}else{
				newcode=id;
			}
			if(!oldpid.equals("0")){
				//原父级菜单
				Map<String,Object> oldp=menuDao.findById(oldpid);
				int oldchildnum=Integer.parseInt(oldp.get("childnum").toString());
				oldp.put("childnum",oldchildnum-1);
				menuDao.update(oldp);
			}
			oldmap.put("pid",newpid);
			int maxsort=menuDao.getMaxSort(newpid);
			oldmap.put("sort",maxsort+5);
			oldmap.put("code",newcode);
		}
		menuDao.update(oldmap);
		
		String codesql="UPDATE sys_menu SET code=REPLACE(code,'"+oldcode+"','"+newcode+"') WHERE code LIKE '"+oldcode+"%'";
		jdbcTemplate.execute(codesql);
	}
	/**
	 * 删除
	 * @param ids
	 */
	public void delete(String id){
		//删除菜单
		menuDao.delete(id);
		//根据菜单删除按钮
		buttonDao.deleteByMenuId(id);
		//根据菜单删除权限
		permDao.deleteByMenuId(id);
	}
	/**
	 * 根据条件查询
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findAllByParam(Map<String,Object> paramap){
		return menuDao.findAllByParam(paramap);
	}
	/**
	 * 根据父级pid获取
	 * @return
	 */
	public List<Map<String,Object>> findByPid(String pid){
		return menuDao.findByPid(pid);
	}
	/**
	 * 根据菜单ID数组及父级菜单ID查询菜单集合
	 * @param paramap
	 * @return
	 */
	public List<Map<String,Object>> findByMenuIds(String id[],String parentid){
		return menuDao.findByMenuIds(id,parentid);
	}
	/**
	 * 根据菜单ID数组查询子节点数量
	 * @param ids
	 * @return
	 */
	public List<Map<String,Object>> findMenuChildnum(String ids[]){
		return menuDao.findMenuChildnum(ids);
	}
}