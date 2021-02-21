package impl;
import java.util.ArrayList;

import org.springframework.stereotype.Service;

import model.NotificationDTO;


@Service
public interface MessageImpl{
	public int saveMsg(String sender, String receiver, String msg, int idx);
	public ArrayList<NotificationDTO> loadMsg(String receiver);
	public int readMsg(int n_idx);

} 
