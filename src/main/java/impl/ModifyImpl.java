package impl;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.AudioBoardDTO;

@Service
public interface ModifyImpl {
	
	//기존게시물 조회
	public AudioBoardDTO modify(@Param("audio_idx") int audio_idx,
		@Param("id") String id);
	
	//게시물 수정하기
	public int modifyAction(String audiotitle, String aritstname,
		String contents, String audiofilename, String imagename,
		String category, int party, int audio_idx, String id);
	
	//게시물 수정하기(오디오파일X)
	public int modifyAction2(String audiotitle, String artistname,
		String contents, String imagename, String category, int party,
		int audio_idx, String id);
	
	//게시물 수정하기(이미지파일X)
	public int modifyAction3(String audiotitle, String artistname,
		String contents, String audiofilename, String category, int party,
		int audio_idx, String id);
	
	//게시물 수정하기(오디오, 이미지X)
	public int modifyAction4(String audiotitle, String artistname,
		String contents, String category, int party,
		int audio_idx, String id);
}
