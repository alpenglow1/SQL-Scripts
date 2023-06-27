/*找到每个人
 近三个有试卷作答记录的月份中  窗口函数
 没有试卷是未完成状态的用户的
 试卷作答完成数，
 按试卷完成数和用户ID降序排名。*/

-- 筛选出每个用户作答的近三个月份
with t1 as (
select *
from 
    (select uid,exam_id,date_format(start_time,'%Y%m') as ym,score,
     dense_rank() over(
                       partition by uid
                       order by date_format(start_time,'%Y%m') desc) as rk
     from exam_record
     ) t0 
where rk <=3
)
select uid,
count(exam_id) as exam_complete_cnt
from t1
group by uid
having avg(if(score is null,0,1))=1
order by exam_complete_cnt desc,uid desc