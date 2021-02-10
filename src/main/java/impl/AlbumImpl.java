package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.AlbumDTO;

@Service
public interface AlbumImpl {

	public ArrayList<AlbumDTO> albumList(String id);
	public ArrayList<AlbumDTO> albumListPaging(String id, int start, int end);//페이징
	public int addAlbum(String id, String albumName);
	public int albumIdxSelect(String id, String albumName);
	public String getalbum(String album_idx);
	public int albumTotalCount(String id);
	public int deleteAlbum(String id, int album_idx);
    public int modifyAlbum(String id, int album_idx, String albumJacket, String albumName);
} 
