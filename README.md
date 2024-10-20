# utl-example-of-recursion-in-sqllite-creating-a-file-hierachy-r-and-python-sql-multi-language
Example of recursion in sqllite creating a file hierachy r and python sql multi language 
    %let pgm=utl-example-of-recursion-in-sqllite-creating-a-file-hierachy-r-and-python-sql-multi-language;

    Example of recursion in sqllite creating a file hierachy r and python sql multi language

    Pushing the limits od SQL?

           SOLUTIONS

              1 r
              2 python sql

    gtithub
    https://tinyurl.com/yacw5xhs
    https://github.com/rogerjdeangelis/utl-example-of-recursion-in-sqllite-creating-a-file-hierachy-r-and-python-sql-multi-language


    /**************************************************************************************************************************/
    /*                     |                                                         |                                        */
    /*         INPUT       |                        PROCESS                          |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                parent            path  */
    /*    PARENT           | WITH RECURSIVE file_paths AS (                          | Id       name  id                      */
    /* ID  ID   NAME       | SELECT id, name, parent_id, name AS path                |                                        */
    /*                     |   FROM files                                            |  1       root  NA                 root */
    /*  1  .    root       |   WHERE parent_id IS NULL                               |  2       docs   1            root/docs */
    /*  2  1    docs       |                                                         |  3     images   1          root/images */
    /*  3  2    images     |   UNION ALL                                             |  4 report.txt   2 root/docs/report.txt */
    /*  4  3    report.txt |                                                         |  5   logo.png   3 root/images/logo.png */
    /*  5  4    logo.png   |   SELECT f.id,f.name,f.parent_id,fp.path ||'/'|| f.name |                                        */
    /*                     |   FROM files f                                          |                                        */
    /*                     |   JOIN file_paths fp ON f.parent_id = fp.id             |                                        */
    /*                     | )                                                       |                                        */
    /*                     | SELECT * FROM file_paths                                |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     | EXPLANATION                                             |                                        */
    /*                     | ===========                                             |                                        */
    /*                     |                                                         |                                        */
    /*                     | Recusion means sql can call itself                      |                                        */
    /*                     |                                                         |                                        */
    /*                     | Lets consider the case                                  |                                        */
    /*                     |                                                         |                                        */
    /*                     | INPUT                                                   |                                        */
    /*                     |                                                         |                                        */
    /*                     | > files                                                 |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     |  1        NA         root                               |                                        */
    /*                     |  2         1         docs                               |                                        */
    /*                     |  3         2       images                               |                                        */
    /*                     |  4         3   report.txt                               |                                        */
    /*                     |  5         4     logo.png                               |                                        */
    /*                     |                                                         |                                        */
    /*                     | Starts with the with ID 1 (root) as the base case       |                                        */
    /*                     | and runs through all remaining records where            |                                        */
    /*                     | the substituting root to path. There is not             |                                        */
    /*                     | previous recusion to add to path                        |                                        */
    /*                     |                                                         |                                        */
    /*                     | Note if we substitute                                   |                                        */
    /*                     |                                                         |                                        */
    /*                     | > files                                                 |                                        */
    /*                     | id  parent_id   name                                    |                                        */
    /*                     |                                                         |                                        */
    /*                     | 1   NA          root                                    |                                        */
    /*                     |   \                                                     |                                        */
    /*                     | 2   1           docs                                    |                                        */
    /*                     |   \                                                     |                                        */
    /*                     | 3   2         images                                    |                                        */
    /*                     |   \                                                     |                                        */
    /*                     | 4   3     report.txt                                    |                                        */
    /*                     |   \                                                     |                                        */
    /*                     | 5   4       logo.png                                    |                                        */
    /*                     |                                                         |                                        */
    /*                     | On each recursion we add levels to path (name as path). |                                        */
    /*                     | The key condition is wher parent_id = id                |                                        */
    /*                     | which adds to the previous path                         |                                        */
    /*                     |                                                         |                                        */
    /*                     | Here is the output                                      |                                        */
    /*                     |                                                         |                                        */
    /*                     | > print(result)                                         |                                        */
    /*                     | id       name parent_id                           path  |                                        */
    /*                     |                                                         |                                        */
    /*                     |  1       root   NA                                 root |                                        */
    /*                     |  2       docs    1                            root/docs |                                        */
    /*                     |  3     images    2                     root/docs/images |                                        */
    /*                     |  4 report.txt    3          root/docs/images/report.txt |                                        */
    /*                     |  5   logo.png    4 root/docs/images/report.txt/logo.png |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     | IN OUR CASE                                             |                                        */
    /*                     | ===========                                             |                                        */
    /*                     |                                                         |                                        */
    /*                     | In out case the output is                               |                                        */
    /*                     |                                                         |                                        */
    /*                     | > print(result)                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     |  id parent_id       name                  path          |                                        */
    /*                     |                                                         |                                        */
    /*                     |   1        NA       root                  root          |                                        */
    /*                     |   2         1       docs             root/docs          |                                        */
    /*                     |   3         1     images           root/images          |                                        */
    /*                     |   4         2 report.txt  root/docs/report.txt          |                                        */
    /*                     |   5         3   logo.png  root/images/logo.png          |                                        */
    /*                     |                                                         |                                        */
    /*                     |                                                         |                                        */
    /*                     | 1st call parent_id=NA no previous iteration so root     |                                        */
    /*                     |                                                         |                                        */
    /*                     | 2nd call parent_id=1 matches id=1  root/docs            |                                        */
    /*                     | 3rd call parent_id=1 matches id=1  root/images          |                                        */
    /*                     | 4th call parent_id=2 matches id=2  root/docs/report.txt |                                        */
    /*                     | 5th call parent_id=3 matches id=3  root/images/logo.png |                                        */
    /*                     |                                                         |                                        */
    /*                     | Selects are is responsible for the concatenations       |                                        */
    /*                     |                                                         |                                        */
    /*                     |  1st select       name AS path                          |                                        */
    /*                     |  2nd select       fp.path || '/' || f.name              |                                        */
    /*                     |                                                         |                                        */
    /*                     |  fp.path ||'/'|| f.name updates path on each recursion  |                                        */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    options validvarname=any;
    libname sd1 "d:/sd1";
    data sd1.have;
     input id parent_id  name $10.;
    cards4;
    1 . root
    2 1 docs
    3 2 images
    4 3 report.txt
    5 4 logo.png
    ;;;;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*  SD1.HAVE total obs=5                                                                                                  */
    /*                                                                                                                        */
    /*               parent_                                                                                                  */
    /*  Obs    id       id      name                                                                                          */
    /*                                                                                                                        */
    /*   1      1       .       root                                                                                          */
    /*   2      2       1       docs                                                                                          */
    /*   3      3       2       images                                                                                        */
    /*   4      4       3       report.txt                                                                                    */
    /*   5      5       4       logo.png                                                                                      */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*                    _
    / |  _ __   ___  __ _| |
    | | | `__| / __|/ _` | |
    | | | |    \__ \ (_| | |
    |_| |_|    |___/\__, |_|
                       |_|
    */

    %utl_rbeginx;
    parmcards4;
    library(sqldf)
    library(haven)
    library(zoo)
    source("c:/oto/fn_tosas9x.r")
    have<-read_sas("d:/sd1/have.sas7bdat")
    have
    result<- sqldf("
    WITH RECURSIVE file_paths AS (
      SELECT id, name, parent_id, name AS path
      FROM have
      WHERE parent_id IS NULL

      UNION ALL

      SELECT f.id, f.name, f.parent_id, fp.path || '/' || f.name
      FROM have  f
      JOIN file_paths fp ON f.parent_id = fp.id
    )
    SELECT * FROM file_paths
    ")
    print(result)
    fn_tosas9x(
          inp    = result
         ,outlib ="d:/sd1/"
         ,outdsn ="rwant"
         )
    ;;;;
    %utl_rendx;

    proc print dtaa=sd1.rwant;
    run;quit;


    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* R                                                                                                                      */
    /*                                                             SAS                                                        */
    /*               parent                                                         parent                                    */
    /* id       name id                                    path    id    name       id  path                                  */
    /*                                                                                                                        */
    /*  1       root     NA                                 root    1    root        .   root                                 */
    /*  2       docs      1                            root/docs    2    docs        1   root/docs                            */
    /*  3     images      2                     root/docs/images    3    images      2   root/docs/images                     */
    /*  4 report.txt      3          root/docs/images/report.txt    4    report.txt  3   root/docs/images/report.txt          */
    /*  5   logo.png      4 root/docs/images/report.txt/logo.png    5    logo.png    4   root/docs/images/report.txt/logo.png */
    /*                                                                                                                        */
    /**************************************************************************************************************************/


    /*____               _   _                             _
    |___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
      |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
     ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
    |____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
            |_|    |___/                                |_|
    */

    proc datasets lib=sd1 nolist nodetails;
     delete pywant;
    run;quit;

    %utl_pybeginx;
    parmcards4;
    exec(open('c:/oto/fn_python.py').read());
    have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
    want=pdsql("""
    WITH RECURSIVE file_paths AS (
      SELECT id, name, parent_id, name AS path
      FROM have
      WHERE parent_id IS NULL

      UNION ALL

      SELECT f.id, f.name, f.parent_id, fp.path || '/' || f.name
      FROM have  f
      JOIN file_paths fp ON f.parent_id = fp.id
    )
    SELECT * FROM file_paths
       """);
    print(want);
    fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
    ;;;;
    %utl_pyendx;

    proc print data=sd1.pywant;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*  PYTHONR                                                                                                               */
    /*                                                               SAS                                                      */
    /*  > want                                                                        parent                                  */
    /*                     parent                                                                                             */
    /*     id        name  id                                  path  id  name       id path                                   */
    /*                                                                                                                        */
    /* 0  1.0        root  NaN                                  root  1  root        .  root                                  */
    /* 1  2.0        docs  1.0                             root/docs  2  docs        1  root/docs                             */
    /* 2  3.0      images  2.0                      root/docs/images  3  images      2  root/docs/images                      */
    /* 3  4.0  report.txt  3.0           root/docs/images/report.txt  4  report.txt  3  root/docs/images/report.txt           */
    /* 4  5.0    logo.png  4.0  root/docs/images/report.txt/logo.png  5  logo.png    4  root/docs/images/report.txt/logo.png  */                                                                                                                        */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */






















































































%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
library(zoo)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have

files <- data.frame(
  id = c(1, 2, 3, 4, 5),
  name = c("root", "docs", "images", "report.txt", "logo.png"),
  parent_id = c(NA, 1, 2, 3, 4)
)
files
query <- "
WITH RECURSIVE file_paths AS (
  SELECT id, name, parent_id, name AS path
  FROM have
  WHERE parent_id IS NULL

  UNION ALL

  SELECT f.id, f.name, f.parent_id, fp.path || '/' || f.name
  FROM have  f
  JOIN file_paths fp ON f.parent_id = fp.id
)
SELECT * FROM file_paths
"

result <- sqldf(query)
print(result)
;;;;
%utl_rendx;



fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
library(sf)
library(tidyverse)

set.seed(42)

grid <- tidyr::crossing(lon = seq(0, 1, 0.25), lat = seq(0, 1, 0.25))
data <- tibble::tibble(lon = runif(4), lat = runif(4), y = rnorm(4))
grid
data

grid_sf = st_as_sf(grid , coords =c("lon","lat"))
data_sf = st_as_sf(data , coords =c("lon","lat"))

joined = st_join(grid_sf, data_sf, join = st_nearest_feature)
joined
;;;;
%utl_rendx;








































































%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
library(zoo)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have
nums <- sqldf("
  WITH RECURSIVE
  numbers(n) AS (
    SELECT 1.2
    UNION ALL
    SELECT n + .1 FROM numbers WHERE n < 3.1
  ),
  template as (SELECT n FROM numbers)
  select * from template
")
nums
;;;;
%utl_rendx;


%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
library(zoo)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have
hier <- sqldf("
  WITH RECURSIVE
  numbers(n) AS (
    SELECT 1.2
    UNION ALL
    SELECT n + .1 FROM numbers WHERE n < 3.1
  )
  SELECT n FROM numbers
")
hier
fn_tosas9x(
      inp    = hier
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;


  SELECT * FROM recursive




























  input id$  y1-y3;
  array  ys  y1-y3;
  array xs[3] x1-x3 (1.2, 2.5, 3.1);
  do t=2 to 3;
      xt=xs[t];
      yt=ys[t];
      output;
  end;
  keep xt yt;
cards4;
id1 0.29 0.05 0.96
id2 0.79 0.53 0.45
id3 0.41 0.89 0.68
id4 0.88 0.55 0.57
id5 0.94 0.46 0.10
;;;;
run;quit;


options validvarname=any;
libname sd1 "d:/sd1";
data sd1.have;
  input id$  y1-y3;
  array  ys  y1-y3;
  array xs[3] x1-x3 (1.2, 2.5, 3.1);
  do t=2 to 3;
      xt=xs[t];
      yt=ys[t];
      output;
  end;
  keep xt yt;
cards4;
id1 0.29 0.05 0.96
id2 0.79 0.53 0.45
id3 0.41 0.89 0.68
id4 0.88 0.55 0.57
id5 0.94 0.46 0.10
;;;;
run;quit;
















%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
library(zoo)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have
nums <- sqldf("
  WITH RECURSIVE
  numbers(n) AS (
    SELECT 2001
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 2024
  )
  SELECT n FROM numbers
")
nums
;;;;
%utl_rendx;




want <-sqldf("
select
   substr(sentence,1,instr(sentence,target)-1)            as before
  ,target
  ,substr(sentence,instr(sentence,target)+length(target)) as after
 from
   have
")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
library(sf)
library(tidyverse)

set.seed(42)

grid <- tidyr::crossing(lon = seq(0, 1, 0.25), lat = seq(0, 1, 0.25))
data <- tibble::tibble(lon = runif(4), lat = runif(4), y = rnorm(4))
grid
data

grid_sf = st_as_sf(grid , coords =c("lon","lat"))
data_sf = st_as_sf(data , coords =c("lon","lat"))

joined = st_join(grid_sf, data_sf, join = st_nearest_feature)
joined
;;;;
%utl_rendx;

































%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have
want <-sqldf("
select
   substr(sentence,1,instr(sentence,target)-1)            as before
  ,target
  ,substr(sentence,instr(sentence,target)+length(target)) as after
 from
   have
")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
library(sf)
library(tidyverse)

set.seed(42)

grid <- tidyr::crossing(lon = seq(0, 1, 0.25), lat = seq(0, 1, 0.25))
data <- tibble::tibble(lon = runif(4), lat = runif(4), y = rnorm(4))
grid
data

grid_sf = st_as_sf(grid , coords =c("lon","lat"))
data_sf = st_as_sf(data , coords =c("lon","lat"))

joined = st_join(grid_sf, data_sf, join = st_nearest_feature)
joined
;;;;
%utl_rendx;





ggplot() + geom_sf(data= joined, aes(col = y))+
  geom_sf(data= data_sf, aes(col = y, fill = y),size= 4, shape = 22)


lon   lat
0     0
0     0.25
0     0.5
0     0.75
0     1
0.25  0
0.25  0.25
0.25  0.5
0.25  0.75
0.25  1



     1.2  2.5  3.1
id1 0.29 0.05 0.96
id2 0.79 0.53 0.45
id3 0.41 0.89 0.68
id4 0.88 0.55 0.57
id5 0.94 0.46 0.10



id1 1.2 0.29
id2 1.2 0.79
id3 1.2 0.41
id4 1.2 0.88
id5 1.2 0.94
id1 2.5 0.05
id2 2.5 0.53
id3 2.5 0.89
id4 2.5 0.55
id5 2.5 0.46
id1 3.1 0.96
id2 3.1 0.45
id3 3.1 0.68
id4 3.1 0.57
id5 3.1 0.10


     1.2  2.5  3.1
id1 0.29 0.05 0.96
id2 0.79 0.53 0.45
id3 0.41 0.89 0.68
id4 0.88 0.55 0.57
id5 0.94 0.46 0.10


























%let pgm=utl-split-sentences-based-on-a-column-of-keywords-using--r-and-sql-sas-r-and-python-multi-language;

Split sentences based on a column of keywords using  r and sql sas r and python multi language


     SOLUTIONS  (SQL has bulit in functions no need for R additional languages)

          1 sas sql
          2 r sql
          3 python sql
          4 r requires both dplyr(tidyverse) and stringr languages (mutate, %>% str_extract, regular expressions)
            Uses these regular expressions?
                a ".*(?="
                b "(?<="
                c ")"
                d ").*"

github
https://tinyurl.com/bdzckthw
https://github.com/rogerjdeangelis/utl-split-sentences-based-on-a-column-of-keywords-using--r-and-sql-sas-r-and-python-multi-language

stackoverflow r
https://stackoverflow.com/questions/79104877/split-a-a-text-column-into-two-parts-based-on-a-variable-word-in-r

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

*/ /*********************************************************************************************************************************************/
*/ /*                                       |                                                                    |                             */
*/ /* SPLIT A SENTECE USING A TARGET WORD   |                                                                    |                             */
*/ /* ===================================   |                                                                    |                             */
*/ /*                                       |                                                                    |                             */
*/ /*           INPUT                       |                PROCESS                                             |                             */
*/ /*                                       |    (VERY SIMILAR IN SAS R & PYTHON)                                |                             */
*/ /*                                       |                                                                    |                             */
*/ /*                                       | SAS R & PYTHON                                                     |                             */
*/ /*                                       |                                                                    |                             */
*/ /*  TARGET         SENTENCE              | select                                                             | before    target    after   */
*/ /*                                       |    substr(sentence,1,instr(sentence,target)-1)            as before|                             */
*/ /*  aspirin  walgreens aspirin 2.50 $ us |   ,                                                       target   | walgreens aspirin 2.50 $ us */
*/ /*  APC      rexall APC 1.50 $ us        |   ,substr(sentence,instr(sentence,target)+length(target)) as after | rexall    APC     1.50 $ us */
*/ /*  advil    cvs advil 3.50 $ us         |  from                                                              | cvs       advil   3.50 $ us */
*/ /*                                       |    have                                                            |                             */
*/ /*                                       |                                                                    |                             */
*/ /*                                       |  R                                                                 |                             */
*/ /*                                       |                                                                    |                             */
*/ /*                                       |  want <- have %>%                                                  |                             */
*/ /*                                       |   mutate(                                                          |                             */
*/ /*                                       |    before=str_extract(sentence,paste0(".*(?=",target,")")),        |                             */
*/ /*                                       |    after=str_extract(sentence,paste0("(?<=",target,").*"))         |                             */
*/ /*                                       |    )                                                               |                             */
*/ /*                                       |                                                                    |                             */
*/ /*********************************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/
/* all possible cases each date repeated onece */
options validvarname=any;
libname sd1 "d:/sd1";
data sd1.have;
 input target$ sentence & $64.;
cards4;
aspirin   walgreens aspirin 2.50 $ us
APC       rexall APC 1.50 $ us
advil     cvs advil 3.50 $ us
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  SD1.HAVE total obs=3                                                                                                  */
/*                                                                                                                        */
/*   TARGET            SENTENCE                                                                                           */
/*                                                                                                                        */
/*   aspirin     walgreens aspirin 2.50 $ us                                                                              */
/*   APC         rexall APC 1.50 $ us                                                                                     */
/*   advil       cvs advil 3.50 $ us                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/
proc sql;
  create table split_result as
  select
    target
    ,findw(sentence, trim(target))                     as pos
    ,substr(sentence, 1, calculated pos - 1)           as before
    ,substr(sentence, calculated pos + length(target)) as after
  from sd1.have;
quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WORK.WANT                                                                                                             */
/*                                                                                                                        */
/*    target     pos    before         after                                                                              */
/*                                                                                                                        */
/*    aspirin     11    walgreens    2.50 $ us                                                                            */
/*    APC          8    rexall       1.50 $ us                                                                            */
/*    advil        5    cvs          3.50 $ us                                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

%utl_rbeginx;
parmcards4;
library(sqldf)
library(haven)
source("c:/oto/fn_tosas9x.r")
have<-read_sas("d:/sd1/have.sas7bdat")
have
want <-sqldf("
select
   substr(sentence,1,instr(sentence,target)-1)            as before
  ,target
  ,substr(sentence,instr(sentence,target)+length(target)) as after
 from
   have
")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*   R                                    SAS                                                                             */
/*                                                                                                                        */
/*   > want                                                                                                               */
/*         before  target      after      rownames    before       target       after                                     */
/*                                                                                                                        */
/*   1 walgreens  aspirin  2.50 $ us          1       walgreens    aspirin    2.50 $ us                                   */
/*   2    rexall      APC  1.50 $ us          2       rexall       APC        1.50 $ us                                   */
/*   3       cvs    advil  3.50 $ us          3       cvs          advil      3.50 $ us                                   */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*____               _   _                             _
|___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
want=pdsql("""
 select
    substr(sentence,1,instr(sentence,target)-1)            as before
   ,target
   ,substr(sentence,instr(sentence,target)+length(target)) as after
 from
    have
   """);
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*   R                                    SAS                                                                             */
/*                                                                                                                        */
/*   > want                                                                                                               */
/*         before    target       after   before       target       after                                                 */
/*                                                                                                                        */
/*   0  walgreens   aspirin   2.50 $ us   walgreens    aspirin    2.50 $ us                                               */
/*   1     rexall       APC   1.50 $ us   rexall       APC        1.50 $ us                                               */
/*   2        cvs     advil   3.50 $ us   cvs          advil      3.50 $ us                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*  _            _   _     _
| || |    _ __  | |_(_) __| |_   ___   _____ _ __ ___  ___
| || |_  | `__| | __| |/ _` | | | \ \ / / _ \ `__/ __|/ _ \
|__   _| | |    | |_| | (_| | |_| |\ V /  __/ |  \__ \  __/
   |_|   |_|     \__|_|\__,_|\__, | \_/ \___|_|  |___/\___|
                             |___/
*/

%utl_rbeginx;
parmcards4;
library(stringr)
library(tidyverse)
library(haven)
source("c:/oto/fn_tosas9x.r")
set.seed(1)
have<-read_sas("d:/sd1/have.sas7bdat")
have;
want <- have %>%
  mutate(
    before = str_extract(sentence, paste0(".*(?=", target, ")")),
    after = str_extract(sentence, paste0("(?<=", target, ").*"))
  )
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rrwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rrwant;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*   R                                    SAS                                                                             */
/*                                                                                                                        */
/*   > want                                                                                                               */
/*     target  sentence                    before       after            target      before         after                 */
/*     <chr>   <chr>                       <chr>        <chr>                                                             */
/*   1 aspirin walgreens aspirin 2.50 $ us "walgreens " " 2.50 $ us"     aspirin     walgreens    2.50 $ us               */
/*   2 APC     rexall APC 1.50 $ us        "rexall "    " 1.50 $ us"     APC         rexall       1.50 $ us               */
/*   3 advil   cvs advil 3.50 $ us         "cvs "       " 3.50 $ us"     advil       cvs          3.50 $ us               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
