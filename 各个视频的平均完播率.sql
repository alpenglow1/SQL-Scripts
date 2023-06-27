/*计算2021年里有播放记录的每个视频的完播率(结果保留三位小数)，并按完播率降序排序
注：视频完播率是指完成播放次数占总播放次数的比例。简单起见，结束观看时间与开始播放时间的差>=视频时长时，视为完成播放。
输出示例：
示例数据的结果如下：
video_id	avg_comp_play_rat */


SELECT video_id,
round(avg(IF(end_time-start_time>=duration,1,0)),3) AS avg_comp_play_rat
FROM tb_user_video_log
JOIN tb_video_info using(video_id)
WHERE year(start_time)=2021
GROUP BY video_id
ORDER BY avg_comp_play_rat desc



