/*/计算在2021年(where)至少有两天作答过试卷的人中，计算该年连续两次作答试卷的最大时间窗(1,6:6-1+1 lead)days_window，
 那么根据该年的历史规律他在days_window天里平均会做多少套试卷，(count(exam_id)/头尾时间相减+1 *days_window
 按最大时间窗和平均做答试卷套数倒序排序。*/

with t1 as (
select uid,start_time,
    lead(start_time,1) over(partition by uid order by start_time) as next_time
    from exam_record
    where year(start_time)=2021
),
-- 最大时间窗
t2 as (
select uid,max(datediff(next_time,start_time)+1) as days_window
from t1
group by uid
having days_window >=2),
-- 平均做答试卷套数
t3 as (
select t2.uid,
(count(exam_id)/(datediff(max(start_time),min(start_time))+1))*days_window as avg_exam_cnt
from t2
join exam_record on t2.uid=exam_record.uid
group by uid
)
select uid,days_window,round(avg_exam_cnt,2) as avg_exam_cnt
from t2
join t3 using(uid)
order by days_window desc,avg_exam_cnt desc

