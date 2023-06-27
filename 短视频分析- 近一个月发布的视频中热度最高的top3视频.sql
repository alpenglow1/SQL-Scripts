/*问题：找出近一个月发布的视频中热度最高的top3视频。
注：
热度=(a*视频完播率+b*点赞数+c*评论数+d*转发数)*新鲜度；
新鲜度=1/(最近无播放天数+1)；
当前配置的参数a,b,c,d分别为100、5、3、2。
最近播放日期以end_time-结束观看时间为准，假设为T，则最近一个月按[T-29, T]闭区间统计。
结果中热度保留为整数，并按热度降序排序。
输出示例：
示例数据的输出结果如下
video_id	hot_index */


SELECT video_id,
round((100*complete_rate+5*like_cnt+3*comment_cnt+2*retweet_cnt)*xxd) AS hot_index
from
(SELECT video_id,
avg(if(timestampdiff(SECOND,start_time,end_time)>=duration,1,0)) AS complete_rate,
sum(if_like) AS like_cnt,
count(comment_id) AS comment_cnt,
sum(if_retweet) AS retweet_cnt,
1/(datediff((select max(end_time) FROM tb_user_video_log),max(end_time))+1) AS xxd
FROM tb_user_video_log
JOIN tb_video_info using(video_id)
WHERE datediff((select max(end_time) FROM tb_user_video_log),end_time)<=29
GROUP BY video_id ) t1
ORDER BY hot_index DESC
LIMIT 3

