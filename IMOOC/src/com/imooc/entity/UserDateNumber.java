package com.imooc.entity;

public class UserDateNumber {
	
	private int countNumber;
	
	private String dateTime;

	public int getCountNumber() {
		return countNumber;
	}

	public void setCountNumber(int countNumber) {
		this.countNumber = countNumber;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	@Override
	public String toString() {
		return "UserDateNumber [countNumber=" + countNumber + ", dateTime=" + dateTime + "]";
	}

	
}
