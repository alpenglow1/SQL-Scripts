/*试卷的类别tag可能出现大小写混乱的情况，请先筛选出试卷作答数小于3的类别tag，统计将其转换为大写后对应的原本试卷作答数。
如果转换后tag并没有发生变化，不输出该条结果。*/
 
WITH t1 AS (
SELECT 
tag,
count(exam_id) AS answer_cnt
FROM examination_info
JOIN exam_record using(exam_id)
GROUP BY tag )
SELECT 
a.tag,b.answer_cnt
FROM t1 a
JOIN t1 b
ON upper(a.tag)=b.tag AND a.tag !=b.tag AND a.answer_cnt<3




