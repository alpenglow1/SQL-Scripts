/*问题：计算2021年里每个创作者每月的涨粉率及截止当月的总粉丝量
注：
涨粉率=(加粉量 - 掉粉量) / 播放量。结果按创作者ID、总粉丝量升序排序。
if_follow-是否关注为1表示用户观看视频中关注了视频创作者，为0表示此次互动前后关注状态未发生变化，为2表示本次观看过程中取消了关注。
输出示例：
示例数据的输出结果如下
author	month	fans_growth_rate
total_fans */

SELECT author,date_format(start_time,'%Y-%m') AS month,
sum(CASE WHEN if_follow=1 THEN 1
         WHEN if_follow=2 THEN -1
         ELSE 0
         END)/count(*) AS fans_growth_rate,
sum(sum(CASE WHEN if_follow=1 THEN 1
         WHEN if_follow=2 THEN -1
         ELSE 0
         END)) over(PARTITION BY author ORDER BY date_format(start_time,'%Y-%m')) AS total_fans
FROM tb_user_video_log
JOIN tb_video_info using(video_id)
WHERE YEAR(start_time)=2021
GROUP BY author,date_format(start_time,'%Y-%m')
ORDER BY author,total_fans

