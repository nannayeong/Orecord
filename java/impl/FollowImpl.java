package impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import model.FollowDTO;

@Service
public interface FollowImpl {

	public ArrayList<FollowDTO> following(String user_id);
	public ArrayList<FollowDTO> followers(String following_id);
	
	public int followingCount(String user_id);
	public int followerCount(String following_id);

	public int followingCheck(String user_id, String following_id);
} 
