package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.AudioBoardDTO;

@Service
public interface AudioBoardImpl {

	public ArrayList<AudioBoardDTO> audioList(String id);
	
	/*음원파일 업로드*/
	public int addAudioBoard(String audiotitle, String id, int album_idx, 
			String audiofilename, String artistname, String contents, String imagename, String category, int party);
	public ArrayList<AudioBoardDTO> mainAudioList(int date1, int date2, int rownum1, int rownum2);
	public ArrayList<AudioBoardDTO> audioListLast(String id);
	public int audioCount();
} 
