package egovframework.aj.equip.service;

import java.util.List;
import java.util.Map;

public interface EquipService {
	//map 형태 출력
	Map<String, Object> map(String queryId, String queryId2, Map<String, Object> param) throws Exception;
	
	//단건 조회 출력
	List list_map(String queryId, Map<String, Object> param) throws Exception; 

	//insert
	Map<String, Object> insert(String queryId, Map<String, Object> param) throws Exception;

	//delete
	Map<String, Object> delete(String queryId, Map<String, Object> param) throws Exception;
	
	//update
	Map<String, Object> update(String queryId, Map<String, Object> param) throws Exception;
}
