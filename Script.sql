
CREATE TABLE exam_record (
    id int PRIMARY KEY AUTO_INCREMENT COMMENT '自增ID',
    uid int NOT NULL COMMENT '用户ID',
    exam_id int NOT NULL COMMENT '试卷ID',
    start_time datetime NOT NULL COMMENT '开始时间',
    submit_time datetime COMMENT '提交时间',
    score tinyint COMMENT '得分'
)CHARACTER SET utf8 COLLATE utf8_general_ci;

INSERT INTO exam_record(uid,exam_id,start_time,submit_time,score) VALUES
(1006, 9003, '2021-09-06 10:01:01', '2021-09-06 10:21:02', 84),
(1006, 9001, '2021-08-02 12:11:01', '2021-08-02 12:31:01', 89),
(1006, 9002, '2021-06-06 10:01:01', '2021-06-06 10:21:01', 81),
(1006, 9002, '2021-05-06 10:01:01', '2021-05-06 10:21:01', 81),
(1006, 9001, '2021-05-01 12:01:01', null, null),
(1001, 9001, '2021-09-05 10:31:01', '2021-09-05 10:51:01', 81),
(1001, 9003, '2021-08-01 09:01:01', '2021-08-01 09:51:11', 78),
(1001, 9002, '2021-07-01 09:01:01', '2021-07-01 09:31:00', 81),
(1001, 9002, '2021-07-01 12:01:01', '2021-07-01 12:31:01', 81),
(1001, 9002, '2021-07-01 12:01:01', null, null);