package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.AlbumDTO;

@Service
public interface AlbumImpl {

	public ArrayList<AlbumDTO> albumList(String id);
	public int addAlbum(String id, String albumName);
	public int albumIdxSelect(String id, String albumName);
	public String getalbum(String album_idx);
     
} 
