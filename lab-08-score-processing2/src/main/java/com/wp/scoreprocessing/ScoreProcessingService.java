package com.wp.scoreprocessing;

public class ScoreProcessingService {
	
	static public void process(ScoreDO scoreDO) {
		int[] scores = scoreDO.getScores();
		
		if (scores != null && scores.length > 0) {
			int count = scores.length;
			int sum = 0;
			int ssum = 0;
			
			for (int i=0; i<count; i++) {
				sum += scores[i];
				ssum += scores[i] * scores[i];
			}
			double avg = (double)sum / count;
			scoreDO.setAvg(avg);
			scoreDO.setSd(Math.sqrt(((double)ssum/count) - Math.pow(avg, 2)));
		}
	}

}
