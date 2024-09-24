## Problem

We have:
- a machine learning binary classifier which takes as input an image and outputs the image quality score (from O to 1, where scores closer to O represent low-quality images, and scores closer to 1 represent high-quality images).
- a SQL table containing 1M unlabeled images. We run each of these images through our machine learning model to get float scores from 0 to 1 for each image.
  
Our sampling strategy is to order the images in decreasing order of scores and sample every 3rd image starting with the first from the beginning until we get 10k positive samples. And we would like to do the same in the other direction, starting from the end to get 10k negative samples.

Task: Write a SQL query that performs this sampling and creates the expected output ordered by image_id with integer columns image_id, weak_label.

## Solution

```sql
create table Images (
    image_id int primary key,
    score float check(score>=0 and score<=1)
)

begin
insert into images (image_id, score) values (242, 0.23);
insert into images (image_id, score) values (123, 0.92);
insert into images (image_id, score) values (248, 0.88);
insert into images (image_id, score) values (303, 0.54);
insert into images (image_id, score) values (284, 0.97);
insert into images (image_id, score) values (117, 0.31);
insert into images (image_id, score) values (421, 0.75);
insert into images (image_id, score) values (367, 0.53);
insert into images (image_id, score) values (281, 0.82);
end;

BEGIN
    INSERT INTO images (image_id, score) VALUES (1828, 0.3149);
    INSERT INTO images (image_id, score) VALUES (705, 0.9892);
    INSERT INTO images (image_id, score) VALUES (46, 0.5616);
    INSERT INTO images (image_id, score) VALUES (1132, 0.8823);
    INSERT INTO images (image_id, score) VALUES (906, 0.8394);
    INSERT INTO images (image_id, score) VALUES (272, 0.9778);
    INSERT INTO images (image_id, score) VALUES (594, 0.7670);
    INSERT INTO images (image_id, score) VALUES (232, 0.1598);
    INSERT INTO images (image_id, score) VALUES (524, 0.2310);
    INSERT INTO images (image_id, score) VALUES (616, 0.1003);
    INSERT INTO images (image_id, score) VALUES (161, 0.7113);
    INSERT INTO images (image_id, score) VALUES (7150, 0.8921);
    INSERT INTO images (image_id, score) VALUES (424, 0.7790);
    INSERT INTO images (image_id, score) VALUES (609, 0.5241);
    INSERT INTO images (image_id, score) VALUES (63, 0.2552);
    INSERT INTO images (image_id, score) VALUES (276, 0.2672);
    INSERT INTO images (image_id, score) VALUES (701, 0.0758);
    INSERT INTO images (image_id, score) VALUES (1554, 0.4410);
    INSERT INTO images (image_id, score) VALUES (509, 0.1058);
    INSERT INTO images (image_id, score) VALUES (219, 0.7143);
    INSERT INTO images (image_id, score) VALUES (402, 0.7655);
    INSERT INTO images (image_id, score) VALUES (9, 0.3387);
    INSERT INTO images (image_id, score) VALUES (464, 0.3674);
    INSERT INTO images (image_id, score) VALUES (405, 0.6929);
    INSERT INTO images (image_id, score) VALUES (823, 0.3361);
    INSERT INTO images (image_id, score) VALUES (617, 0.0218);
    INSERT INTO images (image_id, score) VALUES (47, 0.0072);
    INSERT INTO images (image_id, score) VALUES (115, 0.5309);
    INSERT INTO images (image_id, score) VALUES (417, 0.7168);
    INSERT INTO images (image_id, score) VALUES (706, 0.9649);
    INSERT INTO images (image_id, score) VALUES (363, 0.2661);
    INSERT INTO images (image_id, score) VALUES (624, 0.8270);
    INSERT INTO images (image_id, score) VALUES (1640904, 0.0000);
    INSERT INTO images (image_id, score) VALUES (986, 0.8931);
    INSERT INTO images (image_id, score) VALUES (344, 0.3761);
    INSERT INTO images (image_id, score) VALUES (867, 0.4050);
    INSERT INTO images (image_id, score) VALUES (96, 0.4498);
    INSERT INTO images (image_id, score) VALUES (166, 0.2507);
    INSERT INTO images (image_id, score) VALUES (991, 0.4191);
    INSERT INTO images (image_id, score) VALUES (971, 0.9871);
END;


select * from images;
insert into images (image_id, score) values (381, 82);
```

### positive samples
```sql
with positive_sample_rn 
as
(
    select row_number() over (
        order by score
    ) as row_number,
    image_id,
    score 
    from images 
    order by score desc
    fetch first 3*10 rows only      -- using N=10 here since dataset is small
)   --number every img sequentially according to decreasing score and pick first 3*n only

select image_id, score as weak_label 
from positive_sample_rn
where MOD(row_number-1, 3)=0    -- pick every 3rd image
order by image_id
```
![image](https://github.com/user-attachments/assets/05f1168b-6936-4dff-9102-d0dc6ce71eb6)


### negative samples
```sql
with negative_sample_rn 
as
(
    select row_number() over (
        order by score
    ) as row_number,
    image_id,
    score 
    from images 
    order by score
    fetch first 3*10 rows only      -- N=10
)   --number every img sequentially according to decreasing score and pick first 3*n only

select image_id, score as weak_label 
from negative_sample_rn
where MOD(row_number-1, 3)=0    -- pick every 3rd image
order by image_id
```
![image](https://github.com/user-attachments/assets/14833a05-d8b0-4076-80c2-4c71d2f53875)
