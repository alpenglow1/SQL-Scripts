/*问题：计算各类(group by tag)视频(tb_video_info-tag)的平均播放进度，将进度大于60%的类别输出。
注：
播放进度=播放时长÷视频时长*100%，当播放时长大于视频时长时，播放进度均记为100%。
结果保留两位小数，并按播放进度倒序排序。
输出示例：
示例数据的输出结果如下：
tag	avg_play_progress*/

SELECT tag,
concat(round(avg_play_progress,2),'%') AS avg_play_progress
from(
SELECT tag,
avg(IF(timestampdiff(SECOND,start_time,end_time)>=duration,100,/*播放时长*/
   100*timestampdiff(SECOND,start_time,end_time)/duration)) AS avg_play_progress
FROM tb_user_video_log
JOIN tb_video_info using(video_id) 
GROUP by tag
) t1
WHERE avg_play_progress > 60
ORDER BY avg_play_progress desc