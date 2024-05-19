package com.wp.scoreprocessing;

import java.util.ArrayList;

public class ScoreDO {
	private ArrayList<Integer> scores = null;
	private double avg = 0.0;
	private double sd = 0.0;
	
	public ScoreDO() {
		scores = new ArrayList<Integer>();
	}

	public int[] getScores() {
		int[] scoreArray = null;
		
		if (scores.size() > 0) {
			scoreArray = new int[scores.size()];
			int index = 0;
			for(int score : scores) {
				scoreArray[index++] = score;
			}
		}
		return scoreArray;
	}

	public void setScores(int[] scores) {
		if (scores != null && scores.length > 0) {
			this.scores.clear();
			for (int i=0; i<scores.length; i++) {
				this.scores.add(scores[i]);
			}
		}
	}

	public void setScores(String[] scores) {
		if (scores != null && scores.length > 0) {
			this.scores.clear();
			for (int i=0; i<scores.length; i++) {
				this.scores.add(Integer.parseInt(scores[i]));
			}
		}
	}

	public double getAvg() {
		return avg;
	}

	public void setAvg(double avg) {
		this.avg = avg;
	}

	public double getSd() {
		return sd;
	}

	public void setSd(double sd) {
		this.sd = sd;
	}
}
