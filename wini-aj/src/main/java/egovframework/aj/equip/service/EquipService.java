package egovframework.aj.equip.service;

import java.util.List;
import java.util.Map;

public interface EquipService {
	//단건 조회 출력
	List list_map(String queryId, Map<String, Object> param) throws Exception; 

	//insert
	Map<String, Object> insert(String queryId, Map<String, Object> param) throws Exception;

}
