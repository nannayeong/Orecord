
package impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import model.AudioBoardDTO;
import model.MemberDTO;

@Service
public interface SearchImpl {
	public ArrayList<AudioBoardDTO> search(String type, String search, int f, int l);
	public int searchTotal(String searchType, String searchWord);
	
	public ArrayList<MemberDTO> searchArtist(String searchWord);
	public int searchArtistTotal(String searchWord);
	
	public ArrayList<AudioBoardDTO> searchAudioByArtist(String searchWord);
	public ArrayList<AudioBoardDTO> searchContent(String searchWord);
	
	/*통합검색용*/
	public ArrayList<AudioBoardDTO> searchAudioM(String searchWord);
	public ArrayList<MemberDTO> searchArtistM(String searchWord);
	public ArrayList<AudioBoardDTO> searchAudioByArtistM(String searchWord);
	public ArrayList<AudioBoardDTO> searchContentM(String searchWord);
} 

