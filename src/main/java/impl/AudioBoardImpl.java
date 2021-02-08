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
	public ArrayList<AudioBoardDTO> mainAudioList();
	public ArrayList<AudioBoardDTO> audioListLast(String id);

} 
