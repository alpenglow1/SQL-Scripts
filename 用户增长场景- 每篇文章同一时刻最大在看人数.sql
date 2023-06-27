/*统计每篇文章同一时刻最大在看人数，如果同一时刻有进入也有离开时，先记录用户数增加再记录减少，结果按最大人数降序。
输出示例：
示例数据的输出结果如下
artical_id	max_uv */

SELECT artical_id,
max(uv) AS max_uv
FROM 
    (SELECT artical_id,dt,
     sum(tag) over(PARTITION BY artical_id ORDER BY dt,tag desc) AS uv -- 第二步：统计截止每个时间戳的在线人数
     FROM 
         (
          SELECT artical_id,in_time dt,1 AS tag
          FROM tb_user_log
          WHERE artical_id != 0
          UNION ALL -- 第一步：打标签
          SELECT artical_id,out_time dt,-1 AS tag
          FROM tb_user_log
          WHERE artical_id != 0
          ) t1
      ) t2
GROUP BY artical_id -- 第三步：聚合
ORDER BY max_uv desc
