/*问题：统计2021年国庆头3天
  每类视频每天的近一周总点赞量和一周内最大单天转发量，9.25-10.1 9.27-10.3
  结果按视频类别降序、日期升序排序。假设数据库中数据足够多，至少每个类别下国庆头3天及之前一周的每天都有播放记录。
输出示例：
示例数据的输出结果如下
tag	dt	sum_like_cnt_7d	 max_retweet_cnt_7d */

SELECT *
from
(SELECT tag,dt,
sum(dl) over(PARTITION BY tag ORDER BY dt ROWS 6 PRECEDING) AS sum_like_cnt_7d,
max(dr) OVER(PARTITION BY tag ORDER BY dt ROWS 6 PRECEDING) AS max_retweet_cnt_7d
FROM 
(SELECT tag,
date_format(start_time,'%Y-%m-%d') AS dt,
sum(if_like) AS dl,#每个tag每天的点赞
sum(if_retweet) AS dr#每个tag每天转发量
FROM tb_user_video_log
JOIN tb_video_info using(video_id)
GROUP BY tag,dt) t1
) t2
WHERE dt BETWEEN '2021-10-01' AND '2021-10-03'
ORDER BY tag DESC,dt


 