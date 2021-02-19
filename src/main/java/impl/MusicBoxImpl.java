package impl;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.AudioBoardDTO;

@Service
public interface MusicBoxImpl {
	
	/*프리리스트 추가(회원)*/
	int addFreeList(String fp_id, String audio_idx, String guestip);
	
	ArrayList<AudioBoardDTO> selectFreeList(String fp_id, String guestip, int start, int end);
	
	ArrayList<AudioBoardDTO> np(String fp_id, String guestip);
}
