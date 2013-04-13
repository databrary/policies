dnl This file is used to automatically generate all the permission forms with:
dnl    make md
dnl It uses some conditional macros:
dnl    HEALTH(text for health release[,text for recordings])
dnl    ADULT(text for adult[,text for minor/child])
dnl    MINOR(text for minor[,text for adult/child])
dnl    CHILD(text for child[,text for adult/minor])
dnl    PICK(text for adult,text for minor,text for child)
dnl If the text contains a comma, you must enclose it in `quotes'
dnl Single quotes inside quoted text must be unquoted:  `a''`b' => a'b
dnl
changecom()dnl
define(`PICK',dnl
ifelse(dnl
TYPE,`adult',`$1',dnl
TYPE,`minor',`$2',dnl
TYPE,`minor12-17',`$2',dnl
TYPE,`child',`$3',dnl
TYPE,`all',`{$1/$2/$3}',dnl
`errprint(`Unknown TYPE: must be adult, minor, or child
')m4exit(1)'))dnl
define(`ADULT',PICK(`$1',`$2',`$2'))dnl
define(`MINOR',PICK(`$2',`$1',`$2'))dnl
define(`CHILD',PICK(`$2',`$2',`$1'))dnl
define(`CHILDS',CHILD(child's))dnl
define(`HEALTH',ifdef(`HEALTH',`$1',`$2'))dnl
