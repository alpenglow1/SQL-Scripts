/*为了得到用户试卷作答的定性表现，我们将试卷得分按分界点[90,75,60]分为优良中差四个得分等级（分界点划分到左区间），
 请统计不同用户等级的人在完成过的试卷中各得分等级占比（结果保留3位小数），未完成过试卷的用户无需输出，结果按用户等级降序、占比降序排序。*/

SELECT LEVEL,score_grade,
round(count(uid)/total_cnt,3) AS ratio
FROM 
(SELECT uid,LEVEL,score,
(CASE WHEN score <60 THEN '差'
     WHEN score >=60 AND score <75 THEN '中'
     WHEN score >=75 AND score <90 THEN '良'
     ELSE  '优'
     END) AS score_grade,
count(*) over(PARTITION BY level) AS total_cnt -- 每个level的完成试卷总数
FROM exam_record
JOIN user_info using(uid)
WHERE score IS NOT NULL ) t1
GROUP BY LEVEL,score_grade
ORDER BY LEVEL DESC, ratio DESC


SELECT b.level,(CASE WHEN score>=90 THEN '优' WHEN score>=75 THEN '良' WHEN score>=60 THEN '中'
WHEN score<60 THEN '差' ELSE NULL END) AS CATE,
COUNT(score) OVER(PARTITION BY b.level)  AS ratio
FROM exam_record AS a
JOIN user_info AS b
ON a.uid=b.uid
GROUP BY b.level, CATE
HAVING CATE IS NOT NULL
ORDER BY b.level DESC, ratio DESC