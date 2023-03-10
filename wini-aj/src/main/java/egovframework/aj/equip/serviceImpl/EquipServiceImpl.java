package egovframework.aj.equip.serviceImpl;

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
	public List list_map(String queryId, Map<String, Object> param) 
			throws Exception {
		List result = EquipDAO.list(queryId, param);
		
        return result;
	}

}
