package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.PlayListDTO;

@Service
public interface PlayListImpl {

	public ArrayList<PlayListDTO> select(String plid);
	public int addPlayList(String plid, int audio_idx, String plname);
	public ArrayList<PlayListDTO> myplaylist(String plid);
	
	public ArrayList<String> myplaylistPaging(String plid, int start, int end);
}
