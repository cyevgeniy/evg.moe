---
title: 'Oracle: nvl is not lazy'
tags: ['oracle', 'sql', 'plsql']
date: 2024-09-02
---

<!-- Originally written 2021-07-11 -->

We all use `nvl`.
It's so common and easy(3 chars among 8 in `coalesce` and 6 in `decode`)
to write it in queries, but there is one thing you should keep in mind when
using `NVL`.

First, let's face the problem:

```sql
create package test_pck is

    function get_user_id return number;
end;
/

create or replace package body test_pck is

    function get_user_id return number
    is
        l_res number;
    begin
        <<lbl>>
        if 1 < 2 then
            goto lbl;
        end if;    end;
end;
/
```

Here we have created a package with a function that
never returns a value, because it contains an infinity loop.

I picked this method for demonstration to be sure that
examples will show you the same result despite IDE
and environment settings you have.

So, let's run this query:

```sql
select nvl(1, test_pck.get_user_id)
from dual
```

**It has hung**.

<div class="note shadow">

It tells us that  the `test_pck.get_user_id`
function was called despite the fact that the first parameter is 1,
**which is not `null`**.

</div>

Generally, it's not a problem. But it may be, if
your second argument in `nvl` is
a heavy function. In this case SQL query might
work slower than you expect.

Do all functions that work with null values
work the same? Let's see:

**COALESCE:**

```sql
-- Lazy
select coalesce(1, test_pck.get_user_id)
from dual
```

**DECODE:**

```sql
-- Lazy
select decode(1, 1, 1, test_pck.get_user_id)
from dual
```

**CASE:**

```sql
-- Lazy
select case
           when 1 = 1 then 1
           else test_pck.get_user_id
       end
from dual
```

We forgot about nvl's brother - **NVL2**

```sql
-- Not Lazy
select nvl2(1, 2, test_pck.get_user_id)
from dual
```


Yes, it's not lazy, like `nvl`.


### What to choose


![nvl meme](/img/nvl-meme-1.jpg)


I think it's not a problem when you use
`nvl` with "static" values. But
if you use functions as one (or both) arguments
to nvl, it's better **to replace it with a call to
something lazier**.


![nvl meme](/img/nvl-meme-2.jpg)
