package com.ywh.biz;

import com.ywh.entity.User;
import com.ywh.entity.Video;

public interface FileBiz {

	void saveVideo(Video video);

	void saveVideoImage(String fileName);

	void addtoVideolist(User user, Video video);

}
