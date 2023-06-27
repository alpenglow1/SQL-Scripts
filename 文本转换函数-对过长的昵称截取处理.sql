/*有的用户的昵称特别长，在一些展示场景会导致样式混乱，因此需要将特别长的昵称转换一下再输出，
请输出字符数大于10的用户信息，对于字符数大于13的用户输出前10个字符然后加上三个点号：『...』。*/

SELECT uid,
(CASE WHEN char_length(nick_name)>13 THEN concat(LEFT(nick_name,10),'...')
ELSE nick_name
END ) AS nick_name
FROM user_info
WHERE char_length(nick_name)>10