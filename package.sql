CREATE OR REPLACE PACKAGE video_package AS
  PROCEDURE get_num_video_types(p_num_video_types OUT NUMBER);

  PROCEDURE get_top_video_by_average_views(p_title OUT VARCHAR2, p_average_views OUT NUMBER);

  PROCEDURE get_most_liked_comment(p_commentid OUT NUMBER, p_videoid OUT NUMBER, p_commentcontent OUT VARCHAR2, p_likes OUT NUMBER, p_sentiment OUT VARCHAR2);

  PROCEDURE get_total_watch_time(p_videoid OUT NUMBER, p_total_watch_time OUT NUMBER);

  PROCEDURE get_genre_count(p_keyword OUT VARCHAR2, p_genre_count OUT NUMBER);

  PROCEDURE get_youtuber_stats(p_youtuber OUT VARCHAR2, p_comment_count OUT NUMBER, p_like_count OUT NUMBER);

  PROCEDURE get_country_view_count(p_videoid OUT NUMBER, p_country OUT VARCHAR2, p_view_count OUT NUMBER);

  PROCEDURE get_max_likes(p_max_likes OUT NUMBER);

END video_package;


CREATE OR REPLACE PACKAGE BODY video_package AS
  PROCEDURE get_num_video_types(p_num_video_types OUT NUMBER) IS
  BEGIN
    SELECT COUNT(DISTINCT video_type) INTO p_num_video_types FROM VIDEOSTATS;
  END get_num_video_types;

  PROCEDURE get_top_video_by_average_views(p_title OUT VARCHAR2, p_average_views OUT NUMBER) IS
  BEGIN
    SELECT title, AVG(views) INTO p_title, p_average_views
    FROM VIDEOSTATS
    GROUP BY title
    ORDER BY average_views DESC
    FETCH FIRST 1 ROWS ONLY;
  END get_top_video_by_average_views;

  PROCEDURE get_most_liked_comment(p_commentid OUT NUMBER, p_videoid OUT NUMBER, p_commentcontent OUT VARCHAR2, p_likes OUT NUMBER, p_sentiment OUT VARCHAR2) IS
  BEGIN
    SELECT commentid, videoid, commentcontent, likes, sentiment INTO p_commentid, p_videoid, p_commentcontent, p_likes, p_sentiment
    FROM COMMENTS
    ORDER BY likes DESC
    FETCH FIRST 1 ROWS ONLY;
  END get_most_liked_comment;

  PROCEDURE get_total_watch_time(p_videoid OUT NUMBER, p_total_watch_time OUT NUMBER) IS
  BEGIN
    SELECT videoid, SUM(views) INTO p_videoid, p_total_watch_time
    FROM VIDEOSTATS
    GROUP BY videoid;
  END get_total_watch_time;

  PROCEDURE get_genre_count(p_keyword OUT VARCHAR2, p_genre_count OUT NUMBER) IS
  BEGIN
    SELECT keyword, COUNT(*) INTO p_keyword, p_genre_count
    FROM VIDEOSTATS
    GROUP BY keyword
    ORDER BY genre_count DESC;
  END get_genre_count;

  PROCEDURE get_youtuber_stats(p_youtuber OUT VARCHAR2, p_comment_count OUT NUMBER, p_like_count OUT NUMBER) IS
  BEGIN
    SELECT g.youtuber, COUNT(c.commentid), SUM(v.likes) INTO p_youtuber, p_comment_count, p_like_count
    FROM GLOBALSTATS g
    LEFT JOIN VIDEOSTATS v ON g.title = v.title
    LEFT JOIN COMMENTS c ON v.videoid = c.videoid
    GROUP BY g.youtuber
    ORDER BY comment_count DESC, like_count DESC;
  END get_youtuber_stats;

  PROCEDURE get_country_view_count(p_videoid OUT NUMBER, p_country OUT VARCHAR2, p_view_count OUT NUMBER) IS
  BEGIN
    SELECT v.videoid, COALESCE(g.country, 'United States'), COUNT(*) INTO p_videoid, p_country, p_view_count
    FROM VIDEOSTATS v
    LEFT JOIN GLOBALSTATS g ON v.title = g.title
    GROUP BY v.videoid, g.country
    ORDER BY view_count DESC;
  END get_country_view_count;

  PROCEDURE get_max_likes(p_max_likes OUT NUMBER) IS
  BEGIN
    SELECT MAX(likes) INTO p_max_likes FROM VIDEOSTATS;
  END get_max_likes;

END video_package;