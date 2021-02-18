package util;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import impl.AudioBoardImpl;
import impl.FollowImpl;
import impl.MemberImpl;
import model.AudioBoardDTO;
import model.FollowDTO;
import model.MemberDTO;

public class Calculate {
	int tlikeCount = 0;
	int tplayCount = 0;
	// 불러온 곡들중 재생횟수와 좋아요 수를 합산(좋아요/전체좋아요) + (재생횟수/전체재생횟수)로 ArrayList만들어 내림차순으로 정렬함
	public HashMap<Integer,AudioBoardDTO> calcuPop(ArrayList<AudioBoardDTO> audiolist) {
		ArrayList<Integer> ratioOfPop = new ArrayList();
		HashMap<Integer,AudioBoardDTO> popMap = new HashMap<Integer, AudioBoardDTO>();
		// 모든 좋아요와 재생횟수를 합산함
		for (int i = 0; i < audiolist.size(); i++) {
			AudioBoardDTO audio = audiolist.get(i);
			tlikeCount = tlikeCount + audio.getLike_count();
			tplayCount = tplayCount + audio.getPlay_count();
		}
		// 좋아요와 재생횟수의 비율을 계산하고 더해 ratioOfPop에 넣음
		for (int i = 0; i < audiolist.size(); i++) {
			AudioBoardDTO audio = audiolist.get(i);
			int totalpop = cal(audio);
			ratioOfPop.add(totalpop);
		}
		for(int i=ratioOfPop.size()-1;i>0;i--) {
			for(int j=0;j<i;j++) {
				if(ratioOfPop.get(j)<ratioOfPop.get(j+1)) {
					ratioOfPop.add(j, ratioOfPop.get(j+1));
					ratioOfPop.remove(j+2);
					
				}
			}
		} 
		for (int j = 0; j < audiolist.size(); j++) {
		for (int i = 0; i < ratioOfPop.size(); i++) {
				AudioBoardDTO audio = audiolist.get(j);
				int ratio = ratioOfPop.get(i);
				int totalpop = cal(audio);
				if(totalpop==ratio) {
					popMap.put(j, audio);
					break;
					
				}
			}	
		}
		return popMap;
	}
	public int cal(AudioBoardDTO audio) {
		int totalpop = 0;
		if(tlikeCount!=0&&tplayCount!=0) {
			double likeRatio = audio.getLike_count() * 1000 / tlikeCount;
			double playRatio = audio.getPlay_count() * 1000 / tplayCount;
			totalpop = (int) (likeRatio + playRatio);
		}else if(tlikeCount==0&&tplayCount==0){
			totalpop = 0;
		}else if(tlikeCount==0) {
			double likeRatio = 0;
			double playRatio = audio.getPlay_count() * 1000 / tplayCount;
			totalpop = (int) (likeRatio + playRatio);
		}else if(tplayCount==0) {
			double playRatio = 0;
			double likeRatio = audio.getPlay_count() * 1000 / tlikeCount;
			totalpop = (int) (likeRatio + playRatio);
		}
		return totalpop;

	}
	public HashMap<Integer, Integer> cCount(ArrayList<AudioBoardDTO> audiolist,SqlSession sqlSession) {
	HashMap<Integer, Integer> count = new HashMap<Integer, Integer>();
		for (int i = 0; i < audiolist.size(); i++) {
			
			int idx = audiolist.get(i).getAudio_idx();
			int cCount =  sqlSession.selectOne("commentCount", idx);
			count.put(idx, cCount);
			
		}
		return count;
	}
	public String makeSearchText(String a,String searchWord) {
		String key = searchWord;
		int indexofkey = a.indexOf(key);
		int stringSize = 12;
		int front = 0;
		int back = 0;
		String frontString = "";
		String backString = "";
		
		if(a.length()<=stringSize*2) {
			front=0;
			back=a.length();
		}else if(indexofkey<stringSize) {
			front = 0;
			back = stringSize*2;
			backString="...";
		}else if(indexofkey>a.length()-stringSize) {
			back = a.length();
			front = a.length()-(stringSize*2);
			frontString="...";
		}else {
			front=indexofkey-stringSize;
			back=indexofkey+stringSize;
			frontString="...";
			backString="...";
		}
		String slice = a.substring(front, back);
		String totalString = frontString+slice+backString;
		return totalString;
	}
	public String contentsCut(String a) {
		if(a!=null) {
		int front = 0;
		int back = 0;
		String backString = "";
		
		if(a.length()<=25) {
			back=a.length();
		}else {
			back=26;
			backString = "...";
		}
		String slice = a.substring(front, back);
		String totalString = slice+backString;
		return totalString;
	}else{
			return "";
		}
	}
	public ArrayList<MemberDTO> arrayByDTOFollow(HashMap<String,MemberDTO> memberMap) {
		ArrayList<MemberDTO> before = new ArrayList<MemberDTO>();
		for( String id: memberMap.keySet() ){
			before.add(memberMap.get(id));
        }
		if(before.size()>1) {
		for(int i=before.size()-2;i>=0;i--) {
			for(int j=0;j<=i;j++) {
				if(before.get(j).getFollower()<before.get(j+1).getFollower()) {
					before.add(j,before.get(j+1));
					before.remove(j+2);
				}
			}
		}}
		return before;
	}
	public HashMap<String,MemberDTO> recommandFollowByFollowing(SqlSession sqlSession,String id){
		HashMap<String,MemberDTO> memberMap = new HashMap<String, MemberDTO>();
		
		//유저가 팔로우중인 아이디들
		ArrayList<FollowDTO> followings = sqlSession.getMapper(FollowImpl.class).following(id);

		for (FollowDTO followDTO : followings) {
			String followingId = followDTO.getFollowing_id();
			ArrayList<FollowDTO> followrec = sqlSession.getMapper(FollowImpl.class).following(followingId);
			for(FollowDTO rec : followrec) {
					int audioCount = sqlSession.getMapper(AudioBoardImpl.class).audioList(rec.getFollowing_id()).size();
					if(audioCount>0) {
						int  followCount = sqlSession.getMapper(FollowImpl.class).followerCount(rec.getFollowing_id());
						MemberDTO recmember = sqlSession.getMapper(MemberImpl.class).memberInfo(rec.getFollowing_id());
						recmember.setFollower(followCount);
						memberMap.put(recmember.getId(), recmember);
					}
			}
		}
		for (FollowDTO fDTO : followings) {
			for(String memberid : memberMap.keySet()) {
				if(memberMap.get(memberid).getId().equals(fDTO.getFollowing_id())||memberMap.get(memberid).getId().equals(id)) {
					memberMap.remove(memberMap.get(memberid));
					break;
				}
			}
		}
		
		for(String memberid:memberMap.keySet()) {
			if(memberMap.size()<=4) {
				break;
			}else {
				memberMap.remove(memberMap.get(memberid));
			}
		}
		return memberMap;
	}
}