package egovframework.aj.equip.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.aj.equip.DAO.EquipDAO;
import egovframework.aj.equip.service.EquipService;

@Service("EquipService")
public class EquipServiceImpl implements EquipService{

	@Resource(name="EquipDAO")
    private EquipDAO EquipDAO;
	
	@Override
	public Map<String, Object> map(String queryId, String queryId2, Map<String, Object> param) 
			throws Exception {
		
		int totalCnt = (int) EquipDAO.select(queryId2, param);
		List result = EquipDAO.list(queryId, param);
		
		Map<String, Object> resultmap = new HashMap<String, Object>();
		
		resultmap.put("result", result);
		resultmap.put("totalCnt", totalCnt);
		
		return resultmap;
	}
	
	@Override
	public List list_map(String queryId, Map<String, Object> param) 
			throws Exception {
		List result = EquipDAO.list(queryId, param);
		
        return result;
	}
	
	@Override
	public Map<String, Object> insert(String queryId, Map<String, Object> param) 
			throws Exception {
		EquipDAO.insert(queryId, param);
		return null;
	}
	@Override
	public Map<String, Object> delete(String queryId, Map<String, Object> param) 
			throws Exception {
		EquipDAO.delete(queryId, param);
		return null;
	}
	@Override
	public Map<String, Object> update(String queryId, Map<String, Object> param) 
			throws Exception {
		EquipDAO.update(queryId, param);
		return null;
	}
}
