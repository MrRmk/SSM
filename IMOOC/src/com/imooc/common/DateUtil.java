package com.imooc.common;

import java.io.File;
import java.sql.Timestamp;
import java.util.Date;

import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.MultimediaInfo;

/**
 * 
 * @author Ren 日期时间工具类
 */
public class DateUtil {
	public static void main(String[] args) {
		Date date = new Date();
		// 注意：这个地方da.getTime()得到的是一个long型的值
		System.out.println(date.getTime());

		// 由日期date转换为timestamp

		// 第一种方法：使用new Timestamp(long)
		Timestamp t = new Timestamp(new Date().getTime());
		System.out.println(t);
	}
	// 获取系统当前时间
	public Timestamp getCurrentTime(){
		Date date = new Date();
		// 由日期date转换为timestamp
		Timestamp t = new Timestamp(new Date().getTime());
		return t;
	}
	
	// 获取视频的时长(返回字符串：如: 12:30)
    public String ReadVideoTime(File source) {
    	Encoder encoder = new Encoder();
    	String length = "";
    	try {
	    	MultimediaInfo m = encoder.getInfo(source);
	    	long ls = m.getDuration()/1000; //秒
	    	int hour = (int) (ls/3600);
	    	int minute = (int) (ls%3600)/60;
	    	int second = (int) (ls-hour*3600-minute*60);
	    	// length = hour+"'"+minute+"''"+second+"'''";
	    	if( hour == 0 ){
	    		length = Appendzero(minute)+":"+Appendzero(second);
				
			}else{
				length = Appendzero(hour)+":"+Appendzero(minute)+":"+Appendzero(second);
			}
	    	System.out.println("length:" + length);
    	} catch (Exception e) {
    	e.printStackTrace();
    	}
    	return length;
    }
    
    // 获取视频的时长(返回秒)
    public int ReadVideoTimeSecond(File source) {
    	Encoder encoder = new Encoder();
    	int length = 0;
    	try {
	    	MultimediaInfo m = encoder.getInfo(source);
	    	long ls = m.getDuration()/1000; //秒
	    	length = (int) ls;
	    	System.out.println("length:" + length);
    	} catch (Exception e) {
    	e.printStackTrace();
    	}
    	return length;
    }
    //时间不足两位补 0
    public String Appendzero(int obj)  
    {  
        if(obj<10) 
        	return "0" +""+ obj;  
        else 
        	return obj+"";  
    }
}
