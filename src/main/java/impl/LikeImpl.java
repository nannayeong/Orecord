package impl;

import java.util.List;
import java.util.Map;

public interface LikeImpl {
	public Map<String, Object> like(String aIdx,String id);
	public Map<String, Object> nolike(String aIdx,String id);
	
	public List<Integer> selectLike(String like_id, String id);

} 
