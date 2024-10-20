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
